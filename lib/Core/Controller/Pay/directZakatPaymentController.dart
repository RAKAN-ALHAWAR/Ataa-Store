import 'dart:async';
import 'package:ataa/Core/Controller/Cart/cartGeneralController.dart';
import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/model_type_status.dart';
import 'package:ataa/Data/Model/Donation/Order/donationOrderForm.dart';
import 'package:ataa/Ui/ScreenSheet/Selection/Zakat/zakatSelectionSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Config/config.dart';
import '../../../Data/data.dart';
import '../../../UI/Widget/widget.dart';
import '../../core.dart';
import '../SelectedOptions/zakatSelectionController.dart';

class DirectZakatPaymentControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();
  final CartGeneralControllerX cart = Get.find();
  final ZakatSelectionControllerX zakatSelectionController =
      Get.put(ZakatSelectionControllerX(), tag: 'DirectZakatPayment');

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> addToCartButtonState = ButtonStateEX.normal.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController money = TextEditingController();

  //============================================================================
  // Functions

  onTapZakatSelection() async {
    await zakatSelectionSheetX(controller: zakatSelectionController);
  }

  /// Erase all data and return it to its default state
  clearData() {
    money.text = "";
    autoValidate = AutovalidateMode.disabled;
  }

  onAddToCart({bool isPay = false}) async {
    if (isLoading.isFalse) {
       if(zakatSelectionController.optionSelected.value == null && app.generalSettings.defaultZakat==null){
         ToastX.error(message: 'You must choose one of the donations');
       }else if (formKey.currentState!.validate()) {
        isLoading.value = true;
        isPay?buttonState.value = ButtonStateEX.loading:addToCartButtonState.value= ButtonStateEX.loading;

        try {
          var data = await DatabaseX.createDonationOrder(
            form: DonationOrderFormX(
              donationId: zakatSelectionController.optionSelected.value!=null?zakatSelectionController.optionSelected.value!.id:app.generalSettings.defaultZakat!.id,
              price: money.text.toIntX,
              donationOnBehalfOfFamilyAndFriends: false,
            ),
          );

          String message = await cart.addItem(modelId: data.modelId,modelType: ModelTypeStatusX.donation,price:money.text.toIntX,isPayNow:isPay,isCloseSheet:true);

          /// This controller form bottom sheet
          if(!isPay) {
            ToastX.success(message: message);
          }

          /// Clear date on controller
          clearData();
          zakatSelectionController.clearData();
          if(app.generalSettings.defaultZakat!=null) {
            zakatSelectionController.optionSelected=app.generalSettings.defaultZakat.obs;
          }
        } catch (error) {
          error.toErrorX.log();
          ToastX.error(message: error.toString());
          isPay?buttonState.value = ButtonStateEX.failed:addToCartButtonState.value= ButtonStateEX.failed;
        }
        isLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
            addToCartButtonState.value = ButtonStateEX.normal;
            buttonState.value = ButtonStateEX.normal;
          },
        );
      } else {
        autoValidate = AutovalidateMode.always;
      }
    }
  }

  //============================================================================
  @override
  void onInit() {
    super.onInit();
    if(app.generalSettings.defaultZakat!=null) {
      zakatSelectionController.optionSelected=app.generalSettings.defaultZakat.obs;
    }
  }
}
