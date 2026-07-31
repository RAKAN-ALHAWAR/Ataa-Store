import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/Translation/translation.dart';
import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../../../Data/data.dart';
import '../../../../UI/Widget/widget.dart';

class OnboardingController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxInt cardIndex = 0.obs;
  final List<String> cardsTitle = OnboardingX.titles;
  final List<String> cardsSubtitle = OnboardingX.subtitles;
  final Rx<PageController> cardController = PageController().obs;

  //============================================================================
  // Functions

  onNext() {
    /// If the cards run out, the skip is triggered
    if (cardIndex.value == cardsTitle.length - 1) {
      onSkip();
    } else {
      cardController.value.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  changeLanguage(String val) async {
    try {
      /// Switch language
      await TranslationX.changeLocale(val);

      /// Save the language to internal storage
      LocalDataX.settings.language = val;
      LocalDataX.put(LocalKeyX.settings, LocalDataX.settings.toJson());
      onNext();
    } catch (e) {
      ToastX.error(message: e.toString());
    }
  }

  onSkip() {
    String route = app.generalSettings.accountCreationMethodIsTraditionalForm
        ? RouteNameX.login
        : RouteNameX.continueToAccount;

    /// Save the path when you log in, so it doesn't appear again
    LocalDataX.put(LocalKeyX.route, route);
    Get.offAllNamed(route);
  }
}
