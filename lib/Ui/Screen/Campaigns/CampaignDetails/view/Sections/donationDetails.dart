import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class DonationDetailsSectionX extends GetView<CampaignDetailsController> {
  const DonationDetailsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 120,
          left: StyleX.hPaddingApp,
          right: StyleX.hPaddingApp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Alarm card
            ContainerX(
              color: Theme.of(context).colorScheme.onPrimary,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextX(
                    controller.campaign.title,
                    color: ColorX.primary,
                    style: TextStyleX.headerSmall,
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text:
                          "${"This campaign was created by a user of the Ataa platform via".tr} ",
                      style: TextStyleX.titleMedium.copyWith(
                        color: ColorX.primary,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: FontX.fontFamily,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${'Donation campaigns'.tr}.',
                          style: TextStyleX.titleMedium.copyWith(
                            decoration: TextDecoration.underline,
                            color: ColorX.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: FontX.fontFamily,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = controller.showAllCampaigns,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ).fadeAnimation300,

            const SizedBox(height: 14),

            TextX(
              controller.campaign.donation.donationBasic.name,
              color: Theme.of(context).primaryColor,
              style: TextStyleX.headerSmall,
            ).fadeAnimation300,

            const SizedBox(height: 14),

            /// Details
            TextX(
              "Project Description",
              style: TextStyleX.titleLarge,
            ).fadeAnimation400,
            const SizedBox(height: 6),
            HtmlWidget(
               Get.isDarkMode
                  ? controller.campaign.donation.donationDetails.description
                      .replaceAllMapped(
                      RegExp(
                          r'color:\s*(rgb\((\d+),\s*(\d+),\s*(\d+)\)|#([0-9a-fA-F]{6})|black|white)',
                          caseSensitive: false), (match) {
                      if (match.group(1)?.startsWith('rgb(') ?? false) {
                        final r = int.parse(match.group(2)!);
                        final g = int.parse(match.group(3)!);
                        final b = int.parse(match.group(4)!);
                        if (r == g && g == b) {
                          return 'color: rgb(255, 255, 255)';
                        }
                        return 'color: rgb(0, 0, 0)';
                      }
                      if (match.group(1)?.startsWith('#') ?? false) {
                        final hex = match.group(5)!;
                        if (hex[0] == hex[1] &&
                            hex[2] == hex[3] &&
                            hex[4] == hex[5]) {
                          return 'color: #ffffff';
                        }
                        return 'color: #000000';
                      }
                      const colorMap = {'black': 'white', 'white': 'black'};
                      return 'color: ${colorMap[match.group(1)?.toLowerCase()] ?? match.group(1)}';
                    })
                  : controller.campaign.donation.donationDetails.description,
              textStyle: TextStyleX.titleSmall,
            ).fadeAnimation500,

            const SizedBox(height: 10),

            // if(controller.campaign.donation.donationSettings.isShowCompletionIndicator || controller.campaign.donation.donationSettings.isShowDonationsPercentage)
            ContainerX(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.campaign.donation.donationSettings.isShowCompletionIndicator &&
                      controller.campaign.donation.donationSettings.isShowDonationsPercentage)
                    TextX(
                      "${"Collected".tr} ${(controller.campaign.completionRate.toStringAsFixed(2))}%",
                      color: Theme.of(context).primaryColor,
                    ),
                  if (controller
                      .campaign.donation.donationSettings.isShowCompletionIndicator &&
                      !controller.campaign.donation.donationSettings.isShowDonationsPercentage)
                  Row(
                    children: [
                      TextX(
                        "${"Collected".tr} ${FunctionX.formatLargeNumber(controller.campaign.currentDonations)}",
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                          IconX.sar,
                          color: Theme.of(context).primaryColor,
                          size: 14,
                        ),
                      const Spacer(),
                      TextX(
                        "${"Remaining".tr} ${FunctionX.formatLargeNumber(controller.campaign.remainingDonations)}",
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        IconX.sar,
                         color: Theme.of(context).colorScheme.secondary,
                        size: 14,
                      ),
                    ],
                  ),
                  if (controller.campaign.donation.donationSettings.isShowCompletionIndicator)
                  const SizedBox(height: 10),

                  /// Completion Indicator Line
                  if (controller.campaign.donation.donationSettings.isShowCompletionIndicator)
                  LinearProgressIndicator(
                    value: controller.campaign.completionRate/100,
                    borderRadius: BorderRadius.circular(50),
                    minHeight: 10,
                  ),
                ],
              ),
            ).fadeAnimation550.marginOnly(bottom: 16),

            /// Statistics
            Row(
              children: [
                /// Total donations
                Flexible(
                  child: StatisticCardX(
                    color: Theme.of(context).cardColor,
                    icon: Icons.payments_rounded,
                    statistic: controller.campaign.currentDonations,
                    subtitle: "Total amount of donations",
                    isMoney: true,
                  ),
                ),
                // if (controller.campaign.donation.donationSettings.isShowDonorsCount)
                const SizedBox(width: 8),
                // if (controller.campaign.donation.donationSettings.isShowDonorsCount)

                /// Total Targets
                Flexible(
                  child: StatisticCardX(
                    color: Theme.of(context).cardColor,
                    icon: Icons.favorite_rounded,
                    statistic: controller.campaign.countDonations,
                    subtitle: "Number of donations",
                  ),
                ),
              ],
            ).fadeAnimation600
          ],
        ),
      ),
    );
  }
}
