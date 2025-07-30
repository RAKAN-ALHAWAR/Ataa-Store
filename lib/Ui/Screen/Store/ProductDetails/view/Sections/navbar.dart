import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class NavBarSectionX extends GetView<ProductDetailsController> {
  const NavBarSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      maxHeight: 115,
      isShadow: true,
      radius: StyleX.radiusMd,
      padding: const EdgeInsets.only(
        right: StyleX.hPaddingApp,
        left: StyleX.hPaddingApp,
        top: 20,
        bottom: 30
      ),
      child: Obx(
        () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberFieldX(
                      key: Key(controller.productNum.value.toString()),
                      onChanged: controller.onChangeProductNum,
                      value: controller.productNum.value,
                      min: 1,
                      max: controller.product.numOfStore.toDouble(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: ButtonStateX(
                  state: controller.buttonState.value,
                  onTap: controller.onAddToCart,
                  iconData: Icons.shopping_cart_rounded,
                  text: "Add to cart",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
