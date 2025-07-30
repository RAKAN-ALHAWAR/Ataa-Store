import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Filter/filterByCountryController.dart';
import '../../../GeneralState/error.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show available countries to choose from
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

filterByCountrySheetX() {
  //============================================================================
  // Injection of required controls

  final FilterByCountryControllerX controller = Get.find();

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Filter by country",
    child: FutureBuilder(
      future: controller.getData(),
      builder: (context, snapshot) {
        /// Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 180,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        /// Error State
        if (snapshot.hasError) {
          return ErrorView(
            error: snapshot.error.toString(),
          );
        }

        /// Main Content
        return Obx(
          () => Column(
            children: [
              /// Options Cards
              ...controller.options.map(
                (val) => RadioButtonX(
                  groupValue: controller.countrySelected.value,
                  value: val,
                  onChanged: controller.onChange,
                  label: val,
                ).fadeAnimation300,
              ),
            ],
          ),
        );
      },
    ),
  );
}
