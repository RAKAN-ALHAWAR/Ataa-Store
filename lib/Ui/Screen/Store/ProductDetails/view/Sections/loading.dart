import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Cover
            const ShimmerAnimationX(height: 200),
            const SizedBox(height: 12),

            /// Images Bar
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  const ShimmerAnimationX(
                    height: 72,
                    width: 72,
                    margin: EdgeInsetsDirectional.only(end: 10),
                  ),
              ],
            ),
            const SizedBox(height: 16),

            /// Name & Ratting
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerAnimationX(height: 26, width: 230),
                ShimmerAnimationX(height: 26, width: 70),
              ],
            ),
            const SizedBox(height: 16),

            /// Price & Stars
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerAnimationX(height: 26, width: 70),
                ShimmerAnimationX(height: 26, width: 170),
              ],
            ),
            const SizedBox(height: 14),

            /// Title of Available colors
            const ShimmerAnimationX(height: 20, width: 120),
            const SizedBox(height: 14),

            /// Available colors
            Row(
              children: [
                for (int i = 0; i < 4; i++)
                  ShimmerAnimationX(
                    height: 47,
                    width: 47,
                    borderRadius: BorderRadius.circular(100),
                    margin: const EdgeInsetsDirectional.only(end: 10),
                  ),
              ],
            ),
            const SizedBox(height: 14),

            /// Title of Available Sizes
            const ShimmerAnimationX(height: 20, width: 120),
            const SizedBox(height: 14),

            /// Available Sizes
            const ShimmerAnimationX(height: StyleX.inputHeight),
            const SizedBox(height: 14),

            /// Title of Product information
            const ShimmerAnimationX(height: 20, width: 120),
            const SizedBox(height: 14),

            /// Product information
            const ShimmerAnimationX(height: 200),
          ],
        ),
      ),

      /// Nav Bar
      bottomNavigationBar: ContainerX(
        isShadow: true,
        radius: StyleX.radiusMd,
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: 20,
        ),

        /// Buttons
        child: Row(
          children: [
            Expanded(child: ShimmerAnimationShapeX.button()),
            const SizedBox(width: 10),
            Expanded(child: ShimmerAnimationShapeX.button()),
          ],
        ),
      ),
    );
  }
}
