import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../GeneralState/empty.dart';
import '../../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/header.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';

class MyCampaignsView extends GetView<MyCampaignsController> {
  const MyCampaignsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Donation campaigns",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: GetBuilder<MyCampaignsController>(
          builder: (controller) => AbsorbPointer(
            absorbing: controller.isLoading,
            child: ScrollRefreshLoadMoreX(
              key: controller.scrollRefreshLoadMoreKey,
              fetchData: controller.getData,
              padding: const EdgeInsets.symmetric(
                vertical: StyleX.vPaddingApp,
                horizontal: StyleX.hPaddingApp,
              ),
              initLoading: const LoadingSectionX(),
              pageSize: 20,
              empty: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title & Description
                  const HeaderSectionX(isPadding:false),
                  const EmptyView(
                    isMargin: false,
                    message: "You haven't created any campaign yet",
                  ).paddingOnly(top: 16, bottom: 8),

                  /// Create Button
                  ButtonX(
                    text: "Create a new campaign",
                    onTap: controller.createCampaign,
                  ).fadeAnimation200,
                ],
              ),
              header: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderSectionX(),
                  ButtonX(
                    text: 'Create a new campaign',
                    onTap: controller.createCampaign,
                    marginHorizontal: StyleX.hPaddingApp,
                  ).fadeAnimation100,
                ],
              ),
              isHeaderPadding: false,
              isHideHeaderIfEmpty: true,
              isHideHeaderIfError: true,
              isHideHeaderIfLoading: false,
              spaceBetweenHeaderAndContent: 16,
              itemBuilder: (data, index) {
                return MyCampaignCardX(
                  campaign: data,
                  onTap: controller.onTapCampaign,
                  onEdit: controller.onEdit,
                  openShare: controller.openShare,
                ).fadeAnimation300;
              },
            ),
          ),
        ),
        // child: FutureBuilder(
        //   future: controller.getData(),
        //   builder: (context, snapshot) {
        //     /// Loading State
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const LoadingSectionX();
        //     }
        //
        //     /// Error State
        //     if (snapshot.hasError) {
        //       return ErrorView(
        //         error: snapshot.error.toString(),
        //       );
        //     }
        //
        //     /// Main Content
        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         /// Title & Description
        //         const HeaderSectionX(),
        //
        //         /// Empty State
        //         if (controller.campaigns.isEmpty)
        //           const EmptyView(
        //             message: "You haven't created any campaign yet",
        //             isMargin: false,
        //           ).paddingOnly(top: 16,bottom: 8).marginSymmetric(horizontal: StyleX.hPaddingApp),
        //
        //         /// Create Button
        //         ButtonX(
        //           marginHorizontal: StyleX.hPaddingApp,
        //           text: "Create a new campaign",
        //           onTap: controller.createCampaign,
        //         ).fadeAnimation200,
        //         const SizedBox(height: 8),
        //
        //         /// My Campaigns
        //         Expanded(
        //           child: ListView.builder(
        //             padding: const EdgeInsets.only(
        //               top: 10,
        //               bottom: 30,
        //               left: StyleX.hPaddingApp,
        //               right: StyleX.hPaddingApp,
        //             ),
        //             itemCount: controller.campaigns.length,
        //             itemBuilder: (context, index) => MyCampaignCardX(
        //               isPreview: true,
        //               campaign: controller.campaigns[index],
        //               onTap: controller.onTapCampaign,
        //             ).fadeAnimation400,
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        // ),
      ),
    );
  }
}
