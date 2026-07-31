import 'dart:async';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Screen/Auth/Login/controller/Controller.dart';
import '../../../../../UI/Screen/Auth/Login/view/loginView.dart';
import '../../../../Widget/widget.dart';
import '../../OTP/view/View.dart';

class SignUpController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ErrorX?> error = Rx<ErrorX?>(null);
  bool isSheet = false;
  bool isFromQuickDonation = Get.arguments?[NameX.isFromQuickDonation] ?? false;

  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  int countryCode = 966;
  RxBool agreedTerms = true.obs;

  //============================================================================
  // Functions

  onChangeAgreedTerms(val) => agreedTerms.value = val;

  onChangePhone(val) => countryCode = int.parse(val);

  onLogin() {
    if (isLoading.isFalse) {
      error.value = null;
      autoValidate = AutovalidateMode.disabled;
      if (isSheet) {
        Get.back();
        bottomSheetX(child: LoginView(isSheet: true).paddingOnly(top: 14));
      } else if (Get.previousRoute == RouteNameX.login) {
        Get.back();
        Get.find<LoginController>()
          ..phone.text = phone.text
          ..countryCode.value = countryCode;
      } else {
        Get.toNamed(
          RouteNameX.login,
          arguments: {
            NameX.phone: phone.text,
            NameX.countryCode: countryCode,
            NameX.isFromQuickDonation: isFromQuickDonation,
          },
        );
      }
    }
  }

  onGuest() {
    if (isLoading.isFalse) {
      LocalDataX.put(LocalKeyX.route, RouteNameX.root);
      Get.offAllNamed(RouteNameX.root);
    }
  }

  onTapError() {
    if (error.value?.details[NameX.errors]?[NameX.isAccountAlreadyExists] ??
        false) {
      onLogin();
    }
  }

  Future<void> onSignUp() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        try {
          /// Connect to the database to create the account
          String? massage = await DatabaseX.signUp(
            name: name.text.trim(),
            phone: phone.text.toIntX,
            countryCode: countryCode,
          );

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          if (massage != null && massage.isNotEmpty) {
            ToastX.success(message: massage);
          }

          /// create otp object
          OtpX otp = OtpX(
            phone: phone.text.toIntX,
            countryCode: countryCode,
            isLogin: false,
            isPhone: true,
            isFromQuickDonation: isFromQuickDonation,
          );

          /// go to otp screen
          if (isSheet) {
            Get.back(); // close sign up sheet
            bottomSheetX(
              child: OTPView(isSheet: true, otp: otp).paddingOnly(top: 14),
            );
          } else {
            Get.toNamed(RouteNameX.otp, arguments: {NameX.otp: otp});
          }
        } catch (e) {
          error.value = e.toErrorX;
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
}
