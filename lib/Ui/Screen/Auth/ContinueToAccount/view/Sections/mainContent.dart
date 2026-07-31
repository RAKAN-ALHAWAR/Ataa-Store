import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Animation/animation.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class MainContentLoginX extends GetView<ContinueToAccountController> {
  const MainContentLoginX({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: Column(
          children: [
            /// Title
            TextX(
              'Continue to the account',
              style: TextStyleX.headerMedium,
              color: Theme.of(context).primaryColor,
            ).marginOnly(bottom: 10).fadeAnimation200,

            /// Subtitle
            TextX(
              'Welcome! Enter your mobile number to continue to your account',
              color: Theme.of(context).colorScheme.secondary,
              textAlign: TextAlign.center,
            ).marginOnly(bottom: 32).fadeAnimation200,

            /// Error Message
            if (controller.error.value != null)
              GestureDetector(
                onTap: controller.onTapError,
                child: MessageCardX(
                  message: controller.error.value?.message,
                  isError: true,
                ),
              ).marginOnly(bottom: 14).fadeAnimation200,

            /// Input Fields
            Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidate,
              child: PhoneFieldX(
                label: "Mobile Number",
                controller: controller.phone,
                onChangeCountryCode: controller.onChangeCountryCode,
                countryCode: controller.countryCode.value,
                isDisableChangeCountryCode:
                    !controller.app.generalSettings.isShowCountryCodeList,
              ).fadeAnimation300,
            ).marginOnly(bottom: 20),

            /// Button Login
            ButtonStateX(
              onTap: controller.onLogin,
              state: controller.buttonState.value,
              text: 'Continue',
            ).fadeAnimation400,

            /// Button visitor
            if (!controller.isSheet && !controller.isFromQuickDonation)
              ButtonX.second(
                onTap: controller.onGuest,
                text: 'Browse the platform as a visitor',
              ).marginOnly(top: 5).fadeAnimation500,
            const SizedBox(height: 25.0),

            /// Agree to the terms of use
            RichText(
              text: TextSpan(
                text: "${'By using the app, you agree to the'.tr} ",
                style: TextStyleX.supTitleLarge.copyWith(
                  color: Get.theme.colorScheme.secondary,
                  fontFamily: FontX.fontFamily,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "${'terms and conditions'.tr} ",
                    style: TextStyleX.supTitleLarge.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontFamily: FontX.fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RouteNameX.termsConditions);
                      },
                  ),
                ],
              ),
            ).fadeAnimation600,
          ],
        ),
      ),
    );
  }
}
