import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Animation/animation.dart';
import '../../controller/Controller.dart';

class AdsSectionX extends GetView<HomeController> {
  const AdsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getAds(),
      builder: (context, snapshot) {

        /// If the data is still loading, a flash is displayed in the same shape as the item expected to appear
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBarHomeX(
            child: ShimmerAnimationX(
              height: StyleX.adsCardHeight,
              margin:const EdgeInsets.only(right: StyleX.hPaddingApp,left: StyleX.vPaddingApp,bottom: 20.0),
              borderRadius: BorderRadius.circular(StyleX.radiusMd),
            ),
          );
        }

        /// If there is an error in this section or it is empty, the section does not appear
        if (snapshot.hasError || controller.ads.isEmpty) {
          /// this height for reset height app bar home design
          return const SizedBox(height: 35);
        }

        /// When the data has finished loading properly, it is displayed
        return AppBarHomeX(
          child: AdsCardsX(
            ads: controller.ads,
            onTap: controller.onAdsLink,
            onTapButton:controller.onAdsLinkButton,
          ).fadeAnimation200,
        );
      },
    );
  }
}
