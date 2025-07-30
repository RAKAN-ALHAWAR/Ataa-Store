import 'package:flutter/material.dart';
import '../../../../../Animation/animation.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        bottom: 30,
        top: 10,
      ),
      child: Column(
        children: [
          for (int i = 0; i < 5; i++)
            ShimmerAnimationShapeX.donationCard()
        ],
      ),
    );
  }
}
