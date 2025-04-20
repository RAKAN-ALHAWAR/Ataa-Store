import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Data/data.dart';
import '../../../Screen/Store/ProductDetails/controller/Controller.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Display simplified product details and input fields to add the product
/// to the cart
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

productAddToCartSheetX(ProductX product) async {
  //============================================================================
  // Injection of required controls

  final ProductDetailsController controller = Get.put(
    ProductDetailsController(),
    tag: product.id,
  );
  controller.sheetInit(product);

  //============================================================================
  // Content

  return bottomSheetX(
    title: "The Product",
    child: Obx(
      () {
        /// Main Content
        return AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              /// Product Details
              Row(
                children: [
                  /// Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(StyleX.radius),
                    child: ImageNetworkX(
                      height: 50,
                      width: 50,
                      imageUrl: controller.product
                          .imageUrl[controller.imageSelectedIndex.value],
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// Product Name
                  Expanded(
                    child: TextX(
                      controller.product.name,
                      style: TextStyleX.titleLarge,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 10),

                  /// Price
                  Row(
                    children: [
                      TextX(
                        "${controller.product.price}",
                        color: Get.theme.primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                      const SizedBox(width: 6),
                      Icon(IconX.sar,size: 16,color: ColorX.primary,),
                    ],
                  ),
                ],
              ).fadeAnimation200,

              /// Available colors
              if (controller.product.colors.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const LabelInputX("Available colors").fadeAnimation200,
                    const SizedBox(height: 6),
                    ColorBarSelectorX(
                      isPadding: false,
                      key: Key(controller.product.id),
                      colors: controller.product.colors,
                      colorSelectedIndex: controller.colorSelectedIndex.value,
                      onChangeColor: controller.onChangeColor,
                    ).fadeAnimation200,
                  ],
                ),

              /// Available Size
              if (controller.product.sizes.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const LabelInputX("Sizes").fadeAnimation300,
                    DropdownX(
                      disable: controller.product.sizes.length == 1,
                      value: controller.sizeSelected,
                      list: controller.product.sizes,
                      onChanged: controller.onChangeSize,
                      hint: "-- Choose --",
                    ).fadeAnimation300
                  ],
                ),
              const SizedBox(height: 5),

              /// Number of selected product
              NumberFieldX(
                onChanged: controller.onChangeProductNum,
                value: controller.productNum.value,
                max: controller.product.numOfStore.toDouble(),
                min: 1,
              ).fadeAnimation400,
              const SizedBox(height: 5),

              /// Button Add to cart
              ButtonStateX(
                text: "Add to cart",
                state: controller.buttonState.value,
                onTap: controller.onAddToCart,
                iconData: Icons.shopping_cart_rounded,
              ).fadeAnimation500,
            ],
          ),
        );
      },
    ),
  );
}
