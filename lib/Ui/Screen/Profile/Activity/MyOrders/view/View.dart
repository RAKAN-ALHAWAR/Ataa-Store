import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../GeneralState/empty.dart';
import '../../../../../GeneralState/error.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "My Orders",
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
            if (controller.orders.isEmpty) {
              return const EmptyView(
                message: "There are no current orders",
              );
            }
        
            /// Main Content
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: StyleX.hPaddingApp,
                vertical: StyleX.vPaddingApp,
              ),
              itemCount: controller.orders.length,
              itemBuilder: (context, index) => OrderCardX(
                order: controller.orders[index],
                products: controller.products[index],
              ).fadeAnimationX(100 * (index + 1)),
            );
          },
        ),
      ),
    );
  }
}
