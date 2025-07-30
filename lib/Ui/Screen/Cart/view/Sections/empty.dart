import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class EmptySectionX extends GetView<CartController> {
  const EmptySectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Empty Image
            ColorFiltered(
              /// Change the color of the image according to the theme
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                ImageX.basketEmpty,
                height: 100,
              ).fadeAnimation200,
            ),
            const SizedBox(height: 20),

            /// Message
            TextX(
              "You don't have any items added to your cart",
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              color: Theme.of(context).colorScheme.secondary,
            ).fadeAnimation300,
            const SizedBox(height: 15),

            /// Button
            ButtonX(
              onTap: () {
                controller.root.goToHome();
                Get.back();
              },
              width: 200,
              text: "Back to Home",
            ).fadeAnimation300
          ],
        ),
      ),
    );
  }
}
