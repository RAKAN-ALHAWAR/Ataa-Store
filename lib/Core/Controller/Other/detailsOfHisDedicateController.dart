import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:get/get.dart';
import '../../../Data/data.dart';
import '../../../Ui/Widget/widget.dart';
import '../../core.dart';

class DetailsOfHisDedicateController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  late Rx<String> gender = "male".obs;
  RxInt countryCode = 966.obs;

  final FlutterNativeContactPicker contactPicker = FlutterNativeContactPicker();

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  /// The name Mahdi is fetched through the username
  late TextEditingController donorName =
      TextEditingController(text: app.isLogin.value ? app.user.value!.name : "");
  TextEditingController giftedName = TextEditingController();
  TextEditingController giftedPhone = TextEditingController();

  //============================================================================
  // Functions

  /// Erase all data and return it to its default state
  clearData() {
    giftedName.text = '';
    giftedPhone.text = "";
    gender.value = "";
    donorName.text = app.isLogin.value ? app.user.value!.name : "";
    autoValidate = AutovalidateMode.disabled;
  }

  onChangeGender(String? value) => gender.value = value!;

  onChangeCountryCode(String val) {
    final newCode = int.parse(val);
    if (!app.generalSettings.isShowCountryCodeList &&
        newCode != app.generalSettings.defaultCountryCode) {
      ToastX.error(message: "Changing the country code is not allowed".tr);
      countryCode.value = app.generalSettings.defaultCountryCode;
      return;
    }
    countryCode.value = newCode;
  }

  /// Get the Mahdi's information from his contacts
  onPhoneFromContacts() async {
    try {
      Contact? contact = await contactPicker.selectContact();
      if (contact != null) {
        /// If name is empty, it returns the previous value
        giftedName.text = contact.fullName ?? giftedName.text;

        /// To check if there is a phone number and then check if this number is empty or not
        if (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty) {
          /// Separate the phone number from the country code
          var result = FunctionX.extractCountryCodeAndPhoneNumber(
            contact.phoneNumbers![0],
          );

          final phoneNumber = result.$1;
          final extractedCode = result.$2;

          if (!app.generalSettings.isShowCountryCodeList) {
            if (extractedCode != null &&
                extractedCode != app.generalSettings.defaultCountryCode) {
              ToastX.error(
                  message: "Changing the country code is not allowed".tr);
              return;
            }
            if (app.generalSettings.defaultCountryCode == 966 &&
                !(phoneNumber.startsWith('05') ||
                    phoneNumber.startsWith('5'))) {
              ToastX.error(
                  message: "Enter a Saudi Arabian phone number".tr);
              return;
            }
          }

          giftedPhone.text = phoneNumber;
          countryCode.value = extractedCode ?? countryCode.value;
        }
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Verify the entered data
  /// Note: It will be used from another place, and we will not be able to use
  ///      the formKey verification because it will not appear on the screen,
  ///      and the verification will not be performed if it is not visible.
  bool dataVerification() {
    if (ValidateX.name(donorName.text) == null &&
        ValidateX.name(giftedName.text) == null &&
        ValidateX.phone(giftedPhone.text) == null &&
        gender.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  onSave() {
    /// Verify input fields
    if (formKey.currentState!.validate()) {
      /// Check whether gender is left blank
      if (gender.value.isNotEmpty) {
        /// The bottom sheet is closed and processing is completed in another controller
        Get.back();
      } else {
        ToastX.error(message: "You must choose the gender");
      }
    } else {
      autoValidate = AutovalidateMode.always;
    }
  }
}
