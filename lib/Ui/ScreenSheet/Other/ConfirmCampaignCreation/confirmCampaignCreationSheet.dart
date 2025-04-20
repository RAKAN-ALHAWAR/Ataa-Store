import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../../../UI/Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Review campaign data and confirm its creation
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

confirmCampaignCreationSheetX({
  required String title,
  required num targetAmount,
  required String donationName,
}) async {
  return await bottomSheetX(
    title: "Confirm campaign creation",
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Warning message
        ContainerX(
          color: Get.isDarkMode?ColorX.orange.shade800:ColorX.orange.shade50,
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.info_rounded,
                color: Get.isDarkMode?ColorX.orange.shade50:ColorX.orange.shade800,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextX(
                  "Please ensure that the data is correct as it cannot be modified later.",
                  color: Get.isDarkMode?ColorX.orange.shade50:ColorX.orange.shade800,
                  style: TextStyleX.titleSmall,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ).fadeAnimation200,
        const SizedBox(height: 20),

        /// Title
        const TextX(
          "Your campaign title",
          fontWeight: FontWeight.w600,
        ).fadeAnimation200,
        const SizedBox(height: 8),
        TextX(
          title,
          style: TextStyleX.supTitleLarge,
          color: Theme.of(Get.context!).colorScheme.secondary,
        ).fadeAnimation200,

        /// Line
        Divider(color: Get.theme.dividerColor).marginOnly(top: 4,bottom: 8).fadeAnimation200,

        /// The Program
        const TextX(
          "The Program",
          fontWeight: FontWeight.w600,
        ).fadeAnimation200,
        const SizedBox(height: 8),
        TextX(
          donationName,
          style: TextStyleX.supTitleLarge,
          color: Theme.of(Get.context!).colorScheme.secondary,
        ).fadeAnimation200,

        /// Line
        Divider(color: Get.theme.dividerColor).marginOnly(top: 4,bottom: 8).fadeAnimation200,

        /// Target amount
        const TextX(
          "Target amount",
          fontWeight: FontWeight.w600,
        ).fadeAnimation300,
        const SizedBox(height: 8),
        Row(
          children: [
            TextX(
              FunctionX.formatLargeNumber(targetAmount),
              style: TextStyleX.supTitleLarge,
              color: Theme.of(Get.context!).colorScheme.secondary,
            ),
            const SizedBox(width: 5),
            Icon(
              IconX.sar,
              size: 14,
              color: Theme.of(Get.context!).colorScheme.secondary,
            ),
          ],
        ).fadeAnimation300,
        const SizedBox(height: 16),

        /// Buttons
        Row(
          children: [
            Flexible(
              child: ButtonX.gray(
                text: "Edit",
                onTap: Get.back,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: ButtonX(
                text: "Confirm",
                onTap: () => Get.back(
                  result: true,
                ),
              ),
            ),
          ],
        ).fadeAnimation400
      ],
    ),
  );
}
