import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Sort/sortByGeneralController.dart';
import '../../../../Data/data.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show sorting options by popular options
/// like: Latest addition, The remaining amount is from most to least, etc...
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sortByGeneralSheetX({required SortByGeneralControllerX controller}){
  return bottomSheetX(
    title: "Sort by",
    child: Obx(
          () => Column(
        children: [
          /// Options Cards
          ...GeneralSortEX.values.map(
                (val) => RadioButtonX(
              groupValue:
              controller.generalSelected.value,
              value: val,
              onChanged: controller.onChange,
              label: val.name,
            ).fadeAnimation300,
          ),
        ],
      ),
    ),
  );
}