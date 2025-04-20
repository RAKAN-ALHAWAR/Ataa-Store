import 'dart:async';
import 'package:ataa/Core/Error/error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Config/config.dart';
import '../../../Data/Model/Campaign/createCampaignForm.dart';
import '../../../Data/data.dart';
import '../../../Ui/Widget/widget.dart';
import '../../core.dart';
import '../SelectedOptions/donationSelectionController.dart';

class EditCampaignControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();
  late DonationSelectionControllerX donationSelectionController;

  //============================================================================
  // Variables

  late CampaignX campaign;
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController title = TextEditingController();
  Rx<num?> targetAmount = Rx<num?>(null);

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  //============================================================================
  // Initialization

  init() {
    /// check if "donate On Behalf Of Family controller" is has or create
    if (Get.isRegistered<DonationSelectionControllerX>(tag: campaign.id)) {
      donationSelectionController =
          Get.find<DonationSelectionControllerX>(tag: campaign.id);
    } else {
      donationSelectionController =
          Get.put(DonationSelectionControllerX(), tag: campaign.id);
    }
    title.text = campaign.title;
    if(app.generalSettings.campaignTargetAmounts.contains(campaign.totalDonations)) {
      targetAmount.value =  campaign.totalDonations;
    }
    donationSelectionController.donationSelected.value = campaign.donation;
  }

  //============================================================================
  // Functions

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

  /// clear date on controller
  removeController() {
    Get.delete<DonationSelectionControllerX>(tag: campaign.id);
    Get.delete<EditCampaignControllerX>(tag: campaign.id);
  }

  onEdit() async {
    if (isLoading.isFalse) {
      try {
        if (entryVerification()) {
          isLoading.value = true;
          buttonState.value = ButtonStateEX.loading;

          if (targetAmount.value != campaign.totalDonations ||
              title.text != campaign.title ||
              donationSelectionController.donationSelected.value!.id !=
                  campaign.donation.id) {
            campaign = await DatabaseX.updateMyCampaign(
              id: campaign.id,
              form: CampaignFormX(
                title: title.text,
                targetAmount: targetAmount.value!,
                donationId:
                    donationSelectionController.donationSelected.value!.id,
              ),
            );
          }

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );
          Get.back(result: campaign);

          /// clear date on controller
          removeController();
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
