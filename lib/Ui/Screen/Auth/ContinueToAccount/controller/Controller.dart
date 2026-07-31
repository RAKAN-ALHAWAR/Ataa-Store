import 'dart:async';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Data/data.dart';
import '../../../../Widget/widget.dart';
import '../../OTP/view/View.dart';

class ContinueToAccountController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ErrorX?> error = Rx<ErrorX?>(null);
  bool isSheet = false;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  bool isFromQuickDonation = Get.arguments?[NameX.isFromQuickDonation] ?? false;

  RxInt countryCode =
      ((Get.arguments is Map ? (Get.arguments?[NameX.countryCode] ?? 966) : 966)
              as int)
          .obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController phone = TextEditingController();

  //============================================================================
  // Functions

  onChangeCountryCode(String code) => countryCode.value = int.parse(code);

  onGuest() {
    if (isLoading.isFalse) {
      LocalDataX.put(LocalKeyX.route, RouteNameX.root);
      Get.offAllNamed(RouteNameX.root);
    }
  }

  onTapError() {
    if (error.value?.details[NameX.errors][NameX.isContactUs] ?? false) {
      Get.toNamed(RouteNameX.contactUs);
    }
  }

  Future<void> onLogin() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        String massage = '';
        try {
          massage = await loginByPhone() ?? '';
          if (massage.isNotEmpty) {
            ToastX.success(message: massage);
          }
        } catch (e) {
          error.value = e.toErrorX;
          error.value!.log();
          buttonState.value = ButtonStateEX.failed;
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
            buttonState.value = ButtonStateEX.normal;
          },
        );
      } else {
        autoValidate = AutovalidateMode.always;
      }
    }
  }

  Future<String?> loginByPhone() async {
    String? massage = await DatabaseX.loginByPhone(
      phone: phone.text.toIntX,
      countryCode: countryCode.value,
    );

    /// The time delay here is aesthetically beneficial
    buttonState.value = ButtonStateEX.success;
    await Future.delayed(const Duration(seconds: StyleX.successButtonSecond));

    /// create otp object
    OtpX otp = OtpX(
      phone: phone.text.toIntX,
      countryCode: countryCode.value,
      isLogin: true,
      isPhone: true,
      isFromQuickDonation: isFromQuickDonation,
    );

    /// go to otp screen
    if (isSheet) {
      Get.back();
      await bottomSheetX(
        child: OTPView(isSheet: true, otp: otp).paddingOnly(top: 14),
      );
      return null;
    } else {
      Get.toNamed(RouteNameX.otp, arguments: {NameX.otp: otp});
      return massage;
    }
  }
}
