import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';
import '../../../../Animation/animation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class CampaignsSectionX extends GetView<HomeController> {
  const CampaignsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX<CampaignX>(
      fetchData: controller.getCampaigns,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 20,
      ),

      /// Header
      header: SectionTitleX(
        title: "Donation campaigns",
        icon: IconX.speakerPhone,
        showMore: controller.onCampaignsMore,
      ),
      isHideHeaderIfEmpty: true,
      isHideHeaderIfError: true,
      isHideHeaderIfLoading: false,
      isHeaderPadding: false,

      /// If there is an error in this section or it is empty, the section does not appear
      empty: const SizedBox(),
      errorWidget: (_) => const SizedBox(),

      /// Items
      itemBuilder: (data, index) {
        return DonationCardX(
          doneImageUrl: controller.app.generalSettings.projectCompletionImageUrl,
          donation: data.donation,
          campaign: data,
          onTap: () async => controller.onTapCampaign(data),
          onDonation: (_) async => controller.onCampaignDonation(data),
          onAddToCart: (_) async => controller.onCampaignAddToCart(data),
          isSmallCard: true,
        ).fadeAnimation300;
      },

      /// If the data is still loading, a flash is displayed in the same shape as the item expected to appear
      initLoading: Row(
        children: [
          for (int i = 0; i < 3; i++)
            const ShimmerAnimationX(
              height: StyleX.donationCardHeight,
              width: StyleX.donationCardWidthSM,
              margin: EdgeInsetsDirectional.only(end: 14),
            )
        ],
      ),
    );
  }
}
