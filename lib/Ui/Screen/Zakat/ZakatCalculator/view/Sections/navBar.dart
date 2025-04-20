import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class NavBarSectionX extends GetView<ZakatCalculatorController> {
  const NavBarSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        /// If one of the Zakat sections is activated, the calculator is displayed
        if (controller.isHasZakat()) {
          return ContainerX(
            isShadow: true,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(StyleX.radiusMd),
            ),
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 10,
              left: 30,
              right: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Total Money Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: FittedBox(
                        child: TextX(
                          "Total Zakat Due",
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Row(
                      children: [
                        TextX(
                          FunctionX.formatLargeNumber(
                              controller.totalMoney.value),
                          fontWeight: FontWeight.w700,
                          style: TextStyleX.titleLarge,
                        ),
                        const SizedBox(width: 6),
                        const Icon(IconX.sar, size: 16)
                      ],
                    ),
                  ],
                ).fadeAnimationX(400, isFromEnd: true),
                const SizedBox(height: 12),

                /// Additional amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// title
                    Flexible(
                      child: FittedBox(
                        child: Row(
                          children: [
                            const TextX(
                              "Additional amount",
                            ),
                            TextX(
                              " (${"optional".tr})",
                              style: TextStyleX.supTitleLarge,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),

                    /// Additional amount Input
                    SizedBox(
                        width: 150,
                        child: Form(
                          key: controller.additionalAmountFormKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: TextFieldX(
                            controller: controller.additionalAmount,
                            textInputType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            hint: "0",
                            color: Theme.of(context).cardColor,
                            errorMaxLines: 2,
                            validate: ValidateX.moneyOptional,
                            onChangedFocus: (val) =>
                                controller.isFocusAdditionalAmount.value = val,
                            onChanged: (_) =>
                                controller.calculateAdditionalAmount(),
                            suffixWidget: Icon(
                              IconX.sar,
                              size: 16,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),),
                  ],
                ).fadeAnimationX(400, isFromEnd: true),
                const SizedBox(height: 8),
                Obx(
                  () => MultipleSelectionCardX(
                    title: controller.zakatSelectionController.optionSelected
                            .value?.donationBasic.name ??
                        'Choose a donation project',
                    onTap: controller.onTapZakatSelection,
                    asInputField: controller.zakatSelectionController
                            .optionSelected.value?.donationBasic.name ==
                        null,
                  ),
                ).fadeAnimationX(400, isFromEnd: true),

                /// line
                const SizedBox(height: 8),
                const Divider().fadeAnimationX(400, isFromEnd: true),
                const SizedBox(height: 6),

                /// Total amount of zakat
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Title
                    const Flexible(
                      child: FittedBox(
                        child: TextX(
                          "Total Money",
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),

                    /// The value of Zakat is displayed after the value of gold is brought
                    Row(
                      children: [
                        TextX(
                          FunctionX.formatLargeNumber(controller.totalZakat.value),
                          fontWeight: FontWeight.w700,
                          style: TextStyleX.titleLarge,
                        ),
                        const SizedBox(width: 6),
                        const Icon(IconX.sar,size: 17)
                      ],
                    ),
                  ],
                ).fadeAnimationX(400, isFromEnd: true),
                const SizedBox(height: 8),

                /// Buttons
                Row(
                  children: [
                    Flexible(
                      child: ButtonStateX(
                        disabled: controller.totalZakat.value == 0,
                        state: controller.payButtonState.value,
                        onTap: () async =>
                            await controller.onAddToCart(isPay: true),
                        text: "Pay Zakat Now",
                        iconData: Icons.payments_rounded,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      child: ButtonStateX.second(
                        disabled: controller.totalZakat.value == 0,
                        state: controller.addToCartButtonState.value,
                        onTap: controller.onAddToCart,
                        text: "Add to cart",
                        iconData: Icons.shopping_cart_rounded,
                      ),
                    ),
                  ],
                ).fadeAnimationX(400, isFromEnd: true),
              ],
            ),
          ).fadeAnimationX(300, isFromEnd: true);
        } else {
          /// If there are no activated zakat sections, the entire section is hidden
          return const SizedBox();
        }
      },
    );
  }
}
