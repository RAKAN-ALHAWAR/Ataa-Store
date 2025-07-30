import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return const ShimmerAnimationX(
      height: 112,
      margin: EdgeInsets.only(bottom: 16),
    );
  }
}
