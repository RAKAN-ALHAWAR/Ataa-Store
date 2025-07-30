import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class OrdersSectionX extends GetView<StatisticsController> {
  const OrdersSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticGroupCardX(
      linkTo: RouteNameX.myOrders,
      linkTitle: "Go to my orders",
      title: "My Orders",
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.shopping_bag_rounded,
                  statistic: controller.orderStatistics.value!.countOrders,
                  subtitle: "Number of requests",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.verified_rounded,
                  statistic: controller.orderStatistics.value!.countCompletedOrders,
                  subtitle: "Completed orders",
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
                  statistic: controller.orderStatistics.value!.totalAmountOrders,
                  subtitle: "Total amount of orders",
                ),
              ),
            ],
          ),
        ],
      ),
    ).fadeAnimation200;
  }
}
