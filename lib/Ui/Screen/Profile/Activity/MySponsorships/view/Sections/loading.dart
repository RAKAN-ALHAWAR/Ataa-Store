import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Config/config.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
        vertical: StyleX.vPaddingApp,
      ),

      /// Cards
      child: Column(
        children: [
          for (int i = 0; i < 10; i++)
            const ShimmerAnimationX(
              height: StyleX.accordionHeight,
              margin: EdgeInsets.only(bottom: 10),
            )
        ],
      ),
    );
  }
}
