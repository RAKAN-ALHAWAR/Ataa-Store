import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
              right: StyleX.hPaddingApp,
              left: StyleX.hPaddingApp,
              top: StyleX.vPaddingApp,
              bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              ShimmerAnimationX(height: 30, width: 200),
              SizedBox(
                height: 16,
              ),

              /// Description
              ShimmerAnimationX(height: 80),
            ],
          ),
        ),

        /// Button
        ShimmerAnimationShapeX.button()
            .marginSymmetric(horizontal: StyleX.hPaddingApp, vertical: 5),

        /// Search Bar
        ShimmerAnimationShapeX.searchBar(),

        /// Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 30,
              left: StyleX.hPaddingApp,
              right: StyleX.hPaddingApp,
              top: 10,
            ),
            child: Column(
              children: [
                for (int i = 0; i < 5; i++)
                  ShimmerAnimationShapeX.donationCard()
              ],
            ),
          ),
        ),
      ],
    );
  }
}
