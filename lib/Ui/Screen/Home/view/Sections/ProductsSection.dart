import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../Animation/animation.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class ProductsSectionX extends GetView<HomeController> {
  const ProductsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.getProducts(),
      builder: (context, snapshot) {

        /// If the data is still loading, a flash is displayed in the same shape as the item expected to appear
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ScrollCardsHorizontallyX(
            height: StyleX.productCardHeight,
            title: "The Store",
            icon: Icons.shopping_bag_rounded,
            onShowMore: controller.onShopMore,
            cards: [
              for (int i = 0; i < 3; i++)
                 const ShimmerAnimationX(
                  height: StyleX.productCardHeight,
                  width: StyleX.productCardWidth,
                  margin: EdgeInsetsDirectional.only(end: 14),
                )
            ],
          );
        }

        /// If there is an error in this section or it is empty, the section does not appear
        if (snapshot.hasError || controller.products.isEmpty) {
          return const SizedBox();
        }

        /// When the data has finished loading properly, it is displayed
        return ScrollCardsHorizontallyX(
          height: StyleX.productCardHeight,
          title: "The Store",
          icon: Icons.shopping_bag_rounded,
          onShowMore: controller.onShopMore,
          cards: [
            ...controller.products.map(
              (product) => ProductCardX(
                onTap: controller.onTapProduct,
                onAddToCart: controller.onProductAddToCart,
                product: product,
              ).fadeAnimation300,
            ),
          ],
        );
      },
    );
  }
}
