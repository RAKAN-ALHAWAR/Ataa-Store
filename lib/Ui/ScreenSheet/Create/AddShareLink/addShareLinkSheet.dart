import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Create/addShareLinkController.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Enter the share link information and create it
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

addShareLinkSheetX({required AddShareLinkControllerX controller}) {
  return bottomSheetX(
    title: "Create a share link",
    child: Obx(
      () => Column(
        children: [
          /// Choose a donation opportunity
          MultipleSelectionCardX(
            title: "Choose a donation opportunity",
            onTap: controller.onTapChooseDonation,
            selected: controller
                .donationOpportunityController.donationSelected.value?.donationBasic.name,
          ).fadeAnimation200,
          const SizedBox(height: 10),

          /// Create Button
          ButtonStateX(
            state: controller.buttonState.value,
            onTap: controller.onCreateLink,
            text: "Create the link",
          ).fadeAnimation200
        ],
      ),
    ),
  );
}
