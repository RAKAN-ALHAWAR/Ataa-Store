import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class ColorsBarSectionX extends GetView<CreateGiftController> {
  const ColorsBarSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const TextX(
          "Choose the card color",
          fontWeight: FontWeight.w700,
        ).paddingSymmetric(horizontal: StyleX.hPaddingApp).fadeAnimation500,
        const SizedBox(height: 14),

        /// Colors Options
        Obx(
          () => ColorBarSelectorX(
            colors: controller.colors,
            colorSelectedIndex: controller.colorSelectedIndex.value,
            onChangeColor: controller.onChangeColor,
          ),
        ).fadeAnimation500,
        const SizedBox(height: 24),
      ],
    );
  }
}
