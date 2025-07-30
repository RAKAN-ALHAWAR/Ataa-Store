import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class DynamicOptionsSectionX extends GetView<MoreSectionsController> {
  const DynamicOptionsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX(
      padding: const EdgeInsets.only(
        right: StyleX.hPaddingApp,
        left: StyleX.hPaddingApp,
        top: StyleX.vPaddingApp,
        bottom: 140,
      ),
      initLoading: Column(children: [
        for(int i=0;i<10;i++)
          const ShimmerAnimationX(height: 66,margin: EdgeInsets.only(bottom: 8)),
      ],),
      noMoreDataMessage: 'There are no more pages currently.',
      fetchData: controller.getData,
      itemBuilder: (page, index) {
        return MoreCardX(
            title: page.title,
            onTap: ()=> controller.onDynamicPage(page),
        ).fadeAnimation200;
      },
    );
  }
}