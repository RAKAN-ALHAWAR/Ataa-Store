part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage everything related to the quick navigation buttons outside the application
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class QuickActionX {
  static QuickActions quickActions = const QuickActions();

  /// Quick Action Items
  static List<ShortcutItem> shortcuts = [
    ShortcutItem(
      type: 'quickDonation',
      localizedTitle: 'Quick Donation'.tr,
      icon: 'quick_donation',
    ),
    ShortcutItem(
      type: 'basket',
      localizedTitle: 'Cart'.tr,
      icon: 'basket',
    ),
    ShortcutItem(
      type: 'notifications',
      localizedTitle: 'Notifications'.tr,
      icon: 'notifications',
    ),
  ];

  /// Initialize Quick Actions
  static init() async {
    if(!Get.find<AppControllerX>().generalSettings.isActiveQuickDonation){
      /// To remove the quick donation action button if it is disabled
      shortcuts.removeAt(0);
    }
    quickActions.initialize((String shortcutType) async {
      switch (shortcutType) {
        case 'quickDonation':
          RootController root = Get.find();
          await root.openQuickDonation(isFromAction: true);
        case 'basket':
          Get.toNamed(RouteNameX.cart);
        case 'notifications':
          Get.toNamed(RouteNameX.notifications);
        default:
          Get.toNamed(RouteNameX.root);
      }
    });
    quickActions.setShortcutItems(shortcuts);
  }
}
