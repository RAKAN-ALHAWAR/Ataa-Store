import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                for (int i = 0; i < 8; i++)
                  ShimmerAnimationShapeX.productCard()
              ],
            ),
          ),
        ),
      ],
    );
  }
}