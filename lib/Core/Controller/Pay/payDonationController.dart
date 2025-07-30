import 'dart:async';
import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Model/Donation/Subclass/donationFamilyAndFriends.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Config/config.dart';
import '../../../Data/Enum/model_type_status.dart';
import '../../../Data/Model/Donation/Order/donationOrderForm.dart';
import '../../../Data/Model/Donation/Package/donationDeductionPackage.dart';
import '../../../Data/Model/Donation/Package/donationOpenPackage.dart';
import '../../../Data/Model/Donation/Shares/donationSharesPackage.dart';
import '../../../Data/Model/Donation/donation.dart';
import '../../../Data/data.dart';
import '../../../Ui/Widget/widget.dart';
import '../../core.dart';
import '../Cart/cartGeneralController.dart';
import '../Other/donateOnBehalfOfFamilyController.dart';

class PayDonationControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();
  final CartGeneralControllerX cart = Get.find();
  late DonateOnBehalfOfFamilyController donateOnBehalfOfFamily;

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  bool isSheet = false;
  int donationSharesPrice = 0;

  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> addToCartButtonState = ButtonStateEX.normal.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController donationAmount = TextEditingController();

  Rx<DonationOpenPackageX?> openPackageSelected =
      Rx<DonationOpenPackageX?>(null);
  Rx<DonationSharesPackageX?> sharesPackageSelected =
      Rx<DonationSharesPackageX?>(null);
  Rx<DonationDeductionPackageX?> deductionPackageSelected =
      Rx<DonationDeductionPackageX?>(null);
  RxInt numOfStock = 1.obs;
  RxInt freeDonationSelected = 0.obs;

  late DonationX donation;
  CampaignX? campaign;

  //============================================================================
  // Initialization

  init() {
    /// check if "donate On Behalf Of Family controller" is has or create
    if (Get.isRegistered<DonateOnBehalfOfFamilyController>(tag: campaign?.id??donation.id)) {
      donateOnBehalfOfFamily =
          Get.find<DonateOnBehalfOfFamilyController>(tag: campaign?.id??donation.id);
    } else {
      donateOnBehalfOfFamily =
          Get.put(DonateOnBehalfOfFamilyController(), tag: campaign?.id??donation.id);
    }

    donationSharesPrice = (donation.donationShares?.price??0).toIntX;
    /// Prepare the donation amount if it is a stock type
    onChangeStockValue(1);
  }

  //============================================================================
  // Functions

  onChangeStockValue(double val) {
    numOfStock.value = val.toInt();
    if (donation.donationShares != null) {
      donationAmount.text =(donationSharesPrice * numOfStock.value).toIntNullableX.toString();
    }
  }
  String? validateAmount(String? val) {
    String? message;
    message = ValidateX.money(val);

    /// Verify the lowest possible donation value in Free Donation
    if (message == null &&
        num.parse(donationAmount.text) < app.generalSettings.minimumDonationAmount) {
      message =
      "${"The minimum donation amount is".tr} ${app.generalSettings.minimumDonationAmount} ${"SAR".tr}";
    }
    return message;
  }
  onChangeOpenPackage(DonationOpenPackageX val) {
    openPackageSelected.value = val;
    donationAmount.text = val.price.toInt().toString();
  }
  onChangeDeductionPackage(DonationDeductionPackageX val) {
    deductionPackageSelected.value = val;
    donationAmount.text = val.price.toInt().toString();
  }

  onChangeSharesPackage(DonationSharesPackageX val) {
    sharesPackageSelected.value = val;
    donationSharesPrice = ((donation.donationShares?.price??0) * val.sharesCount).toIntX;
    donationAmount.text =  (numOfStock.value * donationSharesPrice).toIntNullableX.toString();
  }

  onChangeDonationAmount(int val) {
    donationAmount.text = val.toString();
    freeDonationSelected.value = val;
  }

  removeFreeDonationSelected(val) {
    if (int.tryParse(val) != null) {
      freeDonationSelected.value = int.parse(val);
    }
  }

  /// clear date on controller
  removeController() {
    Get.delete<DonateOnBehalfOfFamilyController>(tag: campaign?.id??donation.id);
    Get.delete<PayDonationControllerX>(tag: campaign?.id??donation.id);
  }

  bool dataVerification() {
    if (donation.openPackages.isNotEmpty && openPackageSelected.value == null && !donation.isCanEditAmount) {
      return throw "You must choose one of the available packages.";
    }
    else if (donation.sharesPackages.isNotEmpty &&
        sharesPackageSelected.value == null) {
      return throw "You must choose one of the available packages.";
    } else if (donation.donationDeductionPackages.isNotEmpty &&
        deductionPackageSelected.value == null) {
      return throw "You must select the type of deduction.";
    } else if (!formKey.currentState!.validate()) {
      /// Verify input fields
      autoValidate = AutovalidateMode.always;
      return throw "Make sure you enter a valid value in donation amount";
    } else if (int.parse(donationAmount.text) <
        app.generalSettings.minimumDonationAmount) {
      /// Verify the lowest possible donation value in Free Donation
      return throw "${"The minimum donation amount is".tr} ${app.generalSettings.minimumDonationAmount} ${"SAR".tr}";
    } else if (donateOnBehalfOfFamily.isEnable.value &&
        !donateOnBehalfOfFamily.formKey.currentState!.validate()) {
      /// Verify the donation entry fields for family and friends
      donateOnBehalfOfFamily.autoValidate = AutovalidateMode.always;
      return throw "Please enter the donor's information on his behalf";
    }
    return true;
  }

  onAddToCart({bool isPay = false}) async {
    if (isLoading.isFalse) {
      try {
        /// check is validate data
        if (dataVerification()) {
          isLoading.value = true;
          isPay
              ? buttonState.value = ButtonStateEX.loading
              : addToCartButtonState.value = ButtonStateEX.loading;

            var data = await DatabaseX.createDonationOrder(
              form: DonationOrderFormX(
                donationId: donation.id,
                campaignId: campaign?.id,
                price: donationAmount.text.toIntX,
                donationOpenPackageId: openPackageSelected.value?.id,
                donationSharesPackageId: sharesPackageSelected.value?.id,
                donationDeductionPackageId: deductionPackageSelected.value?.id,
                sharesQuantity: numOfStock.value,
                donationOnBehalfOfFamilyAndFriends: donateOnBehalfOfFamily.isEnable.value,
                familyAndFriends: donateOnBehalfOfFamily.isEnable.value
                    ? DonationFamilyAndFriendsX(
                        donorName: donateOnBehalfOfFamily.donorName.text,
                        recipientName:
                            donateOnBehalfOfFamily.recipientName.text,
                        recipientCountryCode:
                            donateOnBehalfOfFamily.countryCode.value,
                        recipientPhoneWithoutCountry:
                            int.parse(donateOnBehalfOfFamily.giftedPhone.text),
                      )
                    : null,
              ),
            );
            String message = await cart.addItem(
              modelId: data.modelId,
              modelType: campaign!=null?ModelTypeStatusX.campaign:ModelTypeStatusX.donation,
              price: donationAmount.text.toIntX,
              isPayNow: isPay,
              isCloseSheet: isSheet,
            );

            /// This controller form bottom sheet
            if (!isPay) {
              ToastX.success(message: message);
            }

            /// clear date on controller
            removeController();
        }
      } catch (error) {
        error.toErrorX.log();
        ToastX.error(message: error.toString());
        isPay
            ? buttonState.value = ButtonStateEX.failed
            : addToCartButtonState.value = ButtonStateEX.failed;
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          isPay
              ? buttonState.value = ButtonStateEX.normal
              : addToCartButtonState.value = ButtonStateEX.normal;
        },
      );
    }
  }
}
