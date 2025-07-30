import 'dart:async';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Config/config.dart';
import '../../../Data/Model/Deduction/deduction.dart';
import '../../../Data/data.dart';
import '../../../UI/Widget/widget.dart';
import '../../core.dart';
import '../Other/donateOnBehalfOfFamilyController.dart';

class SubscriptionDeductionControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;

  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController deductionAmount = TextEditingController();

  RxInt freeDeductionSelected = 0.obs;
  late DeductionX deduction;

  //============================================================================
  // Initialization

  init(DeductionX deduction) {
    this.deduction = deduction;
  }

  //============================================================================
  // Functions

  /// clear date on controller
  removeController() {
    Get.delete<DonateOnBehalfOfFamilyController>(tag: deduction.id);
    Get.delete<SubscriptionDeductionControllerX>(tag: deduction.id);
  }

  onChangeDeductionAmount(int val) {
    deductionAmount.text = val.toString();
    freeDeductionSelected.value = val;
  }

  removeFreeDonationSelected(val) {
    if (int.tryParse(val) != null) {
      freeDeductionSelected.value = int.parse(val);
    }
  }

  bool dataVerification() {
    if (!deduction.isOpenPrice) {
      return true;
    } else if (!formKey.currentState!.validate()) {
      /// Verify input fields
      autoValidate = AutovalidateMode.always;
      return throw "Make sure you enter a valid value in deduction amount";
    }
    return true;
  }

  String? validateAmount(String? val) {
    String? message;
    message = ValidateX.money(val);

    /// Verify the lowest possible donation value in Free Deduction
    if (message == null &&
        num.parse(deductionAmount.text) <
            app.generalSettings.minimumDeductionAmount) {
      message =
      "${"The minimum deduction amount is".tr} ${app.generalSettings.minimumDeductionAmount} ${"SAR".tr}";
    }
    return message;
  }
  onDeduction() async {
    if (isLoading.isFalse) {
      try {
        if (dataVerification()) {
          isLoading.value = true;
          buttonState.value = ButtonStateEX.loading;
          await Future.delayed(
            const Duration(milliseconds: 500),
          );

          Get.back(result: (true,deduction.isOpenPrice?deductionAmount.text.toDoubleX:null));

          /// NOTE:
          /// Moved to the deduction display screen in order to update the subscription button if subscribed.
          // await Get.toNamed(
          //   RouteNameX.deductionPayment,
          //   arguments: [
          //     deduction,
          //     deduction.isOpenPrice
          //         ? deductionAmount.text.toDoubleX
          //         : deduction.initialPrice
          //   ],
          // );

          /// clear date on controller
          removeController();
          buttonState.value = ButtonStateEX.normal;
        }
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
    }
  }
}
