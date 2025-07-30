import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class AboutAppSectionX extends GetView<ProfileDetailsController> {
  const AboutAppSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionsGroupCardX(
      title: "About App",
      options: [
        OptionCardX(
          title: 'Settings',
          icon: Icons.settings_rounded,
          onTap: controller.onSettings,
        ).fadeAnimation400,
        OptionCardX(
          title: 'Contact us',
          icon: IconX.contactUs,
          onTap: controller.onContact,
        ).fadeAnimation400,
        OptionCardX(
          title: 'About Us',
          icon: Icons.info_rounded,
          onTap: controller.onInfo,
        ).fadeAnimation400,
        OptionCardX(
          title: 'Our Bank Accounts',
          icon: IconX.ourBanks,
          onTap: controller.onOurBank,
        ).fadeAnimation400,
        OptionCardX(
          title: 'Terms and Conditions',
          icon: Icons.description_rounded,
          onTap: controller.onTermsConditions,
        ).fadeAnimation400,
        OptionCardX(
          title: 'Privacy Policy',
          icon: Icons.verified_user_rounded,
          onTap: controller.onPrivacyPolicy,
          isBottomLine: false,
        ).fadeAnimation400,
      ],
    );
  }
}
