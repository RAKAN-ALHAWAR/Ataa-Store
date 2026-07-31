import 'dart:io';
import 'package:ataa/Data/data.dart';
import 'package:ataa/UI/Widget/widget.dart';
import 'package:ataa/Ui/Section/AppleAndGooglePay/controller/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

import '../../../../Config/config.dart';

class AppleAndGooglePaySectionX extends StatelessWidget {
  AppleAndGooglePaySectionX({
    super.key,
    this.margin,
    AppleAndGooglePayController? controller,
  }) {
    this.controller = controller ?? Get.put(AppleAndGooglePayController());
  }

  final EdgeInsets? margin;
  late final AppleAndGooglePayController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.error.value == null && controller.initError.isFalse) {
          return Container(
            height: StyleX.buttonHeight,
            margin: const EdgeInsets.only(top: 15.0),
            padding: margin ?? EdgeInsets.zero,
            child: Platform.isIOS
                ? GestureDetector(
                    onTap: () => controller.onTapDisabledCallback?.call(),
                    child: AbsorbPointer(
                      absorbing: controller.isDisabled.value,
                      child: ApplePayButton(
                        paymentConfiguration: controller.applePayConfig!,
                        paymentItems: controller.paymentItems.value,
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.buy,
                        cornerRadius: StyleX.radius,
                        height: StyleX.buttonHeight,
                        width: double.maxFinite,
                        onPaymentResult: controller.onApplePayResult,
                        onError: controller.onError,
                        onPressed: controller.onTap,
                        buttonProvider: PayProvider.apple_pay,
                        childOnError: const SizedBox(),
                        loadingIndicator: ButtonStateX(
                          marginVertical: 0,
                          state: ButtonStateEX.loading,
                          onTap: () {},
                        ),
                      ),
                    ),
                  )
                : Platform.isAndroid
                    ? GestureDetector(
                        onTap: () => controller.onTapDisabledCallback?.call(),
                        child: AbsorbPointer(
                          absorbing: controller.isDisabled.value,
                          child: GooglePayButton(
                            paymentConfiguration: controller.googlePayConfig!,
                            paymentItems: controller.paymentItems.value,
                            theme: GooglePayButtonTheme.dark,
                            type: GooglePayButtonType.pay,
                            height: StyleX.buttonHeight,
                            onPaymentResult: controller.onGooglePayResult,
                            width: double.maxFinite,
                            cornerRadius: StyleX.radius.toInt(),
                            buttonProvider: PayProvider.google_pay,
                            onError: controller.onError,
                            onPressed: controller.onTap,
                            childOnError: const SizedBox(),
                            loadingIndicator: ButtonStateX(
                              marginVertical: 0,
                              state: ButtonStateEX.loading,
                              onTap: () {},
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
