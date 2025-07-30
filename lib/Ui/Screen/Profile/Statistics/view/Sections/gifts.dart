import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class GiftsSectionX extends GetView<StatisticsController> {
  const GiftsSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticGroupCardX(
      linkTo: RouteNameX.myGifts,
      linkTitle: "Go to my gifts",
      title: "My Gifts",
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.shopping_bag_rounded,
                  statistic: controller.giftStatistics.value!.countGifts,
                  subtitle: "Number of gifts",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  isMoney: true,
                  icon: Icons.verified_rounded,
                  statistic: controller.giftStatistics.value!.totalAmountGifts,
                  subtitle: "Total gifts amounts",
                ),
              ),
            ],
          ),
        ],
      ),
    ).fadeAnimation200;
  }
}
