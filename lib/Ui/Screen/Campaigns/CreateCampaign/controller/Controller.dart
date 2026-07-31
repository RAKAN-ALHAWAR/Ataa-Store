import 'dart:async';
import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Data/Model/Campaign/createCampaignForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/SelectedOptions/donationSelectionController.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../ScreenSheet/Other/ConfirmCampaignCreation/confirmCampaignCreationSheet.dart';

class CreateCampaignController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  DonationSelectionControllerX donationSelectionController = Get.put(
    DonationSelectionControllerX(),
  );

  //============================================================================
  // Variables

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController title = TextEditingController();
  Rx<num?> targetAmount = Rx<num?>(null);
  RxBool isAgreed = false.obs;

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  //============================================================================
  // Functions

  void onChangeAgreed(bool val) => isAgreed.value = val;

  //----------------------------------------------------------------------------

  entryVerification() {
    if (!formKey.currentState!.validate()) {
      autoValidate = AutovalidateMode.always;
      return false;
    } else if (donationSelectionController.donationSelected.value == null) {
      return throw "You must select one of the donation projects";
    } else if (targetAmount.value == null) {
      return throw "You must specify the target amount";
    }
    return true;
  }

  /// Erase all data and return it to its default state
  clearData() {
    donationSelectionController.clearData();
    title.text = "";
    targetAmount.value = null;
    isAgreed.value = false;
    autoValidate = AutovalidateMode.disabled;
  }

  onCreate() async {
    if (isLoading.isFalse) {
      try {
        if (entryVerification()) {
          isLoading.value = true;
          buttonState.value = ButtonStateEX.loading;

          var isConfirmCreate = await confirmCampaignCreationSheetX(
            title: title.text,
            targetAmount: targetAmount.value!,
            donationName: donationSelectionController
                .donationSelected
                .value!
                .donationBasic
                .name,
          );

          if (isConfirmCreate == true) {
            CampaignX campaign = await DatabaseX.createNewCampaign(
              form: CampaignFormX(
                title: title.text,
                targetAmount: targetAmount.value!,
                donationId:
                    donationSelectionController.donationSelected.value!.id,
              ),
            );

            /// The time delay here is aesthetically beneficial
            buttonState.value = ButtonStateEX.success;
            await Future.delayed(
              const Duration(seconds: StyleX.successButtonSecond),
            );

            /// this controller form bottom sheet
            await bottomSheetSuccessX(
              icon: Icons.check_rounded,
              title: "The campaign has been created successfully",
              message:
                  "The campaign you created will be reviewed by the administrator and you will be notified of its status",
              okText: "View campaign details",
              cancelText: 'Close',
              onOk: () async => await Get.toNamed(
                RouteNameX.myCampaignDetails,
                arguments: campaign.id,
              ),
            );

            /// clear date on controller
            clearData();
          } else {
            buttonState.value = ButtonStateEX.normal;
          }
        }
      } catch (error) {
        error.toErrorX.log();
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
