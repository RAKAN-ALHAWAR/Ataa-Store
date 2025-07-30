import 'dart:async';
import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Data/Enum/payment_card_status_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Config/config.dart';
import '../../../Data/Model/PaymentCard/paymentCardForm.dart';
import '../../../Data/data.dart';
import '../../../Ui/Widget/widget.dart';

class AddPaymentCardControllerX extends GetxController {
  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxBool isDefault = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  TextEditingController name = TextEditingController();
  TextEditingController cardNum = TextEditingController();
  TextEditingController cvv = TextEditingController();
  TextEditingController date = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  //============================================================================
  // Functions

  /// Erase all data and return it to its default state
  clearData() {
    isDefault.value = false;
    name.text = '';
    cardNum.text = '';
    cvv.text = '';
    date.text = '';
    autoValidate = AutovalidateMode.disabled;
  }

  /// Change the status of the Set Card as Default button
  onChangeDefault(bool val) => isDefault.value = val;

  /// Add the card to the database after verifying it
  onAddCard() async {
    if (isLoading.isFalse) {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        try {
          /// Create a bank card object
          PaymentCardFormX paymentCardForm = PaymentCardFormX(
            name: name.text,
            cardNum: cardNum.text.removeAllWhitespace,
            month: int.parse(date.text.split(RegExp(r'(/)'))[0]),
            year: int.parse(date.text.split(RegExp(r'(/)'))[1]),
            cvv: int.parse(cvv.text),
            isDefault: isDefault.value,
          );

          PaymentCardX paymentCard =
              await DatabaseX.createPaymentCard(form: paymentCardForm);

          if (paymentCard.verificationUrl == null &&
              paymentCard.status != PaymentCardStatusStatusX.active) {
            throw 'There is an error on our part, we were unable to verify the card.';
          }
          if (paymentCard.status != PaymentCardStatusStatusX.active) {
            dynamic result = await Get.toNamed(RouteNameX.verificationUrl,
                arguments: paymentCard.verificationUrl);
            if (result != true) {
              throw 'Card not verified, try again';
            }
          }

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// This controller form bottom sheet
          Get.back(result: paymentCard);
          ToastX.success(message: "Added Card successfully");

          /// Clear data on the controller
          clearData();
        } catch (error) {
          error.toErrorX.log();
          ToastX.error(message: error.toString());
          buttonState.value = ButtonStateEX.failed;
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
            () {
          buttonState.value = ButtonStateEX.normal;
        });
      } else {
        autoValidate = AutovalidateMode.always;
      }
    }
  }
}
