import 'dart:async';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Ui/Widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:get/get.dart';

class DonateOnBehalfOfFamilyController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isEnable = false.obs;
  RxInt countryCode = 966.obs;

  final FlutterNativeContactPicker contactPicker = FlutterNativeContactPicker();

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  /// The name Mahdi is fetched through the username
  late TextEditingController donorName =
      TextEditingController(text: app.isLogin.value ? app.user.value!.name : "");
  TextEditingController recipientName = TextEditingController();
  TextEditingController giftedPhone = TextEditingController();

  //============================================================================
  // Functions

  /// Erase all data and return it to its default state
  clearData() {
    recipientName.text = '';
    giftedPhone.text = "";
    donorName.text = app.isLogin.value ? app.user.value!.name : "";
    isEnable.value = false;
    autoValidate = AutovalidateMode.disabled;
  }

  onEnable(bool val) => isEnable.value = val;

  onChangeCountryCode(String countryCode) {
    final newCode = int.parse(countryCode);
    if (!app.generalSettings.isShowCountryCodeList &&
        newCode != app.generalSettings.defaultCountryCode) {
      ToastX.error(message: "Changing the country code is not allowed".tr);
      this.countryCode.value = app.generalSettings.defaultCountryCode;
      return;
    }
    this.countryCode.value = newCode;
  }

  /// Get the Mahdi's information from his contacts
  onPhoneFromContacts() async {
    try {
      Contact? contact = await contactPicker.selectContact();
      if (contact != null) {
        /// If name is empty, it returns the previous value
        recipientName.text = contact.fullName ?? recipientName.text;

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
}
