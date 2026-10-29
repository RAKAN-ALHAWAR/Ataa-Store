import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../GeneralState/empty.dart';
import '../../../../GeneralState/error.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/loading.dart';

class StoreView extends GetView<StoreController> {
  const StoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "The Store",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: FutureBuilder(
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

            /// Empty State
            if (controller.products.isEmpty) {
              return const EmptyView(
                message: "There are no products currently",
              );
            }

            /// Main Content
            return Column(
              children: [
                SearchBarX(
                  search: controller.search,
                  onTapFilter: controller.onFilter,
                  onSearching: controller.onSearching,
                  filterIcon: IconX.sortDescending,
                ).fadeAnimation200,
                Obx(
                  () {
                    /// if Empty Product on Search
                    if (controller.productsResult.isEmpty) {
                      return const EmptyView(
                        message:
                            "There are no search results.\nTry searching for something else",
                      );
                    } else {
                      /// Products Result
                      return Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 30,
                            left: StyleX.hPaddingApp,
                            right: StyleX.hPaddingApp,
                          ),
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              /// Cards
                              ...controller.productsResult.map(
                                (product) => ProductCardX(
                                  margin: EdgeInsets.zero,
                                  onAddToCart: controller.onAddToCart,
                                  product: product,
                                  onTap: controller.onTapProduct,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      StyleX.hPaddingApp -
                                      5,
                                ).fadeAnimation300,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
