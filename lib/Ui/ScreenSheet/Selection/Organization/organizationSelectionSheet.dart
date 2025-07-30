import 'package:flutter/material.dart';
import '../../../../Core/Controller/SelectedOptions/organizationSelectionController.dart';
import '../../../../Data/data.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View organizations to choose one of them
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

organizationSelectionSheetX(OrganizationSelectionController controller) {
  return bottomSheetX(
    title: "Donation project",
    child: ScrollRefreshLoadMoreX<OrganizationX>(
      fetchData: controller.getData,
      firstFixedData: [controller.allOption],
      initLoading: const SizedBox(
        height: 180,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      isExpanded: false,
      itemBuilder: (data, index) {
        return RadioButtonX<String>(
          label: data.name,
          value: data.id,
          onChanged: (_)=>controller.onChange(data),
          groupValue: controller.orgSelected.value?.id,
        );
      },
    ),
  );
}
