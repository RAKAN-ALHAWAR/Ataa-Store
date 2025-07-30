import 'package:ataa/Ui/Widget/Basic/Other/scrollRefreshLoadMore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/Model/Deduction/deduction.dart';
import '../../../../Animation/animation.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class DeductionsSectionX extends GetView<HomeController> {
  const DeductionsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX<DeductionX>(
      fetchData: controller.getDeductions,
      scrollDirection: Axis.horizontal,
      isGetMoreEnabled: false,
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 20,
      ),

      /// Header
      header: SectionTitleX(
        title: "Deductions",
        icon: IconX.creditCard,
        showMore: controller.onDeductionsMore,
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
        return DeductionCardX(
          deduction: data,
          onTap: controller.onTapDeduction,
          onSubscribe: controller.onSubscriptionDonation,
          isSmallCard: true,
        ).fadeAnimation300;
      },

      /// If the data is still loading, a flash is displayed in the same shape as the item expected to appear
      initLoading: Row(
        children: [
          for (int i = 0; i < 3; i++)
            const ShimmerAnimationX(
              height: StyleX.deductionCardHeight,
              width: StyleX.deductionCardWidthSM,
              margin: EdgeInsetsDirectional.only(end: 14),
            )
        ],
      ),
    );
  }
}
