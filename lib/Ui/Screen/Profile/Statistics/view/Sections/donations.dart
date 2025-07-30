import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class DonationsSectionX extends GetView<StatisticsController> {
  const DonationsSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticGroupCardX(
      linkTo: RouteNameX.myDonations,
      linkTitle: "Go to my donations",
      title: "My Donations",
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.favorite_rounded,
                  statistic: controller.donationStatistics.value!.countOfDonations,
                  subtitle: "Number of donations",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.verified_rounded,
                  statistic: controller.donationStatistics.value!.countCompletedDonations,
                  subtitle: "Completed donations",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.favorite_rounded,
                  statistic: controller.donationStatistics.value!.countProjectDonations,
                  subtitle: "Total opportunities participated in",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.payments_rounded,
                  isMoney: true,
                  statistic: controller.donationStatistics.value!.totalAmountDonation,
                  subtitle: "Total amount of donations",
                ),
              ),
            ],
          ),
        ],
      ),
    ).fadeAnimation200;
  }
}
