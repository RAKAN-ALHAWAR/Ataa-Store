import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class SharesSectionX extends GetView<ZakatCalculatorController> {
  const SharesSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ZakatCalculatorCardX(
        title: "Zakat on shares",
        isOpen: controller.isShares.value,
        onChangeOpen: controller.onOpenShares,
        error: controller.sharesError.value,
        isLoading: controller.sharesIsLoading.value,
        isDone: controller.sharesIsDone.value,
        child: Form(
          key: controller.sharesFormKey,
          autovalidateMode: controller.sharesAutoValidate,
          child: Column(
            children: [
              /// Repetition of elements in the number of names of stock companies
              for (int i = 0; i < controller.stockNames.length; i++)
                Column(
                  children: [
                    /// Company Name Label & Button Remove row of Share zakat
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Company Name Label
                        const LabelInputX("Company Name"),

                        /// Remove row of Share zakat
                        InkWell(
                          onTap: () => controller.onRemoveZakatShareRow(i),
                          child: Icon(
                            Icons.remove_circle_outline_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 16,
                          ),
                        ),
                      ],
                    ),

                    /// Company Name Input
                    TextFieldX(
                      controller: controller.stockNames[i],
                      textInputType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      hint: "name",
                      color: Theme.of(context).cardColor,
                      validate: ValidateX.nameNoRequired,
                    ),
                    const SizedBox(height: 10),

                    /// Inputs of Shares
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Number of Shares
                        Flexible(
                          child: Column(
                            children: [
                              const LabelInputX("Number of Shares"),
                              NumberFieldX(
                                onChanged: (double val) =>
                                    controller.onChangeShareNumber(val, i),
                                value: controller.sharesNumbers[i],
                                min: 1,
                                color: Theme.of(context).cardColor,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),

                        /// Share value
                        Flexible(
                          child: Column(
                            children: [
                              const LabelInputX("Share value"),
                              TextFieldX(
                                /// To calculate the value of Zakat after changing the value
                                onEditingComplete: (_) => controller.calculateShares(),
                                controller: controller.sharesValues[i],
                                textInputType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                color: Theme.of(context).cardColor,
                                validate: ValidateX.moneyOptional,
                                errorMaxLines: 2,
                                hint: "0",
                                suffixWidget: Icon(
                                  IconX.sar,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Line
                    const Divider(height: 30)
                  ],
                ).fadeAnimation200,

              /// Add new row of share zakat
              InkWell(
                onTap: controller.onAddZakatShareRow,
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline_rounded,
                      color: Theme.of(context).primaryColor,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    TextX(
                      "Add another company",
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ).fadeAnimation400,
    );
  }
}
