import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';

class LoadingSectionX extends StatelessWidget {
  const LoadingSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            /// Cover
            Container(
              color: Theme.of(context).cardColor,
              width: double.maxFinite,
              height: 300,
            ),

            /// App Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBarTransparent(
                title: "Campaign Details",
                actions: [
                  CartIconButtonsX(
                    isAnimation: false,
                  )
                ],
              ),
            ),

            /// for create Rounded Background Design
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 22,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadiusDirectional.vertical(
                    top: Radius.circular(
                      StyleX.radiusMd,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        /// Main Content
        const Expanded(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: StyleX.hPaddingApp,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// Zakat Marker
                        ShimmerAnimationX(
                          width: 150,
                          height: StyleX.buttonHeightSm,
                        ),

                        /// Share Button
                        ShimmerAnimationX(
                          width: 100,
                          height: StyleX.buttonHeightSm,
                        )
                      ],
                    ),
                    SizedBox(height: 10),

                    /// Title
                    ShimmerAnimationX(
                      width: 230,
                      height: 40,
                    ),
                    SizedBox(height: 16),

                    /// Statistics
                    Row(
                      children: [
                        Flexible(
                          child: ShimmerAnimationX(
                            height: 102,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: ShimmerAnimationX(
                            height: 102,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    /// Donations progress bar
                    ShimmerAnimationX(
                      height: 10,
                    ),
                    SizedBox(height: 12),

                    /// Description Title
                    ShimmerAnimationX(
                      height: 20,
                      width: 150,
                    ),
                    SizedBox(height: 6),

                    /// Description
                    ShimmerAnimationX(
                      height: 200,
                    ),

                    /// NavBar Height
                    SizedBox(height: 120),
                  ],
                ),
              ),

              /// NavBar
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ContainerX(
                  isShadow: true,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(StyleX.radiusMd),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: StyleX.hPaddingApp,
                    vertical: 25,
                  ),
                  child: Row(
                    children: [
                      /// Donate Button
                      Flexible(
                        child: ShimmerAnimationX(
                          height: StyleX.buttonHeight,
                        ),
                      ),
                      SizedBox(width: 8),

                      /// Add To Cart Button
                      Flexible(
                        child: ShimmerAnimationX(
                          height: StyleX.buttonHeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
