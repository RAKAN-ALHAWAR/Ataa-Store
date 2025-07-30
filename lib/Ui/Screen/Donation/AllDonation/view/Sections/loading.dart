import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Search Bar
        ShimmerAnimationShapeX.searchBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              bottom: 30,
              left: StyleX.hPaddingApp,
              right: StyleX.hPaddingApp,
              top: 10,
            ),
            /// Cards
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
