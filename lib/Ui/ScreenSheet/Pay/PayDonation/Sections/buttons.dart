import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../UI/Widget/widget.dart';

class ButtonsSectionX extends StatelessWidget {
  const ButtonsSectionX(this.controller, this.onlyAddToCart, {super.key});
  final PayDonationControllerX controller;
  final bool onlyAddToCart;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Add to Cart Button
        if (onlyAddToCart)
          Obx(
            () => AddToCartButtonX(
              onAddToCart: controller.onAddToCart,
              addToCartButtonState: controller.addToCartButtonState.value,
            ),
          ).fadeAnimation500,

        /// Pay Donation & Add to Cart Buttons
        if (!onlyAddToCart)
          Obx(
            () => AddToCartAndDonationButtonsX(
              onDonation: () async => await controller.onAddToCart(isPay: true),
              onAddToCart: controller.onAddToCart,
              payDonationButtonState: controller.buttonState.value,
              addToCartButtonState: controller.addToCartButtonState.value,
            ),
          ).fadeAnimation500,
      ],
    );
  }
}
