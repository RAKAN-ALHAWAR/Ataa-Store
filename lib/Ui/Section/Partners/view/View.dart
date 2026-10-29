import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Config/config.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';
import '../controller/Controller.dart';

class PartnersSectionX extends StatelessWidget {
  PartnersSectionX({super.key, this.header, this.padding});
  final Widget? header;
  final EdgeInsets? padding;
  final PartnersController controller = Get.put(PartnersController());
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX(
      padding: padding,
      fetchData: controller.getData,
      scrollDirection: Axis.horizontal,
      isHideHeaderIfError: true,
      isHideHeaderIfEmpty: true,
      isHideHeaderIfLoading: false,
      isHeaderPadding: false,
      isGetMoreEnabled: false,
      isHideEmpty: true,
      header: header,
      initLoading: Row(
        children: [
          for (int i = 0; i < 3; i++)
            const ShimmerAnimationX(
              width: StyleX.partnerCardWidth,
              height: StyleX.partnerCardHeight,
              margin: EdgeInsetsDirectional.only(end: 12),
            ).fadeAnimationX(100+40*i),
        ],
      ),
      itemBuilder: (data, index) {
        return PartnerCardX(
          partner: data,
          onTap: controller.onTap,
        ).fadeAnimationX(100+40*index);
      },
    );
  }
}
