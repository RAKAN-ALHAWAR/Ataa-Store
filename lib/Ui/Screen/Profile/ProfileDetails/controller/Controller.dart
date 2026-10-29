import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';

class ProfileDetailsController extends GetxController {
 //============================================================================
 // Injection of required controls

  final AppControllerX app = Get.find();

 //============================================================================
 // Variables

  /// Installed app version and build number, e.g. `1.0.4 (15)`; empty until loaded.
  final RxString appVersion = ''.obs;

 //============================================================================
 // Lifecycle

  @override
  void onInit() {
    super.onInit();
    _loadAppVersion();
  }

 //============================================================================
 // Functions

  onEditProfile() => Get.toNamed(RouteNameX.editProfile);
  onStatistics() => Get.toNamed(RouteNameX.statistics);
  onActivity() => Get.toNamed(RouteNameX.activity);
  onNotifications() => Get.toNamed(RouteNameX.notifications);
  onContact() => Get.toNamed(RouteNameX.contactUs);
  onInfo() => Get.toNamed(RouteNameX.about);
  onOurBank() => Get.toNamed(RouteNameX.ourBank);
  onTermsConditions() => Get.toNamed(RouteNameX.termsConditions);
  onPrivacyPolicy() => Get.toNamed(RouteNameX.privacyPolicy);
  onSettings() => Get.toNamed(RouteNameX.settings);

  Future<void> _loadAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      appVersion.value = '${info.version} (${info.buildNumber})';
    } catch (_) {
      // The version line is informational only: when it cannot be read it stays hidden.
    }
  }

}
