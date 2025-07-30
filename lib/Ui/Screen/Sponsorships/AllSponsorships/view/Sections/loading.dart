import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Texts
        const Padding(
          padding: EdgeInsets.only(
            right: StyleX.hPaddingApp,
            left: StyleX.hPaddingApp,
            top: StyleX.vPaddingApp,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              ShimmerAnimationX(height: 30, width: 200),
              SizedBox(height: 16),

              /// Subtitle
              ShimmerAnimationX(height: 80),
            ],
          ),
        ),

        /// Search Bar
        ShimmerAnimationShapeX.searchBar(),

        /// Cards
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
