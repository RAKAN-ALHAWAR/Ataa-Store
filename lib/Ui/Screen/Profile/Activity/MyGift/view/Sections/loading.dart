import 'package:flutter/material.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Cards
        for (int i = 0; i < 16; i++)
          const ShimmerAnimationX(
            height: StyleX.accordionHeight,
            margin: EdgeInsets.only(bottom: 10),
          )
      ],
    );
  }
}
