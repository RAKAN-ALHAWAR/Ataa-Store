import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class CampaignsSectionX extends GetView<StatisticsController> {
  const CampaignsSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticGroupCardX(
      linkTo: RouteNameX.myCampaigns,
      linkTitle: "Go to my campaigns",
      title: "My Campaigns",
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.equalizer_rounded,
                  statistic: controller.campaignStatistics.value!.campaignCount,
                  subtitle: "Number of campaigns",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.visibility_rounded,
                  statistic: controller.campaignStatistics.value!.countVisits,
                  subtitle: "Number of visits",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.person_add_alt_rounded,
                  statistic: controller.campaignStatistics.value!.registrationsCount,
                  subtitle: "New registrants",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.favorite_rounded,
                  statistic: controller.campaignStatistics.value!.donationCount,
                  subtitle: "Number of donations",
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  isMoney: true,
                  icon: Icons.payments_rounded,
                  statistic: controller.campaignStatistics.value!.totalAmountCampaign,
                  subtitle: "Total campaign donation amounts",
                ),
              ),
            ],
          ),
        ],
      ),
    ).fadeAnimation200;
  }
}
