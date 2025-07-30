import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../Core/Controller/Filter/filterByOrganizationController.dart';
import '../../../../Data/data.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show available organizations to choose from
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

filterByOrganizationSheetX({required FilterByOrganizationControllerX controller}) {
  //============================================================================
  // Content

  return bottomSheetX(
    title: "Filter by program",
    child: ScrollRefreshLoadMoreX<(String, OrganizationX)>(
      fetchData: controller.getData,
      firstFixedData: [controller.fixedData],
      pageSize: 10,
      isEmptyCenter: false,
      isExpanded: false,
      initLoading: const SizedBox(
        height: 180,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      emptyMessage: "There are no association programs.",
      itemBuilder: (data, index) {
        return RadioButtonX<(String, OrganizationX)>(
          groupValue: controller.optionSelected.value,
          value: data,
          label: data.$1,
          onChanged: controller.onChange,
        ).fadeAnimation300;
      },
    ),
  );
}
