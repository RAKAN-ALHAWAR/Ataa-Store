import 'package:flutter/material.dart';
import '../../../../../Config/config.dart';
import '../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
        vertical: StyleX.vPaddingApp,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 8; i++)
            const ShimmerAnimationX(
              height: 160,
              margin: EdgeInsets.only(bottom: 10),
            ),
        ],
      ),
    );
  }
}
