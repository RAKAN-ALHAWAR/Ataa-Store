import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../GeneralState/error.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/imagesBar.dart';
import 'Sections/loading.dart';
import 'Sections/navbar.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBarX(
        title: "Product Details",
        actions: [CartIconButtonsX()],
      ),
      body: FutureBuilder(
        future: controller.getData(),
        builder: (context, snapshot) {
          /// Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSectionX();
          }

          /// Error State
          if (snapshot.hasError) {
            return ErrorView(
              error: snapshot.error.toString(),
            );
          }

          /// Main Content
          return Scaffold(
            body: Obx(
              () => AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: StyleX.vPaddingApp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Cover Image
                      Obx(
                        () => ContainerX(
                          isBorder: true,
                          padding: EdgeInsets.zero,
                          radius: StyleX.radiusMd,
                          margin: const EdgeInsets.symmetric(
                            horizontal: StyleX.hPaddingApp,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(StyleX.radiusMd),
                            child: ImageNetworkX(
                              imageUrl: controller.product.imageUrl[
                                  controller.imageSelectedIndex.value],
                              height: 200,
                              width: double.maxFinite,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ).fadeAnimation200,
                      ),
                      const SizedBox(height: 12),

                      /// Product images
                      /// Show images bar if has more 1
                      if (controller.product.imageUrl.length > 1)
                        const ImagesBarSection()
                            .marginOnly(bottom: 16)
                            .fadeAnimation300,

                      /// Product Details
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: StyleX.hPaddingApp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Rating
                            Row(
                              children: [
                                /// Rating Stars
                                RatingBar.builder(
                                  initialRating:
                                      (controller.product.rating * 2).round() /
                                          2,
                                  allowHalfRating: true,
                                  itemSize: 26,
                                  unratedColor: context.isDarkMode
                                      ? ColorX.grey.shade600
                                      : ColorX.grey.shade200,
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (_) {},
                                  ignoreGestures: true,
                                ),
                                const SizedBox(width: 12),

                                /// Rating rate
                                ContainerX(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 10,
                                  ),
                                  color: context.isDarkMode
                                      ? ColorX.primary.shade100
                                      : ColorX.primary.shade50,
                                  child: TextX(
                                    controller.product.rating
                                        .toStringAsFixed(1),
                                    style: TextStyleX.supTitleLarge,
                                    fontWeight: FontWeight.w500,
                                    color: ColorX.primary,
                                  ),
                                ),
                              ],
                            ).fadeAnimation300,
                            const SizedBox(height: 12),

                            /// Product Name
                            TextX(
                              controller.product.name,
                              style: TextStyleX.titleLarge,
                              fontWeight: FontWeight.w700,
                            ).fadeAnimation300,
                            const SizedBox(height: 12),

                            /// Price
                            Row(
                              children: [
                                TextX(
                                  FunctionX.formatLargeNumber(
                                    controller.product.price,
                                  ),
                                  style: TextStyleX.titleLarge,
                                  fontWeight: FontWeight.w700,
                                ),
                                const SizedBox(width: 6),
                                const Icon(
                                  IconX.sar,
                                  size: 16,
                                ),
                              ],
                            ).fadeAnimation400,
                          ],
                        ),
                      ),

                      /// Available colors
                      if (controller.product.colors.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 14),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: StyleX.hPaddingApp,
                              ),
                              child: LabelInputX("Available colors"),
                            ),
                            const SizedBox(height: 6),
                            ColorBarSelectorX(
                              key: Key(controller.product.id),
                              colors: controller.product.colors,
                              colorSelectedIndex:
                                  controller.colorSelectedIndex.value,
                              onChangeColor: controller.onChangeColor,
                            ),
                          ],
                        ).fadeAnimation400,

                      /// Available Sizes
                      if (controller.product.sizes.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: StyleX.hPaddingApp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              const LabelInputX("Sizes"),
                              DropdownX(
                                color: context.isDarkMode
                                    ? null
                                    : Theme.of(context).cardColor,
                                disable: controller.product.sizes.length == 1,
                                value: controller.sizeSelected,
                                list: controller.product.sizes,
                                onChanged: controller.onChangeSize,
                                hint: "-- Choose --",
                              )
                            ],
                          ),
                        ).fadeAnimation400,

                      /// Product information
                      Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: StyleX.hPaddingApp,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            TextX(
                              "Product information",
                              style: TextStyleX.titleLarge,
                            ),
                            const SizedBox(height: 6),
                            TextX(
                              controller.product.description,
                              style: TextStyleX.titleSmall,
                            ),
                          ],
                        ),
                      ).fadeAnimation500,
                    ],
                  ),
                ),
              ),
            ),

            /// Buttons
            bottomNavigationBar: const NavBarSectionX().fadeAnimation500,
          );
        },
      ),
    );
  }
}
