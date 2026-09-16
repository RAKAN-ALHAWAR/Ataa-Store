import 'dart:async';
import 'dart:io';

import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Data/Enum/payment_method_status.dart';
import 'package:ataa/Data/Model/Deduction/deduction.dart';
import 'package:ataa/Data/Model/PaymentCard/paymentCardForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Config/config.dart';
import '../../../../../Data/Enum/payment_status_status.dart';
import '../../../../../Data/Model/PaymentTransaction/paymentTransaction.dart';
import '../../../../../Data/Model/PaymentTransaction/paymentTransactionForm.dart';
import '../../../../../Data/data.dart';
import '../../../../Section/PreSavedPaymentCards/controller/Controller.dart';

class DeductionPaymentController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app =Get.find();
  final PreSavedPaymentCardsController preSavedPaymentCardsController =
      Get.put(PreSavedPaymentCardsController(), tag: 'DeductionPayment');
  // late final AppleAndGooglePayController appleAndGooglePayController = Get.put(
  //   AppleAndGooglePayController()
  //     ..onPayDoneCallback = onPayByAppleOrGoogle
  //     ..onTapCallback = onTapAppleAndGooglePay,
  //   tag: 'DeductionPayment-AppleAndGooglePay',
  // );
  //============================================================================
  // Variables

  RxBool isInit = false.obs;
  RxBool isLoading = false.obs;
  Rx<ErrorX?> error = Rx<ErrorX?>(null);
  DeductionX deduction = Get.arguments[0];
  double price = Get.arguments[1];
  Rx<ButtonStateEX> buttonState = Rx<ButtonStateEX>(ButtonStateEX.normal);
  final ScrollController scrollController = ScrollController();

  //============================================================================
  // Functions

  Future<void> getData() async {
    // await appleAndGooglePayController.init(
    //   title: 'Deduction',
    //   total: price,
    // );
    await preSavedPaymentCardsController.getData();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  void onTapAppleAndGooglePay() {
    error.value=null;
  }

  get isShowAppleAndGooglePay =>(Platform.isAndroid && app.generalPaymentMethodsSettings.isGooglePay) || (Platform.isIOS && app.generalPaymentMethodsSettings.isApplePay);
  get isShowPaymentCard =>app.generalPaymentMethodsSettings.isCreditCards;

  onPayByAppleOrGoogle(String token) async {
    try {
      PaymentTransactionFormX form = PaymentTransactionFormX(
        price: price,
        paymentMethod: Platform.isIOS ? PaymentMethodStatusX.applePay : PaymentMethodStatusX.googlePay,
        applePayToken: Platform.isIOS ? token : null,
        googlePayToken: Platform.isIOS ? null : token,
      );
      await sendPayToServer(form: form);
    } catch (e) {
      e.toErrorX.log();
      error.value = e.toErrorX;
    }
  }
  sendPayToServer({required PaymentTransactionFormX form}) async {
    PaymentTransactionX paymentTransaction =
    await DatabaseX.createPaymentTransactionForDeduction(
      form: form,
      deductionId: deduction.id,
    );
    if (paymentTransaction.verificationUrl != null) {
      dynamic result = await Get.toNamed(
        RouteNameX.verificationUrl,
        arguments: [paymentTransaction.verificationUrl,paymentTransaction.callbackUrl??paymentTransaction.paymentDataCreditCard?.callbackUrl??'null'],
      );
      if (result is! String) {
        throw ErrorX(message: 'Payment was not verified, try again.');
      }else{
        var x =await DatabaseX.getPaymentTransaction(paymentTransactionId: paymentTransaction.id);
        paymentTransaction.status = x.status;
      }
    }
    if (paymentTransaction.status != PaymentStatusStatusX.paid && paymentTransaction.status != PaymentStatusStatusX.initiated) {
      throw ErrorX(message: 'We apologize, but an error occurred while processing your payment. Please check your payment information and try again.');
    }else{
      Get.offAndToNamed(
          RouteNameX.paymentSuccessful,
          arguments: paymentTransaction,
          result: true
      );
    }
  }

  onPay() async {
    if (isLoading.isFalse) {
      try {
        preSavedPaymentCardsController.validate();
        if (preSavedPaymentCardsController.validate()) {
          error.value = null;
          isLoading.value = true;
          buttonState.value = ButtonStateEX.loading;

          PaymentTransactionFormX form = PaymentTransactionFormX(
            price: price,
            paymentMethod: PaymentMethodStatusX.creditCard,
            paymentCardId:
                preSavedPaymentCardsController.paymentCardSelected.value?.id,
            paymentCard: preSavedPaymentCardsController
                        .paymentCardSelected.value ==
                    null
                ? PaymentCardFormX(
                    name: preSavedPaymentCardsController.name.text,
                    cardNum: preSavedPaymentCardsController
                        .cardNum.text.removeAllWhitespace,
                    month: int.parse(preSavedPaymentCardsController.date.text
                        .split(RegExp(r'(/)'))[0]),
                    year: int.parse(preSavedPaymentCardsController.date.text
                        .split(RegExp(r'(/)'))[1]),
                    cvv: preSavedPaymentCardsController.cvv.text.trim(),
                    isDefault: false)
                : null,
            isSavePaymentCard:
                preSavedPaymentCardsController.paymentCardSelected.value == null
                    ? preSavedPaymentCardsController.isSaveForLater.value
                    : null,
          );
          await sendPayToServer(form: form);
        }
      } catch (e) {
        e.toErrorX.log();
        error.value = e.toErrorX;
        scrollToTop();
        buttonState.value = ButtonStateEX.failed;
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
        buttonState.value = ButtonStateEX.normal;
      });
    }
  }
}
