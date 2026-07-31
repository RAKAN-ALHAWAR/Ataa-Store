import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart'; // الإمبورت الجديد
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Other/donateOnBehalfOfFamilyController.dart';
import '../../../../../Core/Extension/convert/convert.dart';
import '../../../../../Data/Enum/linkable_type_status.dart';
import '../../../../../Data/Model/Deduction/deduction.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/ScreenSheet/Other/Share/shareSheet.dart';
import '../../../../ScreenSheet/Pay/SubscriptionDeduction/subscriptionDeductionSheet.dart';

class DeductionDetailsController extends GetxController {
  //============================================================================
  // Injection of required controls

  DonateOnBehalfOfFamilyController donateOnBehalfOfFamilyController = Get.put(
    DonateOnBehalfOfFamilyController(),
    tag: Get.arguments.toString(),
  );

  //============================================================================
  // Variables

  final int code = Get.arguments
      .toString()
      .toIntX; // The code is sent from the previous page
  late DeductionX deduction;
  late RxBool isSubscribed;

  Rx<ButtonStateEX> subscriptionButtonState = ButtonStateEX.normal.obs;
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
      deduction = await DatabaseX.getDeductionDetails(code: code);
      isSubscribed = deduction.isSubscribed.obs;

      /// Init Video Player
      if (deduction.videoUrl.isNotEmpty && deduction.videoUrl.isURL) {
        final url = deduction.videoUrl;
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

  Future<void> onSubscriptionDonation() async {
    (dynamic isOpenPayment, dynamic deductionAmount)? subscription =
        await subscriptionDeductionSheetX(deduction);
    if (subscription != null && subscription.$1 == true) {
      var isDone = await Get.toNamed(
        RouteNameX.deductionPayment,
        arguments: [
          deduction,
          deduction.isOpenPrice ? subscription.$2 : deduction.initialPrice,
        ],
      );
      if (isDone == true) {
        isSubscribed.value = true;
      }
    }
  }

  openShare() async {
    await shareSheet(
      id: deduction.id,
      code: deduction.code,
      type: LinkableTypeStatusX.deduction,
    );
  }

  int getNumCover() {
    return deduction.imageUrl.isNotEmpty && deduction.videoUrl.isNotEmpty
        ? 2
        : 1;
  }

  /// Extract YouTube ID + check if it's YouTube URL
  bool isYoutubeUrl(String url) {
    return getYoutubeIdFromUrl(url) != null;
  }

  String? getYoutubeIdFromUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    // دعم الروابط الشائعة: youtube.com/watch?v=ID و youtu.be/ID
    if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
      }
      return uri.queryParameters['v'];
    }
    return null;
  }

  /// Initialize YouTube Player (النسخة الجديدة youtube_player_iframe)
  initYoutubePlayer(String url) {
    try {
      final videoId = getYoutubeIdFromUrl(url)!;

      youtubeController = YoutubePlayerController(
        params: const YoutubePlayerParams(
          mute: false,
          loop: true,
          showFullscreenButton: true,
          showControls:
              false, // يخفي الـ progress bar والسحب (بديل disableDragSeek)
          // لو عايز تشغل تلقائي: استخدم loadVideoById بدل cue
        ),
      );

      // يجهز الفيديو بدون تشغيل تلقائي
      youtubeController.cueVideoById(videoId: videoId);
      // لو عايز auto play: youtubeController.loadVideoById(videoId: videoId);
    } catch (_) {
      hasErrorVideo.value = true;
    }
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

  closePage() {
    try {
      Get.back(result: isSubscribed.value);
    } catch (_) {}
  }

  closePageResult() {
    try {
      // check if isSubscribed initialized
      bool x = isSubscribed.value;
      return x;
    } catch (_) {
      return null;
    }
  }

  //============================================================================
  // Initialization

  @override
  void onClose() {
    try {
      if (deduction.videoUrl.isNotEmpty && deduction.videoUrl.isURL) {
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
