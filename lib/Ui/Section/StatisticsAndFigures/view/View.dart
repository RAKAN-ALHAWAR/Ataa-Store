import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';
import '../controller/Controller.dart';

class StatisticsAndFiguresSectionX extends StatelessWidget {
  StatisticsAndFiguresSectionX({super.key, this.header, this.parentScrollController, this.padding});
  final Widget? header;
  final EdgeInsets? padding;
  final ScrollController? parentScrollController;
  final StatisticsAndFiguresController controller =
  Get.put(StatisticsAndFiguresController());
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX(
      padding: padding,
      fetchData: controller.getData,
      parentScrollController: parentScrollController,
      isHideHeaderIfError: true,
      isHideHeaderIfEmpty: true,
      isHideEmpty: true,
      isHideHeaderIfLoading: false,
      isShowNoMoreData: false,
      isExpanded: false,
      isHeaderPadding: false,
      header: header,
      initLoading: Column(children: [
        for(int i=0;i<3;i++)
        const ShimmerAnimationX(
          width: double.infinity,
          height: 80,
          margin: EdgeInsets.only(bottom: 12),
        ).fadeAnimationX(100+40*i),
      ],),
      itemBuilder: (data, index) {
        return StatisticHorizontalCardX(
          statistic: data.number,
          subtitle: data.title,
          imageUrl: data.imageUrl,
          textAfterNumber: data.textAfterNumber,
        ).fadeAnimationX(100+40*index);
      },
    );
  }
}
