// ignore_for_file: invalid_use_of_protected_member

import 'package:ataa/Ui/Widget/Basic/Other/scrollRefreshLoadMore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/Model/Donation/donation.dart';
import '../../../../Animation/animation.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class AllDonationView extends GetView<AllDonationController> {
  const AllDonationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (controller.app.generalSettings.isActiveDonationSearch)
                SearchBarX(
                  search: controller.search,
                  onTapFilter: controller.onFilter,
                ).fadeAnimation200,
              ScrollRefreshLoadMoreX<DonationX>(
                fetchData: controller.getData,
                filters: controller.filterController.filters.value,
                orderBy: controller.filterController.orderBy.value,
                searchQueryController: controller.search,
                padding: EdgeInsets.only(
                  right: StyleX.hPaddingApp,
                  left: StyleX.hPaddingApp,
                  top: controller.app.generalSettings.isActiveDonationSearch
                      ? 6
                      : StyleX.vPaddingApp,
                  bottom: 160,
                ),
                initLoading: Column(
                  children: [
                    for (int i = 0; i < 5; i++)
                      ShimmerAnimationShapeX.donationCard()
                  ],
                ),
                emptyMessage: "There are no current donation projects",
                itemBuilder: (data, index) {
                  return DonationCardX(
                    doneImageUrl: controller
                        .app.generalSettings.projectCompletionImageUrl,
                    onDonation: controller.onDonationDonation,
                    donation: data,
                    onAddToCart: controller.onDonationAddToCart,
                  ).fadeAnimation300;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
