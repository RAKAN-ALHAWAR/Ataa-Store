import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class MyAccountSectionX extends GetView<ProfileDetailsController> {
  const MyAccountSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return OptionsGroupCardX(
      title: "My Account",
      options: [
        OptionCardX(
          title: 'Dashboard',
          icon: Icons.insert_chart_rounded,
          onTap: controller.onStatistics,
        ).fadeAnimation400,
        OptionCardX(
          title: 'Edit profile',
          icon: Icons.account_circle_rounded,
          onTap: controller.onEditProfile,
        ).fadeAnimation400,
        OptionCardX(
          title: 'My activity on the platform',
          icon: IconX.myActivity,
          onTap: controller.onActivity,
        ).fadeAnimation400,
        OptionCardX(
          title: 'Notifications',
          icon: Iconsax.notification5,
          onTap: controller.onNotifications,
          isBottomLine: false,
        ).fadeAnimation400,
      ],
    );
  }
}
