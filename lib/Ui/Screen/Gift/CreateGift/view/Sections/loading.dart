import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: StyleX.vPaddingApp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Type of gift Title
          const ShimmerAnimationX(height: 28, width: 120,margin: EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),),
          const SizedBox(height: 10),

          /// Type of gifts
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
            child: Row(
              children: [
                for (int i = 0; i < 5; i++)
                  const ShimmerAnimationX(
                    width: 110,
                    height: 140,
                    margin: EdgeInsetsDirectional.only(end: 8),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          /// Gift Gender Title
          const ShimmerAnimationX(height: 28, width: 100,margin: EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp)),
          const SizedBox(height: 10),

          /// Gift Genders
          const Row(
            children: [
              Flexible(
                child: ShimmerAnimationX(
                  height: StyleX.inputHeight,
                ),
              ),
              SizedBox(width: 8),
              Flexible(
                child: ShimmerAnimationX(
                  height: StyleX.inputHeight,
                ),
              ),
            ],
          ).marginSymmetric(horizontal: StyleX.hPaddingApp),

          const SizedBox(height: 20),

          /// Gift Card Title
          const ShimmerAnimationX(height: 28, width: 120,margin: EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp)),
          const SizedBox(height: 16),
          /// Gift Card
          const ShimmerAnimationX(height: 500, margin: EdgeInsets.symmetric(horizontal: 40)),
          const SizedBox(height: 20),

          /// Color Title
          const ShimmerAnimationX(height: 30, width: 170,margin: EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp)),
          const SizedBox(height: 10),
            /// Colors
            Row(
              children: [
                for (int i = 0; i < 7; i++)
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const ShimmerAnimationX(
                      height: 43,
                      width: 43,
                    ),
                  ),
                ),
              ],
            ).marginSymmetric(horizontal: StyleX.hPaddingApp),
          const SizedBox(height: 20),

          /// Org Title
          const ShimmerAnimationX(height: 28, width: 120,margin: EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),),
          const SizedBox(height: 10),

          /// org
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
            child: Row(
              children: [
                for (int i = 0; i < 5; i++)
                  const ShimmerAnimationX(
                    width: 150,
                    height: 140,
                    margin: EdgeInsetsDirectional.only(end: 8),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
