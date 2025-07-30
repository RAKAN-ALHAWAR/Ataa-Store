import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../../Data/data.dart';
import '../../../Widget/widget.dart';
import '../../PartOfSheet/DonateOnBehalfOfFamily/donateOnBehalfOfFamily.dart';
import 'Sections/buttons.dart';
import 'Sections/deductionMessage.dart';
import 'Sections/donationAmount.dart';
import 'Sections/freeDonation.dart';
import 'Sections/openPackages.dart';
import 'Sections/shares.dart';
import 'Sections/sharesPackages.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Paying a donation to one of the donation projects
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

payDonationSheet(
  DonationX donation, {
  bool onlyAddToCart = false,

  /// Donation drives are treated exactly like donation projects
  CampaignX? campaign,
}) {
  //============================================================================
  // Injection of required controls

  final PayDonationControllerX controller = Get.put(
    PayDonationControllerX(),
    tag: donation.id,
  )
    ..donation = donation
    ..campaign = campaign
    ..isSheet = true;
  controller.init();

  //============================================================================
  // Content

  return bottomSheetX(
    title: campaign!=null?"Donate to the campaign":"Donate to the project",
    child: Obx(
      () {
        /// Main Content
        return AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              FreeDonationSectionX(controller),
              OpenPackagesSectionX(controller),
              SharesPackagesSectionX(controller),
              SharesSectionX(controller),
              DonationAmountSectionX(controller),
              if(controller.donation.donationSettings.isShowGifting)
              DonateOnBehalfOfFamilyPartOfSheetX(
                  controller: controller.donateOnBehalfOfFamily,
              ),
              DeductionMessageSectionX(controller),
              ButtonsSectionX(controller, onlyAddToCart),
            ],
          ),
        );
      },
    ),
  );
}
