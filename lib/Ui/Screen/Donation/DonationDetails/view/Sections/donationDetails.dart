import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class DonationDetailsSectionX extends GetView<DonationDetailsController> {
  const DonationDetailsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 120,
          left: StyleX.hPaddingApp,
          right: StyleX.hPaddingApp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller
                    .donation.donationSettings.isShowCompletionIndicator &&
                controller.donation.donationSettings.isShowDonationsPercentage)
            TextX(
              "${"Collected".tr} ${controller.donation.donationBasic.completionRate % 1 == 0 ? controller.donation.donationBasic.completionRate.toInt().toString() : controller.donation.donationBasic.completionRate.toStringAsFixed(2)}%",
              color: Theme.of(context).primaryColor,
            ).fadeAnimation350,
            if (controller
                    .donation.donationSettings.isShowCompletionIndicator &&
                !controller.donation.donationSettings.isShowDonationsPercentage)
              Row(
                children: [
                  TextX(
                    "${"Collected".tr} ${FunctionX.formatLargeNumber(controller.donation.donationBasic.currentDonations)}",
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
                    "${"Remaining".tr} ${FunctionX.formatLargeNumber(controller.donation.donationBasic.remainingDonations)}",
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    IconX.sar,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 14,
                  ),
                ],
              ).fadeAnimation350,
            if (controller.donation.donationSettings.isShowCompletionIndicator)
              const SizedBox(height: 10),

            /// Completion Indicator Line
            if (controller.donation.donationSettings.isShowCompletionIndicator)
              LinearProgressIndicator(
                value: controller.donation.donationBasic.currentDonations /
                    controller.donation.donationBasic.totalDonations,
                borderRadius: BorderRadius.circular(50),
                minHeight: 10,
              ).marginOnly(bottom: 16).fadeAnimation400,

            /// Details
            TextX(
              "Project Description",
              style: TextStyleX.titleLarge,
            ).fadeAnimation500,
            const SizedBox(height: 6),
            HtmlWidget(
               Get.isDarkMode
                            ? controller.donation.donationDetails.description
                                .replaceAllMapped(
                                    RegExp(
                                        r'color:\s*(rgb\((\d+),\s*(\d+),\s*(\d+)\)|#([0-9a-fA-F]{6})|black|white)',
                                        caseSensitive: false), (match) {
                                if (match.group(1)?.startsWith('rgb(') ??
                                    false) {
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
                                const colorMap = {
                                  'black': 'white',
                                  'white': 'black'
                                };
                                return 'color: ${colorMap[match.group(1)?.toLowerCase()] ?? match.group(1)}';
                              })
                            : controller.donation.donationDetails.description,
              textStyle: TextStyleX.titleSmall,
            ).fadeAnimation500,
            const SizedBox(height: 16),

            /// Statistics
            Row(
              children: [
                /// Total donations
                Flexible(
                  child: StatisticCardX(
                    color: Theme.of(context).cardColor,
                    icon: Icons.payments_rounded,
                    statistic:
                        controller.donation.donationBasic.currentDonations,
                    subtitle: "Total amount of donations",
                    isMoney: true,
                  ),
                ),
                if (controller.donation.donationSettings.isShowDonorsCount)
                  const SizedBox(width: 8),
                if (controller.donation.donationSettings.isShowDonorsCount)

                  /// Total Targets
                  Flexible(
                    child: StatisticCardX(
                      color: Theme.of(context).cardColor,
                      icon: Icons.favorite_rounded,
                      statistic:
                          controller.donation.donationBasic.countDonations,
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
