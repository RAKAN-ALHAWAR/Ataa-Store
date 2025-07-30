import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class ButtonsSectionX extends GetView<CreateGiftController> {
  const ButtonsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: ButtonStateX(
                    text: "Dedicate now",
                    marginVertical: 0,
                    state: controller.payButtonState.value,
                    iconData: IconX.gift,
                    onTap: ()async=> await controller.onAddToCart(isPay: true),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ButtonStateX.second(
                    text: "Add to cart",
                    marginVertical: 0,
                    state: controller.addToCartButtonState.value,
                    iconData: Icons.shopping_cart_rounded,
                    onTap: controller.onAddToCart,
                  ),
                ),
              ],
            ).fadeAnimation800,
            const SizedBox(height: 4),
            ButtonStateX.second(
              text: "Preview the donation",
              state: controller.previewButtonState.value,
              iconData: Icons.visibility_rounded,
              onTap: controller.onPreviewGift,
            ).fadeAnimation800,
          ],
        ),
      ),
    );
  }
}
