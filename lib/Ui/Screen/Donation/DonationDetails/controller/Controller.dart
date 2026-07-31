import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Data/Enum/linkable_type_status.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../Core/Controller/Other/donateOnBehalfOfFamilyController.dart';
import '../../../../../Data/Model/Donation/donation.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/ScreenSheet/Other/Share/shareSheet.dart';
import '../../../../ScreenSheet/Pay/PayDonation/payDonationSheet.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart'; // الإمبورت الجديد

class DonationDetailsController extends GetxController {
  //================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  DonateOnBehalfOfFamilyController donateOnBehalfOfFamilyController = Get.put(
    DonateOnBehalfOfFamilyController(),
    tag: Get.arguments.toString(),
  );

  //============================================================================
  // Variables

  final int code = Get.arguments
      .toString()
      .toIntX; // The Code is sent from the previous page
  late DonationX donation;

  Rx<ButtonStateEX> payDonationButtonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> addToCartButtonState = ButtonStateEX.normal.obs;

  PageController imagesController = PageController();

  late Rx<VideoPlayerController> videoPlayerController;
  late ChewieController chewieController;
  late YoutubePlayerController youtubeController;
  RxBool isInitChewieController = false.obs;
  RxBool hasErrorVideo = false.obs;

  //============================================================================
  // Functions

  getData() async {
    try {
      /// Get donation details from database
      donation = await DatabaseX.getDonationDetails(code: code);

      /// Init Video Player
      if (donation.donationDetails.videoUrl != null &&
          donation.donationDetails.videoUrl!.isURL) {
        final url = donation.donationDetails.videoUrl!;
        if (isYoutubeUrl(url)) {
          initYoutubePlayer(url);
        } else {
          initVideoPlayer(url);
        }
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Extract YouTube ID + check if it's YouTube URL
  bool isYoutubeUrl(String url) {
    return getYoutubeIdFromUrl(url) != null;
  }

  String? getYoutubeIdFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // دعم الروابط الشائعة: youtube.com/watch?v=ID و youtu.be/ID و shorts
    if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
      if (uri.host.contains('youtu.be') ||
          uri.pathSegments.contains('shorts')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      }
      return uri.queryParameters['v'];
    }
    return null;
  }

  openShare() async {
    await shareSheet(
      id: donation.id,
      code: donation.donationBasic.code,
      type: LinkableTypeStatusX.donation,
    );
  }

  /// Initialize YouTube Player (youtube_player_iframe الجديدة)
  initYoutubePlayer(String url) {
    try {
      final videoId = getYoutubeIdFromUrl(url)!;

      youtubeController = YoutubePlayerController(
        params: const YoutubePlayerParams(
          mute: false,
          loop: true,
          showFullscreenButton: true,
          showControls:
              false, // يخفي الـ progress bar والسحب (بديل disableDragSeek: true)
          // لو عايز controls مرئية: غيره لـ true
        ),
      );

      // يجهز الفيديو بدون تشغيل تلقائي (autoPlay: false)
      youtubeController.cueVideoById(videoId: videoId);
      // لو عايز auto play: استخدم loadVideoById(videoId: videoId)
    } catch (_) {
      hasErrorVideo.value = true;
    }
  }

  onPayDonation() async => await payDonationSheet(donation);
  onDonationAddToCart() async =>
      await payDonationSheet(donation, onlyAddToCart: true);

  int getNumCover() {
    return donation.donationDetails.imageUrl != null &&
            donation.donationDetails.videoUrl != null
        ? 2
        : 1;
  }

  /// Initialize Video Player (عادي - Chewie)
  initVideoPlayer(String url) async {
    try {
      isInitChewieController.value = false;
      videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(url),
      ).obs;
      await videoPlayerController.value.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController.value,
        autoPlay: false,
        looping: false,
        allowPlaybackSpeedChanging: false,
        hideControlsTimer: const Duration(seconds: 1),
        controlsSafeAreaMinimum: const EdgeInsets.only(bottom: 14),
      );
      isInitChewieController.value = true;
    } catch (_) {
      hasErrorVideo.value = true;
    }
  }

  //============================================================================
  // Initialization

  @override
  void onClose() {
    try {
      if (donation.donationDetails.videoUrl != null &&
          donation.donationDetails.videoUrl!.isURL) {
        if (isInitChewieController.value) {
          chewieController.dispose();
          videoPlayerController.value.dispose();
        }
        // للـ YouTube الجديد
        youtubeController.close();
      }
    } catch (_) {}
    super.onClose();
  }
}
