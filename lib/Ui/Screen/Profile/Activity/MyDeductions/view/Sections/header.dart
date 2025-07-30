import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../../UI/Widget/widget.dart';

class HeaderSectionX extends StatelessWidget {
  const HeaderSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        TextX(
          "Deductions",
          style: TextStyleX.headerSmall,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 6),

        /// Description
        TextX(
          "All deductions that have been subscribed to.",
          style: TextStyleX.titleSmall,
          color: Get.theme.colorScheme.secondary,
          maxLines: 4,
        ),
        const SizedBox(width: double.maxFinite)
      ],
    );
  }
}
