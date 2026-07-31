import 'dart:async';
import 'dart:io';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../Core/core.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';

class EditProfileController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  RxBool isEditPhoneAndEmailError = false.obs;

  late int countryCode = app.user.value!.countryCode;
  late Rx<String> gender = (app.user.value!.gender ?? "").obs;

  XFile? image;
  final ImagePicker picker = ImagePicker();

  /// Input Filed
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  late TextEditingController name = TextEditingController(
    text: app.user.value!.name,
  );
  late TextEditingController phone = TextEditingController(
    text: app.user.value!.phone.toString(),
  );
  late TextEditingController email = TextEditingController(
    text: app.user.value!.email,
  );

  //============================================================================
  // Functions

  void onChangeGender(String? value) => gender.value = value!;

  void onChangeCountryCode(String val) => countryCode = int.parse(val);

  bool nameIsRequired() {
    return app.user.value!.name.isNotEmpty ||
        app.generalSettings.isRequiredRegisterName;
  }

  bool emailIsRequired() {
    return (app.user.value!.email ?? '').isNotEmpty;
  }

  validateForName() {
    return nameIsRequired() ? ValidateX.name : ValidateX.nameNoRequired;
  }

  validateForEmail() {
    return emailIsRequired() ? ValidateX.email : ValidateX.emailNoRequired;
  }

  changeImage() async {
    /// Open the user's photo gallery to select a photo
    var x = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 10,
    );

    /// If an image is selected, the data is updated
    if (x != null) {
      image = x;
      update();
    }
  }

  onEdit() async {
    if (isLoading.isFalse) {
      if (app.user.value?.email != null &&
          email.text.toLowerCase().trim() !=
              app.user.value?.email?.toLowerCase().trim() &&
          (phone.text.trim() != app.user.value?.phone.toString() ||
              countryCode != app.user.value?.countryCode)) {
        isEditPhoneAndEmailError.value = true;
      } else {
        isEditPhoneAndEmailError.value = false;
      }
      if (isEditPhoneAndEmailError.isFalse &&
          formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        try {
          if (image != null) {
            await DatabaseX.uploadProfileImage(image: File(image!.path));
          }

          (UserX?, String?) data = await DatabaseX.updateProfile(
            name: name.text,
            email: email.text,
            phone: phone.text.toIntX,
            countryCode: countryCode,
            gender: gender.value,
          );

          if (email.text.toLowerCase().trim() !=
                  app.user.value?.email?.toLowerCase().trim() ||
              phone.text.trim() != app.user.value?.phone.toString() ||
              countryCode != app.user.value?.countryCode) {
            if (data.$2 != null && data.$2!.isNotEmpty) {
              ToastX.success(message: data.$2);
            }
            var resultOTP = await Get.toNamed(
              RouteNameX.otp,
              arguments: {
                NameX.otp: OtpX(
                  phone: phone.text.toIntX,
                  countryCode: countryCode,
                  isEdit: true,
                  isLogin: false,
                  isPhone:
                      phone.text.trim() != app.user.value?.phone.toString() ||
                      countryCode != app.user.value?.countryCode,
                ),
              },
            );
            if (resultOTP != true) {
              isLoading.value = false;
              buttonState.value = ButtonStateEX.normal;
              return;
            }
          }
          if (data.$1 != null) {
            app.user.value = data.$1;
          }

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// Close the profile edite screen
          Get.back();
          ToastX.success(message: "Profile updated successfully");
        } catch (error) {
          ToastX.error(message: error.toString());
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
