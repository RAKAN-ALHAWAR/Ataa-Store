import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Section/StatisticsAndFigures/view/View.dart';
import '../../controller/Controller.dart';

class StatisticsAndFiguresHomeSectionX extends GetView<HomeController> {
  const StatisticsAndFiguresHomeSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return StatisticsAndFiguresSectionX(
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 8,
      ),
      parentScrollController: controller.scrollController,
      header: const SectionTitleX(
        title: "Statistics and Figures",
        icon: IconX.statisticsAndFigures,
        iconSize: 18,
      ),
    );
  }
}
