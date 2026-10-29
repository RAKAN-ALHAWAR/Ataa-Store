import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Ui/Widget/widget.dart';
import '../controller/Controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: StyleX.hPaddingApp,
                vertical: 10,
              ),
              child: InkResponse(
                onTap: controller.onSkip,
                child: const TextX('Skip'),
              ),
            ).fadeAnimation200,

            /// Logos
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    ImageX.sponsorLogo,
                    height: 80,
                  ).fadeAnimation300,
                  const SizedBox(height: 25),
                  SvgPicture.asset(
                    ImageX.logo,
                    height: 40,
                  ).fadeAnimation300,
                ],
              ),
            ),

            /// Card
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: StyleX.hPaddingApp,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: ColorX.primary,
                borderRadius: const BorderRadiusDirectional.vertical(
                  top: Radius.circular(StyleX.radiusLg),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  /// Text
                  SizedBox(
                    height: 140,
                    child: PageView.builder(
                      controller: controller.cardController.value,
                      itemCount: controller.cardsTitle.length,
                      onPageChanged: (page) {
                        controller.cardIndex.value = page;
                      },
                      itemBuilder: (_, index) {
                        return Column(
                          children: [
                            /// Title
                            TextX(
                              controller.cardsTitle[index],
                              color: Colors.white,
                              style:
                                  TextStyleX.headerSmall.copyWith(fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),

                            /// Subtitle
                            Expanded(
                              child: TextX(
                                controller.cardsSubtitle[index],
                                color: Colors.white,
                                style: TextStyleX.titleMedium
                                    .copyWith(fontSize: 16),
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      },
                    ).fadeAnimation400,
                  ),
                  const SizedBox(height: 10),

                  /// Points to identify any card
                  SmoothPageIndicator(
                    controller: controller.cardController.value,
                    count: controller.cardsTitle.length,
                    effect: ExpandingDotsEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: Colors.white,
                      dotColor: ColorX.primary.shade300,
                      expansionFactor: 3,
                    ),
                  ).fadeAnimation500,
                  const SizedBox(height: 20),

                  Obx(
                    () {
                      /// Language Button
                      if (controller.cardIndex.value == 0) {
                        return Column(
                          children: [
                            ButtonX(
                              onTap: () => controller.changeLanguage('ar'),
                              text: 'Arabic',
                              colorButton: Colors.white,
                              colorText: ColorX.primary,
                              borderColor: Colors.transparent,
                            ),
                            ButtonX(
                              onTap: () => controller.changeLanguage('en'),
                              text: 'English',
                              colorButton: Colors.white,
                              colorText: ColorX.primary,
                              borderColor: Colors.transparent,
                            ),
                          ],
                        );
                      } else if (controller.cardIndex.value == 1) {
                        return Column(
                          children: [
                            ButtonX(
                              onTap: controller.onNext,
                              text: 'Next',
                              colorButton: Colors.white,
                              colorText: ColorX.primary,
                              borderColor: Colors.transparent,
                            ),
                            ButtonX(
                              onTap: controller.onSkip,
                              text: 'Skip',
                              colorButton: ColorX.primary,
                              colorText: Colors.white,
                              borderColor: Colors.white,
                            ),
                          ],
                        );
                      } else {
                        /// Skip Button
                        return ButtonX(
                          onTap: controller.onSkip,
                          text: 'Start Now',
                          colorButton: Colors.white,
                          colorText: ColorX.primary,
                          borderColor: Colors.transparent,
                        );
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
