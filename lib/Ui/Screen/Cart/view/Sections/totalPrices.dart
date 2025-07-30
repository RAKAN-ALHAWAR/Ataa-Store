import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../ScreenSheet/Other/DeliveryAddress/deliveryAddress.dart';
import '../../controller/Controller.dart';

class TotalPricesSectionX extends GetView<CartController> {
  const TotalPricesSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    /// Card
    return ContainerX(
      isShadow: true,
      isBorder: true,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(StyleX.radiusMd),
      ),
      padding: const EdgeInsets.only(
        right: 30,
        left: 30,
        bottom: 16,
        top: 26,
      ),
      child: SafeArea(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  /// Cart Summary
                  Row(
                    children: [
                      TextX(
                        "Cart Summary",
                        style: TextStyleX.titleSmall,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          TextX(
                            FunctionX.formatLargeNumber(controller.cartSummary.value),
                            style: TextStyleX.titleSmall,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            IconX.sar,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ).fadeAnimation500,

                  /// Dash Line
                  DashLineX(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    dashColor: context.isDarkMode?null:ColorX.grey.shade200,
                  ).fadeAnimation500,

                  if (controller.cartGeneral.cart.value.isProduct)

                    /// Shipping charges
                    Row(
                      children: [
                        TextX(
                          "Shipping charges",
                          style: TextStyleX.titleSmall,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            TextX(
                              FunctionX.formatLargeNumber(controller.shippingCharges.value),
                              style: TextStyleX.titleSmall,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 6),
                            Icon(
                              IconX.sar,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ).fadeAnimation600,

                  if (controller.cartGeneral.cart.value.isProduct)

                    ///  Dash Line
                    DashLineX(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      dashColor: context.isDarkMode?null:ColorX.grey.shade200,
                    ).fadeAnimation600,
                ],
              ),

              /// Total Cart
              Row(
                children: [
                  TextX(
                    "Total Cart",
                    style: TextStyleX.titleSmall,
                    fontWeight: FontWeight.w700,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      TextX(
                        FunctionX.formatLargeNumber(controller.cartSummary.value + controller.shippingCharges.value),
                        size: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        IconX.sar,
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ).fadeAnimation600,
              const SizedBox(height: 18),

              /// Delivery information button
              if (controller.cartGeneral.cart.value.isProduct)
                ButtonX.second(
                  onTap: () => deliveryAddressSheetX(
                    controller: controller.deliveryAddressController,
                  ),
                  text: controller.deliveryAddressController.isHasData.value
                      ? "Edit delivery address"
                      : "Add delivery address",
                ).fadeAnimation700,

              // /// Payment button
              if (!controller.cartGeneral.cart.value.isProduct ||
                  (controller.cartGeneral.cart.value.isProduct &&
                      controller.deliveryAddressController.isHasData.value))
              ButtonStateX(
                disabled: controller.isLoading.value,
                onTap: controller.onPay,
                state: controller.buttonState.value,
                text: "Complete Payment",
                iconData: Icons.payments_rounded,
              ).fadeAnimation700
            ],
          ),
        ),
      ),
    ).fadeAnimation200;
  }
}
