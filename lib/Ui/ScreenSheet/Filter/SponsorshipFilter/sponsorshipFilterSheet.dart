import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Filter/sponsorshipFilterController.dart';
import '../../../Widget/widget.dart';
import 'filterByCountrySheet.dart';
import 'filterByGenderSheet.dart';
import 'filterByLanguageSheet.dart';
import 'filterByPreviousReligionSheet.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show sponsorships filtering options
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sponsorshipFilterSheetX({required SponsorshipFilterControllerX controller}) {
  return bottomSheetX(
    title: "Filter results",
    child: Obx(
      () => Column(
        children: [
          /// Country
          MultipleSelectionCardX(
            title: "Country",
            onTap: filterByCountrySheetX,
            selected:
                controller.filterByCountryController.countrySelected.value,
          ).fadeAnimation200,
          const SizedBox(height: 10),

          /// Gender
          MultipleSelectionCardX(
            title: "Gender",
            onTap: filterByGenderSheetX,
            selected: controller.filterByGenderController.genderSelected.value,
          ).fadeAnimation300,
          const SizedBox(height: 10),

          /// Language
          MultipleSelectionCardX(
            title: "Language",
            onTap: filterByLanguageSheetX,
            selected:
                controller.filterByLanguageController.languageSelected.value,
          ).fadeAnimation300,
          const SizedBox(height: 10),

          /// Hiding the option of the previous religion other than sponsoring the new Muslim
          if(controller.isNewMuslim)
          /// Previous religion
          MultipleSelectionCardX(
            title: "Previous religion",
            onTap: filterByPreviousReligionSheetX,
            selected: controller.filterByPreviousReligionController
                .previousReligionSelected.value,
          ).fadeAnimation300,
          const SizedBox(height: 10),

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
                child: ButtonX.gray(
                  onTap: controller.clearDate,
                  text: "Clear all",
                ),
              ),
            ],
          ).fadeAnimation400
        ],
      ),
    ),
  );
}
