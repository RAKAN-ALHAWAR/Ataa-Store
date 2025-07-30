import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Controller/SelectedOptions/zakatSelectionController.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show available organizations to choose from
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

zakatSelectionSheetX({required ZakatSelectionControllerX controller}) {
  //============================================================================
  // Content

  return bottomSheetX(
    title: "Donation project",
    scrollController: controller.scrollController,
    child: ScrollRefreshLoadMoreX<DonationX>(
      parentScrollController: controller.scrollController,
      fetchData: controller.getData,
      pageSize: 10,
      isEmptyCenter: false,
      isExpanded: true,
      initLoading: const SizedBox(
        height: 180,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      emptyMessage: "There are no current donation projects",
      itemBuilder: (data, index) {
        return RadioButtonX<String>(
          groupValue: controller.optionSelected.value?.id,
          value: data.id,
          label: data.donationBasic.name,
          onChanged: (_)=> controller.onChange(data),
        ).fadeAnimation300;
      },
    ),
  );
}
