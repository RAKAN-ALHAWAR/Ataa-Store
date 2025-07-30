import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class SilverSectionX extends GetView<ZakatCalculatorController> {
  const SilverSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ZakatCalculatorCardX(
        title: "Zakat on silver",
        isOpen: controller.isSilver.value,
        onChangeOpen: controller.onOpenSilver,
        error: controller.silverError.value,
        isLoading: controller.silverIsLoading.value,
        isDone: controller.silverIsDone.value,
        child: Column(
          children: [
            const LabelInputX("Enter the total weight", marginTop: 0),
            Form(
              key: controller.silverFormKey,
              autovalidateMode: AutovalidateMode.always,
              child: TextFieldX(
                /// To calculate the value of Zakat after changing the value
                onEditingComplete: (_) => controller.calculateSilver(),
                controller: controller.silver,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                color: Theme.of(context).cardColor,
                validate: ValidateX.gramOptional,
                errorMaxLines: 2,
                hint: "0",
                suffixWidget: TextX(
                  "gram",
                  style: TextStyleX.titleSmall,
                  color: Get.theme.colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ).fadeAnimation300,
    );
  }
}
