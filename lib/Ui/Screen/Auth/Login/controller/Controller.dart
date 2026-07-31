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
import '../../SignUp/view/View.dart';

class LoginController extends GetxController {
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

  RxBool isPhone = true.obs;
  RxInt countryCode =
      ((Get.arguments is Map ? (Get.arguments?[NameX.countryCode] ?? 966) : 966)
              as int)
          .obs;
  final loginVia = ValueNotifier(1);

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController phone = TextEditingController(
    text: Get.arguments is Map ? Get.arguments[NameX.phone] : '',
  );
  TextEditingController email = TextEditingController();

  //============================================================================
  // Functions

  onChangeCountryCode(String code) => countryCode.value = int.parse(code);

  onSignUp() async {
    if (isLoading.isFalse) {
      error.value = null;
      if (isSheet) {
        Get.back();

        /// to close login sheet
        await bottomSheetX(
          child: SignUpView(isSheet: true).paddingOnly(top: 14),
        );
      } else if (Get.previousRoute == RouteNameX.signUp) {
        Get.back();

        /// if sign up is open on background so just back to show it
      } else {
        Get.toNamed(
          RouteNameX.signUp,
          arguments: {NameX.isFromQuickDonation: isFromQuickDonation},
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
          if (isPhone.value) {
            massage = await loginByPhone() ?? '';
          } else {
            massage = await loginByEmail() ?? '';
          }
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

  Future<String?> loginByEmail() async {
    String? massage = await DatabaseX.loginByEmail(email: email.text.trim());

    /// The time delay here is aesthetically beneficial
    buttonState.value = ButtonStateEX.success;
    await Future.delayed(const Duration(seconds: StyleX.successButtonSecond));

    Get.toNamed(
      RouteNameX.otp,
      arguments: {
        NameX.otp: OtpX(
          email: email.text.trim(),
          isLogin: true,
          isPhone: false,
          isFromQuickDonation: isFromQuickDonation,
        ),
      },
    );
    return massage;
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();

    /// listener if change tap for login by phone or email
    loginVia.addListener(() {
      isPhone.value = loginVia.value == 1;
    });
  }
}
