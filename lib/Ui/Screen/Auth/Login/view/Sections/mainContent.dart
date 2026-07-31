import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../Animation/animation.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class MainContentLoginX extends GetView<LoginController> {
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
              'Log in',
              style: TextStyleX.headerMedium,
              color: Theme.of(context).primaryColor,
            ).marginOnly(bottom: 10).fadeAnimation200,

            /// Subtitle
            TextX(
              'Welcome back, Sign in to your account',
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

            /// Select registration method tab
            if (controller.app.generalSettings.isShowRegisterEmail)
              TabSegmentX(
                controller: controller.loginVia,
                tabs: {1: 'Via Mobile'.tr, 2: 'Via Email'.tr},
              ).fadeAnimation400.marginOnly(bottom: 20),

            /// Input Fields
            Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.isPhone.value)
                    PhoneFieldX(
                      label: "Mobile Number",
                      controller: controller.phone,
                      onChangeCountryCode: controller.onChangeCountryCode,
                      countryCode: controller.countryCode.value,
                      isDisableChangeCountryCode:
                          !controller.app.generalSettings.isShowCountryCodeList,
                    ).fadeAnimation400,
                  if (!controller.isPhone.value)
                    TextFieldX(
                      label: "Email",
                      controller: controller.email,
                      validate: ValidateX.email,
                      hint: 'name@example.com',
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ).marginSymmetric(vertical: 2).fadeAnimation400,
                ],
              ),
            ).marginOnly(bottom: 20),

            /// Button Login
            ButtonStateX(
              onTap: controller.onLogin,
              state: controller.buttonState.value,
              text: 'Log in',
            ).fadeAnimation600,

            /// Button visitor
            if (!controller.isSheet)
              ButtonX.second(
                onTap: controller.onGuest,
                text: 'Browse the platform as a visitor',
              ).marginOnly(top: 5).fadeAnimation800,
            const SizedBox(height: 25.0),

            /// Text Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextX(
                  "Don't have an account?",
                  color: Theme.of(context).colorScheme.secondary,
                  style: TextStyleX.titleSmall,
                ),
                InkWell(
                  onTap: controller.onSignUp,
                  borderRadius: BorderRadius.circular(StyleX.radius),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 1.0,
                      horizontal: 5,
                    ),
                    child: TextX(
                      "Create an account",
                      color: Theme.of(context).primaryColor,
                      style: TextStyleX.titleSmall,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ).fadeAnimation800,
          ],
        ),
      ),
    );
  }
}
