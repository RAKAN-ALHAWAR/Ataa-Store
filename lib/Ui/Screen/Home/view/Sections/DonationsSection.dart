import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/Model/Donation/donation.dart';
import '../../../../Animation/animation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class DonationsSectionX extends GetView<HomeController> {
  const DonationsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX<DonationX>(
      fetchData: controller.getDonations,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 20,
      ),

      /// Header
      header: SectionTitleX(
        title: "Special donation opportunities",
        icon: IconX.sparkles,
        showMore: controller.onDonationsMore,
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
          donation: data,
          onDonation: controller.onPayDonation,
          onAddToCart: controller.onDonationAddToCart,
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
