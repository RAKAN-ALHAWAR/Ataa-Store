import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../Animation/animation.dart';
import '../../../../../Widget/Package/otp_pin_field_widget/otp_pin_field.dart';
import '../../controller/Controller.dart';

class MainContentOtpX extends GetView<OTPController> {
  const MainContentOtpX({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: Column(
          children: [
            /// Title
            TextX(
              controller.getTitle(),
              style: TextStyleX.headerMedium,
              color: Theme.of(context).primaryColor,
            ).fadeAnimation200,
            const SizedBox(height: 10.0),

            /// Subtitle
            TextX(
              controller.getSubTitle(),
              color: Theme.of(context).colorScheme.secondary,
              textAlign: TextAlign.center,
            ).fadeAnimation200,
            const SizedBox(height: 32.0),

            /// Error Message
            if (controller.error.value != null)
              GestureDetector(
                onTap: controller.onTapError,
                child: MessageCardX(
                  message: controller.error.value?.message,
                  isError: true,
                ),
              ).marginOnly(bottom: 14).fadeAnimation200,

            /// Code Field
            Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidate,
              child: Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpPinField(
                      key: controller.otpKey,
                      fieldHeight: 55,
                      fieldWidth: 55,
                      textInputAction: TextInputAction.done,
                      maxLength: 4,
                      showCursor: true,
                      cursorColor: ColorX.primary,
                      cursorWidth: 2,
                      mainAxisAlignment: MainAxisAlignment.center,
                      otpPinFieldDecoration: OtpPinFieldDecoration.custom,
                      onChange: (val) {
                        if (val.length == 4) {
                          controller.otpCode.text = val;
                          controller.isDoneInput.value = true;
                        } else {
                          controller.otpCode.text = '';
                          controller.isDoneInput.value = false;
                        }
                      },
                      otpPinFieldStyle: OtpPinFieldStyle(
                        showHintText: false,
                        defaultFieldBackgroundColor:
                            Theme.of(context).cardTheme.color ??
                                Colors.transparent,
                        activeFieldBackgroundColor:
                            Theme.of(context).cardTheme.color ??
                                Colors.transparent,
                        activeFieldBorderColor: ColorX.primary,
                        fieldBorderRadius: 8,
                        defaultFieldBorderColor: Theme.of(context).dividerColor,
                        fieldBorderWidth: StyleX.borderWidth,
                        fieldPadding: 16,
                        textStyle:
                            TextStyleX.titleMedium.copyWith(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            ).fadeAnimation400,
            const SizedBox(height: 20.0),

            /// Verify Button
            ButtonStateX(
              onTap: controller.onVerify,
              state: controller.buttonState.value,
              text: 'Verify',
              disabled: controller.isDoneInput.isFalse,
              colorDisabledButton: context.isDarkMode
                  ? ColorX.primary.shade300.withValues(alpha: 0.2)
                  : ColorX.primary.withValues(alpha: 0.4),
              colorDisabledBorder: Colors.transparent,
              colorDisabledText:
                  context.isDarkMode ? Colors.white38 : Colors.white,
            ).fadeAnimation400,
            const SizedBox(height: 25.0),

            /// Resend Code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Title
                TextX(
                  "Didn't receive the code?",
                  color: Theme.of(context).colorScheme.secondary,
                  style: TextStyleX.titleMedium,
                ),
                const SizedBox(width: 5),

                /// Resend Loading
                if (controller.isLoadingResendAgain.value)
                  Container(
                    width: 15,
                    height: 15,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                /// Resend Button
                if (controller.isResendAgain.value &&
                    !controller.isLoadingResendAgain.value)
                  InkWell(
                    onTap: controller.onResend,
                    borderRadius: BorderRadius.circular(StyleX.radius),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 1.0,
                        horizontal: 5,
                      ),
                      child: TextX(
                        "Resend code",
                        color: Theme.of(context).primaryColor,
                        style: TextStyleX.titleMedium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                /// Resend Time
                if (!controller.isResendAgain.value &&
                    !controller.isLoadingResendAgain.value)
                  Row(
                    children: [
                      TextX(
                        "( ",
                        color: Theme.of(context).colorScheme.secondary,
                        style: TextStyleX.titleMedium,
                      ),
                      TextX(
                        FunctionX.formatTime(controller.start.value),
                        style: TextStyleX.titleMedium,
                        color: ColorX.danger.shade400,
                      ),
                      TextX(
                        " )",
                        color: Theme.of(context).colorScheme.secondary,
                        style: TextStyleX.titleMedium,
                      ),
                    ],
                  ),
              ],
            ).fadeAnimation600,
          ],
        ),
      ),
    );
  }
}
