import 'package:flutter/material.dart';
import '../../../../Core/Controller/SelectedOptions/quickDonationSelectionController.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View organizations to choose one of them
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

quickDonationSelectionSheetX(QuickDonationSelectionController controller) {
  return bottomSheetX(
    title: "Donation project",
    scrollController: controller.scrollController,
    child: ScrollRefreshLoadMoreX<DonationX>(
      fetchData: controller.getData,
      parentScrollController: controller.scrollController,
      isGetMoreEnabled: false,
      isScrollEnabled: false,
      initLoading: const SizedBox(
        height: 180,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      isExpanded: false,
      itemBuilder: (data, index) {
        return RadioButtonX<String>(
          label: data.donationBasic.name,
          value: data.id,
          onChanged: (_)=>controller.onChange(data),
          groupValue: controller.selected.value?.id,
        );
      },
    ),
  );
}
