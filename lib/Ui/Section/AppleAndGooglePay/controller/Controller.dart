import 'dart:io';

import 'package:ataa/Core/Error/error.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

import '../../../../Data/data.dart';

class AppleAndGooglePayController extends GetxController {
  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxBool isDone = false.obs;
  RxBool isDisabled = false.obs;
  Function? onTapDisabledCallback;
  PaymentConfiguration? applePayConfig;
  PaymentConfiguration? googlePayConfig;
  Rx<String> token = Rx<String>('');
  Rx<List<PaymentItem>> paymentItems = Rx<List<PaymentItem>>([]);
  Rx<ErrorX?> error = Rx<ErrorX?>(null);
  RxBool initError = false.obs;
  Function? onTapCallback;
  Function(dynamic error)? onErrorCallback;
  Function? onCancelCallback;
  Function(String token)? onPayDoneCallback;

  final String description = 'Dialogue Corner - Ataa Portal';
  double amount = 1;
  //============================================================================
  // Functions

  createPaymentItems([double? price]) {
    if (price != null && price >= 1) {
      amount = price;
    }

    paymentItems.value = [
      PaymentItem(
        label: description,
        amount: amount.toString(),
        status: PaymentItemStatus.final_price,
      ),
    ];
  }

  void onTap() {
    error.value = null;
    if (paymentItems.value.isNotEmpty) {
      isLoading.value = true;
      onTapCallback?.call();
    } else {
      error.value = ErrorX(message: 'There are no payment items.');
    }
  }

  void onError(dynamic error) {
    this.error.value = null;
    if (error is PlatformException && error.code != 'paymentCanceled') {
      this.error.value = error.toErrorX;
      error.toErrorX.log();
      if (onErrorCallback != null) {
        onErrorCallback!(error);
      }
    }
    onCancel();
  }

  void onCancel() {
    isLoading.value = false;
    onCancelCallback?.call();
  }

  Future<void> init({required double total}) async {
    isLoading.value = true;
    error.value = null;
    initError.value = false;
    try {
      amount = total >= 1 ? total : 1;
      createPaymentItems();
      applePayConfig = await PaymentConfiguration.fromAsset(
        'paymentConfiguration/apple_pay_config.json',
      );
      googlePayConfig = await PaymentConfiguration.fromAsset(
        'paymentConfiguration/google_pay_config.json',
      );
    } catch (e) {
      error.value = e.toErrorX;
      e.toErrorX.log();
    }
    if ((Platform.isIOS && applePayConfig == null) ||
        (Platform.isAndroid && googlePayConfig == null)) {
      initError.value = true;
    }
    isLoading.value = false;
  }

  void onApplePayResult(paymentResult) async {
    try {
      isDone.value = true;
      paymentItems.value = [];
      token.value = (paymentResult[NameX.appleToken] ?? '').toString();
      await onPayDoneCallback?.call(token.value);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toErrorX;
    }
  }

  void onGooglePayResult(paymentResult) async {
    try {
      isDone.value = true;
      paymentItems.value = [];
      token.value = (paymentResult['paymentMethodData']['tokenizationData']
                  ['token'] ??
              '')
          .toString();
      await onPayDoneCallback?.call(token.value);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toErrorX;
    }
  }
}
