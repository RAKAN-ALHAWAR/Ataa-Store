import 'dart:async';
import 'package:ataa/Core/Controller/Cart/cartGeneralController.dart';
import 'package:ataa/Ui/Screen/Basic/Root/controller/Controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../ScreenSheet/Other/AccountCreated/accountCreatedSheet.dart';
import '../../../../Widget/Package/otp_pin_field_widget/src/otp_pin_field_state.dart';
import '../../../../Widget/widget.dart';

class OTPController extends GetxController with CodeAutoFill {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  CartGeneralControllerX cart = Get.find();

  //============================================================================
  // Variables

  bool isSheet = false;
  RxBool isLoading = false.obs;
  RxBool isResendAgain = false.obs;
  RxBool isLoadingResendAgain = false.obs;
  RxBool isDoneInput = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  /// if open OTP from sheet then get OTP object from view screen parameters
  late OtpX otp = Get.arguments is Map
      ? Get.arguments[NameX.otp]
      : OtpX.empty();

  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController otpCode = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<OtpPinFieldState> otpKey = GlobalKey<OtpPinFieldState>();

  late Timer timer;
  RxInt start = 240.obs;

  Rx<String> appSignature = "".obs;

  Rx<ErrorX?> error = Rx<ErrorX?>(null);

  //============================================================================
  // Functions

  /// Some titles have been duplicated if the title has changed in any case
  String getTitle() {
    if (otp.isPhone) {
      return "Confirm mobile number";
    } else if (otp.isEdit) {
      return "Email confirmation";
    }
    return "OTP";
  }

  /// Some labels have been repeated if the explanation of a case has changed
  String getSubTitle() {
    if (otp.isPhone && otp.isLogin) {
      // is login via phone
      return "Please enter the verification code sent to your mobile number";
    } else if (!otp.isPhone && otp.isLogin) {
      // is login via email
      return "Please enter the verification code sent to your email";
    } else if (!otp.isLogin && !otp.isEdit) {
      // is sign up via phone
      return "Please enter the verification code sent to your mobile number";
    } else if (otp.isPhone && otp.isEdit) {
      // is edit phone from profile
      return "Please enter the verification code sent to your mobile number";
    } else if (!otp.isPhone && otp.isEdit) {
      // is edit email from profile
      return "Please enter the verification code sent to your email";
    }
    return ""; // like default
  }

  onTapError() {
    /// Add a link to go to pages through the error message
  }

  onVerify() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        error.value = null;
        try {
          if (otp.isEdit) {
            /// Update Profile
            app.user.value = await DatabaseX.otpUpdateProfile(
              otp: int.parse(otpCode.text),
            );
          } else if (otp.isPhone) {
            /// Login & Sign up => Otp By Phone
            app.user.value = await DatabaseX.otpByPhone(
              otp: int.parse(otpCode.text),
              phone: otp.phone!,
              countryCode: otp.countryCode!,
            );
          } else {
            /// Login & Sign up => Otp By Email
            app.user.value = await DatabaseX.otpByEmail(
              otp: int.parse(otpCode.text),
              email: otp.email!,
            );
          }
          if (otp.isEdit) {
            /// The time delay here is aesthetically beneficial
            buttonState.value = ButtonStateEX.success;
            await Future.delayed(
              const Duration(seconds: StyleX.successButtonSecond),
            );

            Get.back(result: true);
          } else {
            /// save data on local
            LocalDataX.put(LocalKeyX.token, app.user.value!.token);
            LocalDataX.put(LocalKeyX.route, RouteNameX.root);
            app.isLogin.value = true;

            try {
              await cart.assignCart(app.user.value!.token);
            } catch (_) {}
            try {
              await cart.getData();
            } catch (_) {}

            /// The time delay here is aesthetically beneficial
            buttonState.value = ButtonStateEX.success;
            await Future.delayed(
              const Duration(seconds: StyleX.successButtonSecond),
            );

            if (isSheet) {
              /// to close otp sheet
              Get.back();
            } else {
              /// go to home
              Get.offAllNamed(RouteNameX.root);

              /// if sign up, show sheet to complete account data
              if (!otp.isLogin && !otp.isEdit) {
                /// Time delay for aesthetics
                await Future.delayed(const Duration(seconds: 2));
                accountCreatedSheet();
              }

              if (otp.isFromQuickDonation) {
                /// Time delay for aesthetics
                await Future.delayed(const Duration(seconds: 2));
                RootController root = Get.find();
                root.openQuickDonation();
              }
            }
          }
        } catch (e) {
          error.value = e.toErrorX;
          error.value?.log();
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

  /// Resend the code and set a new timer
  void onResend() async {
    isLoadingResendAgain.value = true;
    error.value = null;
    try {
      String message = await sendCode() ?? '';
      isResendAgain.value = false;
      startTimer();
      if (message.isNotEmpty) {
        ToastX.success(message: message);
      }
    } catch (e) {
      error.value = e.toErrorX;
    }
    isLoadingResendAgain.value = false;
  }

  /// use api from backend to send code otp
  sendCode() async {
    try {
      if (otp.isEdit) {
        return await DatabaseX.resendOtpUpdateProfile();
      } else if (otp.isLogin) {
        if (otp.isPhone) {
          return await DatabaseX.loginByPhone(
            phone: otp.phone!,
            countryCode: otp.countryCode!,
          );
        } else {
          return await DatabaseX.loginByEmail(email: otp.email!);
        }
      } else {
        /// Auth: Sign up
        if (otp.isPhone) {
          return await DatabaseX.resendOtpByPhone(
            phone: otp.phone!,
            countryCode: otp.countryCode!,
          );
        } else {
          /// TODO: Database >>> change api end point on resend otp code in sign in by email
          return await DatabaseX.loginByEmail(email: otp.email!);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  /// A timer to calculate the time remaining until the code can be re-sent
  startTimer() {
    if (!isResendAgain.value) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (start.value != 0) {
          start--;
        } else {
          start.value = 240;
          isResendAgain.value = true;
          timer.cancel();
        }
      });
    }
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();

    /// Start the counter to resend the code
    startTimer();

    /// To listen to the verification code in messages
    listenForCode();

    /// to get app signature
    SmsAutoFill().getAppSignature.then((signature) {
      // print("$signature signature");
      appSignature.value = signature;
    });
  }

  /// Specific to the listening package for the code in messages
  @override
  void codeUpdated() {
    /// Fetch the code
    otpCode.text = code ?? "";
    otpKey.currentState?.codeUpdate(code.toString());
  }

  /// Disable listeners
  @override
  void dispose() {
    super.dispose();
    SmsAutoFill().unregisterListener();
    cancel();
    timer.cancel();
  }
}
