import 'package:ataa/UI/Animation/animation.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class AppBarWithCoverSectionX extends GetView<DonationDetailsController> {
  const AppBarWithCoverSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Cover Image & Video
        SizedBox(
          height: 300,
          width: double.maxFinite,
          child: PageView.builder(
            controller: controller.imagesController,
            itemCount: controller.getNumCover(),
            itemBuilder: (_, index) {
              if ((controller.getNumCover() == 1 &&
                  index == 0 &&
                  controller.donation.donationDetails.imageUrl != null) ||
                  (controller.getNumCover() == 2 && index == 0)) {
                return Container(
                  color: Theme.of(context).cardColor,
                  width: double.maxFinite,
                  height: 300,
                  child: ImageNetworkX(
                    imageUrl: controller.donation.donationDetails.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                );
              } else if (!controller.hasErrorVideo.value ||
                  (controller.getNumCover() == 1 &&
                      index == 0 &&
                      controller.donation.donationDetails.videoUrl != null) ||
                  (controller.getNumCover() == 2 && index == 1)) {
                return Obx(
                      () {
                    if (controller.isInitYoutubeController.isTrue) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            if (controller.imagesController.page?.round() != 0) {
                              controller.imagesController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          } else if (details.velocity.pixelsPerSecond.dx < 0) {
                            if (controller.imagesController.page?.round() !=
                                controller.getNumCover() - 1) {
                              controller.imagesController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: YoutubePlayer(
                            controller: controller.youtubeController,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.red,
                          ),
                        ),
                      );
                    } else if (controller.isInitChewieController.isFalse ||
                        !controller
                            .videoPlayerController.value.value.isInitialized) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Container(
                        color: Colors.black,
                        child: Chewie(
                          controller: controller.chewieController,
                        ),
                      );
                    }
                  },
                );
              } else {
                return SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: SvgPicture.asset(
                      context.isDarkMode ? ImageX.logoWhite : ImageX.logo,
                    ),
                  ),
                );
              }
            },
          ),
        ).fadeAnimation200,
        if(controller.donation.donationBasic.isDone)
          Positioned.fill(
            child: ImageNetworkX(
              height: 300,
              width: double.maxFinite,
              imageUrl: controller.app.generalSettings.projectCompletionImageUrl ?? ImageX.doneDonation,
              isFile: controller.app.generalSettings.projectCompletionImageUrl == null,
              empty: const SizedBox(),
              fit: BoxFit.contain,
            ).paddingAll(5),
          ),

        /// AppBar
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AppBarTransparent(
            title: "Donation Details",
            actions: [
              CartIconButtonsX(
                isAnimation: false,
              )
            ],
          ),
        ),

        /// Image & Video Pointer
        if (controller.getNumCover() != 1)
          Positioned(
            bottom: 38,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: controller.imagesController,
                  count: controller.getNumCover(),
                  onDotClicked: (index) {
                    controller.imagesController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  effect: const ExpandingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white70,
                    expansionFactor: 4,
                  ),
                ).fadeAnimation200,
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
    );
  }
}
