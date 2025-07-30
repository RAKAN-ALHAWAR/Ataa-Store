import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class DeductionsSectionX extends GetView<StatisticsController> {
  const DeductionsSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticGroupCardX(
      linkTo: RouteNameX.myDeductions,
      linkTitle: "Go to my deductions",
      title: "My Deductions",
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.payment_rounded,
                  statistic: controller.deductionStatistics.value!.countDeductions,
                  subtitle: "Number of deductions",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  isMoney: true,
                  icon: Icons.payments_rounded,
                  statistic: controller.deductionStatistics.value!.totalAmountDeductions,
                  subtitle: "Total deduction amounts",
                ),
              ),
            ],
          ),
        ],
      ),
    ).fadeAnimation200;
  }
}
