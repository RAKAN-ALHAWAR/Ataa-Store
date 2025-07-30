import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';
import '../../../../Animation/animation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class AssociationProgramsSectionX extends GetView<HomeController> {
  const AssociationProgramsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX<OrganizationX>(
      fetchData: controller.getOrganizations,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 20,
      ),

      /// Header
      header: const SectionTitleX(
        title: "Our Programs",
        icon: IconX.sparkles,
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
        return OrganizationCardX(
          org: data,
          onTap: controller.onTapOrganization,
        ).fadeAnimation300;
      },

      /// If the data is still loading, a flash is displayed in the same shape as the item expected to appear
      initLoading: Row(
        children: [
          for (int i = 0; i < 3; i++)
            const ShimmerAnimationX(
              height: StyleX.organizationCardHeight,
              width: StyleX.organizationCardWidth,
              margin: EdgeInsetsDirectional.only(end: 14),
            )
        ],
      ),
    );
  }
}
