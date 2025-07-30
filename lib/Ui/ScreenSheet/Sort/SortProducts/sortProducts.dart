import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Sort/sortProductsController.dart';
import '../../../../Data/data.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View product sorting options
/// like: Best seller, Price from high to low, etc...
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

sortProductsSheetX({required SortProductsControllerX controller}) {
  return bottomSheetX(
    title: "Sort by",
    child: Obx(
      () => Column(
        children: [
          /// Options Cards
          ...ProductSortEX.values.map(
            (val) => RadioButtonX(
              groupValue: controller.sortSelected.value,
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
