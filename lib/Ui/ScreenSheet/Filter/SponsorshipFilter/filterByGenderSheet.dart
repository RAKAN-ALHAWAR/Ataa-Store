import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Filter/filterByGenderController.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show genders to choose from
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

filterByGenderSheetX() {
  //============================================================================
  // Injection of required controls

  final FilterByGenderControllerX controller = Get.find();

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Filter by gender",
    child: Obx(
      () => Column(
        children: [
          /// Options Cards
          ...controller.options.map(
            (val) => RadioButtonX(
              groupValue: controller.genderSelected.value,
              value: val,
              onChanged: controller.onChange,
              label: val,
            ).fadeAnimation300,
          ),
        ],
      ),
    ),
  );
}
