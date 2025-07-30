import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalServiceX {
  static const appId = '4a563053-8865-4b3b-83f6-9535842891bb';

  static Future<void> init() async {
  // Enable verbose logging for debugging (remove in production)
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // Initialize with your OneSignal App ID
  OneSignal.initialize(appId);
  // Use this method to prompt for push notifications.
  // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
  OneSignal.Notifications.requestPermission(false);
  }
}
