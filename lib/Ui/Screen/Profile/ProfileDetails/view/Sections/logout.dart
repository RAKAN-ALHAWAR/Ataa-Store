import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class LogoutSectionX extends GetView<ProfileDetailsController> {
  const LogoutSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: ButtonX.gray(
        text: 'Logout',
        iconData: Icons.logout_rounded,
        onTap: () => bottomSheetDangerousX(
          title: "Logout",
          message: "Are you sure you want to log out?",
          okText: "Logout",
          cancelText: "Stay",
          icon: Icons.warning_rounded,
          onOk: controller.app.logOut,
        ),
      ),
    );
  }
}
