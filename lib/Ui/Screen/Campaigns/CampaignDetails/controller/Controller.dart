import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Other/donateOnBehalfOfFamilyController.dart';
import '../../../../../Core/Extension/convert/convert.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Enum/linkable_type_status.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/ScreenSheet/Other/Share/shareSheet.dart';
import '../../../../ScreenSheet/Pay/PayDonation/payDonationSheet.dart';

class CampaignDetailsController extends GetxController {
  //============================================================================
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
  late CampaignX campaign;
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
      /// Get campaign details from database
      campaign = await DatabaseX.getCampaignDetails(code: code.toString());

      /// Init Video Player
      if (campaign.donation.donationDetails.videoUrl != null &&
          campaign.donation.donationDetails.videoUrl!.isURL) {
        final url = campaign.donation.donationDetails.videoUrl!;
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

  /// Extract YouTube ID from URL manually + check if it's YouTube
  bool isYoutubeUrl(String url) {
    final videoId = getYoutubeIdFromUrl(url);
    return videoId != null;
  }

  String? getYoutubeIdFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // Support common YouTube formats
    if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      }
      return uri.queryParameters['v'];
    }
    return null;
  }

  openShare() async {
    await shareSheet(
      id: campaign.id,
      code: campaign.code,
      type: LinkableTypeStatusX.campaign,
    );
  }

  /// Initialize YouTube Player (الإصدار الجديد 2025)
  initYoutubePlayer(String url) {
    try {
      final videoId = getYoutubeIdFromUrl(url)!;

      // أولاً: إنشاء الـ Controller مع الـ params
      youtubeController = YoutubePlayerController(
        params: const YoutubePlayerParams(
          mute: false,
          loop: true,
          showFullscreenButton: true,
          // disableDragSeek: true مش موجود مباشرة، بس تقدر تخفي الـ controls كلها لو عايز
          // أو استخدم enableUserInteraction: false لو موجود في إصدارك
          showControls: true, // غيره لـ false لو عايز تخفي الـ controls تماماً
        ),
      );

      // ثانياً: تحميل الفيديو (cue = يجهز بدون auto play، load = يشغل تلقائي)
      youtubeController.cueVideoById(
        videoId: videoId,
      ); // أو loadVideoById لو عايز auto play
    } catch (_) {
      hasErrorVideo.value = true;
    }
  }

  onPayDonation() async =>
      await payDonationSheet(campaign.donation, campaign: campaign);

  onDonationAddToCart() async => await payDonationSheet(
    campaign.donation,
    campaign: campaign,
    onlyAddToCart: true,
  );

  int getNumCover() {
    return campaign.donation.donationDetails.imageUrl != null &&
            campaign.donation.donationDetails.videoUrl != null
        ? 2
        : 1;
  }

  /// Initialize Video Player (عادي، بدون تغيير)
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

  showAllCampaigns() {
    if (Get.previousRoute == RouteNameX.allCampaigns) {
      Get.back();
    } else {
      Get.toNamed(RouteNameX.allCampaigns);
    }
  }

  //============================================================================
  // Initialization
  @override
  void onClose() {
    try {
      if (campaign.donation.donationDetails.videoUrl != null &&
          campaign.donation.donationDetails.videoUrl!.isURL) {
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
