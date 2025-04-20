import 'package:ataa/Data/data.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import 'Sections/introduction.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class AllCampaignsView extends GetView<AllCampaignsController> {
  const AllCampaignsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Donation campaigns",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: Obx(
              () {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: StyleX.hPaddingApp,
                vertical: StyleX.vPaddingApp,
              ),
              controller: controller.scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Info
                  const IntroductionSectionX(),
                  const SizedBox(height: 16),

                  /// Create campaign button
                  ButtonX(
                    marginVertical: 0,
                    text: "Create your own campaign",
                    iconData: IconX.speakerPhone,
                    onTap: controller.createCampaign,
                  ).fadeAnimation200,

                  if(controller.app.generalSettings.isActiveCampaignSearch)
                    SearchBarX(
                      search: controller.search,
                      onTapFilter: controller.onFilter,
                      hint:'Search by campaign or project name',
                      isMargin: false,
                    ).marginOnly(top: 16).fadeAnimation200,

                  TextX(
                    'Donation campaigns',
                    style: TextStyleX.titleLarge,
                    color: Get.theme.primaryColor,
                  ).paddingSymmetric(vertical: 10).fadeAnimation200,

                  const SizedBox(height: 2),
                  ScrollRefreshLoadMoreX<CampaignX>(
                    fetchData: controller.getData,
                    orderBy: (controller.sortByGeneralController.generalSelected.value!= GeneralSortEX.all)?controller.sortByGeneralController.generalSelected.value.name:null,
                    searchQueryController: controller.search,
                    isEmptyCenter: false,
                    parentScrollController: controller.scrollController,
                    padding: const EdgeInsets.only(top: 8),
                    initLoading: Column(
                      children: [
                        for (int i = 0; i < 5; i++)
                          ShimmerAnimationShapeX.donationCard()
                      ],
                    ),
                    emptyMessage: "There are no current campaigns",
                    itemBuilder: (data, index) {
                      return DonationCardX(
                        donation: data.donation,
                        campaign:data,
                        doneImageUrl: controller.app.generalSettings.projectCompletionImageUrl,
                        onAddToCart: (_) async => controller.onAddToCart(data),
                        onTap: ()async=>controller.onTapCampaign(data),
                        onDonation: (_)async=>controller.onCampaignDonation(data),
                      ).fadeAnimation300;
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
