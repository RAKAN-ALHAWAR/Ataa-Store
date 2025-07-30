import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Filter/filterController.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// A general filtering option that serves more than one department
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

generalFilterSheetX({
  required FilterControllerX controller,
}) {
  return bottomSheetX(
    title: "Filter and sort",
    child: Column(
      children: [
        /// Zakat
        if (controller.isShowZakat && !controller.isShowDeduction)
          Obx(
            () => SwitchX(
              value: controller.isZakat.value,
              onChange: controller.onChangeZakat,
              label: "Zakat disbursement only",
              margin: const EdgeInsets.only(bottom: 5),
            ).fadeAnimation200,
          ),

        /// Frequency
        if (controller.isShowDeduction)
          Obx(
            () => MultipleSelectionCardX(
              title: "Filter by frequency",
              onTap: controller.onTapSortByFrequency,
              selected: controller
                  .sortByFrequencyController.frequencySelected.value.name,
            ),
          ).marginOnly(bottom: 10).fadeAnimation200,

        /// Organization
        if (controller.isShowOrganization)
          Obx(
            () => MultipleSelectionCardX(
              title: "Filter by program",
              onTap: controller.onTapFilterByOrganization,
              selected:
                  controller.filterByOrgController.optionSelected.value.$1,
            ),
          ).marginOnly(bottom: 10).fadeAnimation300,

        if(controller.isShowSort)
        /// Sort
        Obx(
          () => MultipleSelectionCardX(
            title: "Sort by",
            onTap: controller.onTapSortByGeneral,
            selected:
                controller.sortByGeneralController.generalSelected.value.name,
          ),
        ).marginOnly(bottom: 10).fadeAnimation300,

        /// Buttons
        Row(
          children: [
            Flexible(
              child: ButtonX(
                onTap: controller.onFilter,
                text: "Apply",
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: ButtonX.second(
                onTap: controller.clearData,
                text: "Clear all",
              ),
            )
          ],
        ).fadeAnimation400
      ],
    ),
  );
}
