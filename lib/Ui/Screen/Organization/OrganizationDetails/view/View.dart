// ignore_for_file: invalid_use_of_protected_member

import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/Model/Donation/donation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/header.dart';
import 'Sections/loading.dart';

class OrganizationDetailsView extends GetView<OrganizationDetailsController> {
  const OrganizationDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Our Programs",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: StyleX.hPaddingApp,
              vertical: StyleX.vPaddingApp,
            ),
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title & Subtitle
                const HeaderSectionX(isMargin: false),

                /// Search Bar
                if (controller.app.generalSettings.isActiveDonationSearch)
                  SearchBarX(
                    search: controller.search,
                    onTapFilter: controller.onFilter,
                    isMargin: false,
                    disabledSearch:
                        !controller.app.generalSettings.isActiveDonationSearch,
                  ).marginOnly(top: 10).fadeAnimation200,

                const SizedBox(height: 10),

                TextX(
                  'Program Donation Opportunities',
                  style: TextStyleX.titleLarge,
                ).paddingSymmetric(vertical: 10).fadeAnimation200,
                ScrollRefreshLoadMoreX<DonationX>(
                  fetchData: controller.getData,
                  filters: controller.filterController.filters.value,
                  orderBy: controller.filterController.orderBy.value,
                  searchQueryController: controller.search,
                  parentScrollController: controller.scrollController,
                  padding: const EdgeInsets.only(top: 10),
                  initLoading: const LoadingSectionX(),
                  emptyMessage: "There are no current donation projects",
                  itemBuilder: (data, index) {
                    return DonationCardX(
                      donation: data,
                      doneImageUrl: controller
                          .app.generalSettings.projectCompletionImageUrl,
                      onDonation: controller.onPayDonation,
                      onAddToCart: controller.onAddToCart,
                    ).fadeAnimation300;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
