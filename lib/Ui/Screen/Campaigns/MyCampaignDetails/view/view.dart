import 'package:ataa/Config/Translation/translation.dart';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Data/Enum/campaign_status.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:ataa/Ui/Widget/Basic/Other/scrollRefreshLoadMore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../controller/controller.dart';

class MyCampaignDetailsView extends GetView<MyCampaignDetailsController> {
  const MyCampaignDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: controller.campaign.title,
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
            vertical: StyleX.vPaddingApp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Share Button
              if (controller.campaign.status == CampaignStatusX.accepted)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    ButtonX.gray(
                      width: 100,
                      height: StyleX.buttonHeightSm,
                      marginVertical: 0,
                      onTap: controller.openShare,
                      text: "Share",
                      iconData: Icons.share,
                      colorText: Theme.of(context).iconTheme.color,
                    ).fadeAnimation200,
                  ],
                ).paddingOnly(bottom: 16),

              if (controller.campaign.status == CampaignStatusX.rejected &&
                  controller.campaign.notes.isNotEmpty)
                MessageCardX(
                  message: controller.campaign.notes,
                  isError: true,
                ).fadeAnimation200.paddingOnly(bottom: 16),
              ContainerX(
                width: double.maxFinite,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Campaign Status
                    ContainerX(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      radius: StyleX.radiusSm,
                      color:
                          controller.campaign.status == CampaignStatusX.pending
                              ? ColorX.yellow[Get.isDarkMode ? 800 : 100]
                              : controller.campaign.status ==
                                      CampaignStatusX.accepted
                                  ? ColorX.green[Get.isDarkMode ? 800 : 100]
                                  : controller.campaign.status ==
                                          CampaignStatusX.rejected
                                      ? ColorX.red[Get.isDarkMode ? 800 : 100]
                                      : ColorX.grey[Get.isDarkMode ? 800 : 100],
                      child: TextX(
                        controller.campaign.status.name.tr,
                        style: TextStyleX.titleSmall,
                        fontWeight: FontWeight.w500,
                        color: controller.campaign.status ==
                                CampaignStatusX.pending
                            ? ColorX.yellow[Get.isDarkMode ? 100 : 800]
                            : controller.campaign.status ==
                                    CampaignStatusX.accepted
                                ? ColorX.green[Get.isDarkMode ? 100 : 800]
                                : controller.campaign.status ==
                                        CampaignStatusX.rejected
                                    ? ColorX.red[Get.isDarkMode ? 100 : 800]
                                    : ColorX.grey[Get.isDarkMode ? 100 : 800],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextX(
                      'your campaign title',
                      style: TextStyleX.titleSmall,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 8),
                    TextX(
                      controller.campaign.title,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 16),
                    TextX(
                      'Project',
                      style: TextStyleX.titleSmall,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 8),
                    TextX(
                      controller.campaign.donation.donationBasic.name,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(height: 16),
                    TextX(
                      'Target amount',
                      style: TextStyleX.titleSmall,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        TextX(
                          FunctionX.formatLargeNumber(
                              controller.campaign.targetAmount,
                          ),
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          IconX.sar,
                          size: 14,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextX(
                      'Campaign creation date',
                      style: TextStyleX.titleSmall,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(height: 8),
                    TextX(
                      intl.DateFormat('yyyy/M/d | hh:mm ', 'en')
                              .format(controller.campaign.startDate) +
                          intl.DateFormat('a', TranslationX.getLanguageCode)
                              .format(controller.campaign.startDate),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ).fadeAnimation300,

              if (controller.campaign.status == CampaignStatusX.accepted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    /// Linear Progress
                    ContainerX(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          const SizedBox(height: 12),

                          /// Completion Indicator Line
                          LinearProgressIndicator(
                            value: controller.campaign.completionRate/100,
                            borderRadius: BorderRadius.circular(50),
                            minHeight: 10,
                          ),
                        ],
                      ),
                    ).fadeAnimation400,
                    const SizedBox(height: 12),

                    /// statistic
                    Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: StatisticCardX(
                                isMoney: true,
                                icon: Icons.payments_rounded,
                                color: Theme.of(context).cardColor,
                                statistic: controller.campaign.totalDonations,
                                subtitle: "Total Donation Amount",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: StatisticCardX(
                                icon: Icons.favorite_rounded,
                                color: Theme.of(context).cardColor,
                                statistic: controller.campaign.countDonations,
                                subtitle: "Number of donations",
                              ),
                            ),
                          ],
                        ).fadeAnimation500,
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Flexible(
                              child: StatisticCardX(
                                icon: Icons.visibility_rounded,
                                color: Theme.of(context).cardColor,
                                statistic:
                                    controller.campaign.statistics.visits,
                                subtitle: "Number of visits",
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: StatisticCardX(
                                icon: Icons.person_add_alt_rounded,
                                color: Theme.of(context).cardColor,
                                statistic: controller
                                    .campaign.statistics.registrations,
                                subtitle:
                                    "Number of registered users on the platform",
                              ),
                            ),
                          ],
                        ).fadeAnimation550,
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Campaign Donations List
                    const TextX(
                      'Campaign Donations List',
                      size: 16,
                      fontWeight: FontWeight.w700,
                    ).fadeAnimation600,
                    const SizedBox(height: 12),
                    ScrollRefreshLoadMoreX(
                      isExpanded: false,
                      emptyMessage: 'There are no current donations',
                      fetchData: controller.getCampaignDonations,
                      itemBuilder: (data, index) => ContainerX(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TextX(
                                  'Donation amount',
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  style: TextStyleX.titleSmall,
                                ),
                                const Spacer(),
                                TextX(
                                  FunctionX.formatLargeNumber(data.price),
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(width: 5),
                                const Icon(IconX.sar,size: 14)
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                TextX(
                                  'Donation time',
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  style: TextStyleX.titleSmall,
                                ),
                                const Spacer(),
                                TextX(
                                  intl.DateFormat('y/M/d | h:mm ').format(data.createdAt),
                                  fontWeight: FontWeight.w600,
                                ),
                                TextX(
                                  intl.DateFormat('a',TranslationX.getLanguageCode).format(data.createdAt),
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
