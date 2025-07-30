import 'dart:async';
import 'package:get/get.dart';
import '../../../Config/config.dart';
import '../../../Data/Enum/linkable_type_status.dart';
import '../../../Data/data.dart';
import '../../../Ui/ScreenSheet/Selection/Donation/donationSelectionSheet.dart';
import '../../../Ui/Widget/widget.dart';
import '../SelectedOptions/donationSelectionController.dart';

class AddShareLinkControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  DonationSelectionControllerX donationOpportunityController =
      Get.put(DonationSelectionControllerX());

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  //============================================================================
  // Functions

  onTapChooseDonation() =>
      donationSelectionSheetX(controller: donationOpportunityController);

  /// Erase all data and return it to its default state
  clearData() {
    donationOpportunityController.donationSelected.value = null;
  }

  onCreateLink() async {
    if (isLoading.isFalse) {
      if (donationOpportunityController.donationSelected.value != null) {
        isLoading.value = true;
        buttonState.value = ButtonStateEX.loading;
        try {

          /// Create a share link object
          var result = await DatabaseX.createShareLink(linkableType: LinkableTypeStatusX.donation,modelId: donationOpportunityController.donationSelected.value!.id);

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// This controller form bottom sheet
          Get.back(result: result);
          ToastX.success(
            message: "The sharing link has been created successfully",
          );

          /// Clear data on the controller
          clearData();
        } catch (error) {
          ToastX.error(message: error.toString());
          buttonState.value = ButtonStateEX.failed;
        }
        isLoading.value = false;
      } else {
        ToastX.error(message: "You must choose one of the donations");
        buttonState.value = ButtonStateEX.failed;
      }

      /// Reset the button state
      Timer(const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
        buttonState.value = ButtonStateEX.normal;
      });
    }
  }
}
