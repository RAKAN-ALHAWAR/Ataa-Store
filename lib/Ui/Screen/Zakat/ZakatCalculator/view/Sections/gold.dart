import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class GoldSectionX extends GetView<ZakatCalculatorController> {
  const GoldSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ZakatCalculatorCardX(
        title: "Zakat on gold",
        isOpen: controller.isGold.value,
        onChangeOpen: controller.onOpenGold,
        error: controller.goldError.value,
        isLoading: controller.goldIsLoading.value,
        isDone: controller.goldIsDone.value,
        child: Form(
          key: controller.goldFormKey,
          autovalidateMode: controller.goldAutoValidate,
          child: Column(
            children: [
              /// Duplicate the item in grams because the karat may be empty when it is first created
              for (int index = 0; index < controller.goldGrams.length; index++)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Karat Input
                        Flexible(
                          child: Column(
                            children: [
                              const LabelInputX("Caliber"),
                              DropdownX<dynamic>(
                                color: Theme.of(context).cardColor,
                                value: controller.getGoldKaratValueToShowInScreen(index),
                                list: controller.getGoldKaratsListToShowInScreen(),
                                onChanged: (val) => controller.onChangeGoldKarat(
                                    val.toString(), index),
                                hint: "-- Choose --",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),

                        /// Gram Input
                        Flexible(
                          child: Column(
                            children: [
                              const LabelInputX("Weight in grams"),
                              TextFieldX(
                                /// To calculate the value of Zakat after changing the value
                                onEditingComplete: (_) => controller.calculateGold(),
                                controller: controller.goldGrams[index],
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
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),

                        /// Remove row of gold zakat
                        InkWell(
                          onTap: () => controller.onRemoveZakatGoldRow(index),
                          child: Icon(
                            Icons.remove_circle_outline_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      height: 30,
                    )
                  ],
                ).fadeAnimation200,

              /// Add new row of gold zakat
              InkWell(
                onTap: controller.onAddZakatGoldRow,
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    TextX(
                      "Add another caliber",
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ).fadeAnimation300,
    );
  }
}
