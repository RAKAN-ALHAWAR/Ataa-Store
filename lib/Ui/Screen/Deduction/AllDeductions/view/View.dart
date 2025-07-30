// ignore_for_file: invalid_use_of_protected_member

import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/Model/Deduction/deduction.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class AllDeductionsView extends GetView<AllDeductionsController> {
  const AllDeductionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(title: "Deductions", actions: [CartIconButtonsX()]),
      body: SafeArea(
        child: Obx(
          () {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.app.generalSettings.isActiveDeductionSearch)
                  SearchBarX(
                    disabledSearch:
                        !controller.app.generalSettings.isActiveDeductionSearch,
                    search: controller.search,
                    onTapFilter: controller.onFilter,
                  ).fadeAnimation200,
                ScrollRefreshLoadMoreX<DeductionX>(
                  fetchData: controller.getData,
                  filters: controller.filterController.filters.value,
                  orderBy: controller.filterController.orderBy.value,
                  searchQueryController: controller.search,
                  padding: EdgeInsets.only(
                    right: StyleX.hPaddingApp,
                    left: StyleX.hPaddingApp,
                    top: controller.app.generalSettings.isActiveDeductionSearch
                        ? 6
                        : StyleX.vPaddingApp,
                    bottom: StyleX.vPaddingApp,
                  ),
                  initLoading: Column(
                    children: [
                      for (int i = 0; i < 5; i++)
                        ShimmerAnimationShapeX.deductionCard()
                    ],
                  ),
                  emptyMessage: "There are no current deductions.",
                  itemBuilder: (data, index) {
                    return DeductionCardX(
                      onTap: controller.onTapDeduction,
                      onSubscribe: controller.onSubscriptionDonation,
                      deduction: data,
                    ).fadeAnimation300;
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
