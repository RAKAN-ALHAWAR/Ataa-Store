import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Config/config.dart';
import '../../../../ScreenSheet/Other/Language/languageSheet.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextX(
              'General',
              style: TextStyleX.titleSmall,
              color: Theme.of(context).colorScheme.secondary,
            ).fadeAnimation100,
            const SizedBox(height: 12),

            /// Card
            OptionsGroupCardX(
              options: [
                /// Language
                OptionCardX(
                  title: 'Language',
                  icon: Iconsax.translate5,
                  onTap: () {
                    languageSheetX(controller.changeLanguage);
                  },
                ).fadeAnimation200,

                /// Theme
                OptionCardX(
                  title: 'Theme',
                  icon: Iconsax.moon5,
                  onTap: controller.changeTheme,
                  isBottomLine: false,
                  child: Obx(
                    () => SwitchX(
                      value: controller.themeIsDark.value,
                      onChange: (_) => controller.changeTheme(),
                    ),
                  ),
                ).fadeAnimation250,
              ],
            ).fadeAnimation100,

            const SizedBox(height: 30),
            TextX(
              'Account',
              style: TextStyleX.titleSmall,
              color: Theme.of(context).colorScheme.secondary,
            ).fadeAnimation300,
            const SizedBox(height: 12),

            /// Delete Account
            OptionsGroupCardX(
              options: [
                OptionCardX(
                  title: 'Delete Account',
                  icon: Iconsax.trash,
                  onTap: () => bottomSheetDangerousX(
                    title: "Delete Account",
                    message: "Are you sure you want to delete your account?",
                    okText: "Delete",
                    cancelText: "Stay",
                    icon: Icons.warning_rounded,
                    onOk: controller.app.deleteAccount,
                  ),
                  isBottomLine: false,
                  isDanger: true,
                ).fadeAnimation350,
              ],
            ).fadeAnimation300,
          ],
        ),
      ),
    );
  }
}
