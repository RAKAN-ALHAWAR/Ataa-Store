import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class GenderSectionX extends GetView<CreateGiftController> {
  const GenderSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const TextX(
          "The Mahdi's gender is his",
          fontWeight: FontWeight.w700,
        ).fadeAnimation300,
        const SizedBox(height: 14),

        /// Gender Options
        Obx(
          () => Row(
            children: [
              Flexible(
                child: RadioButtonX(
                  margin: EdgeInsets.zero,
                  label: "Male",
                  groupValue: controller.gender.value,
                  value: "male",
                  onChanged: controller.onChangeGender,
                  color: Theme.of(context).cardColor,
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: RadioButtonX(
                  margin: EdgeInsets.zero,
                  label: "Female",
                  groupValue: controller.gender.value,
                  value: "female",
                  onChanged: controller.onChangeGender,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ],
          ),
        ).fadeAnimation300,
        const SizedBox(height: 24),
      ],
    ).paddingSymmetric(horizontal: StyleX.hPaddingApp);
  }
}
