import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../controller/Controller.dart';
import 'Sections/aboutApp.dart';
import 'Sections/appVersion.dart';
import 'Sections/appbar.dart';
import 'Sections/logout.dart';
import 'Sections/myAccount.dart';

class ProfileDetailsView extends GetView<ProfileDetailsController> {
  const ProfileDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const AppBarSectionX(),
          const SizedBox(height: 5),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 160,
                left: StyleX.hPaddingApp,
                right: StyleX.hPaddingApp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.app.isLogin.value)
                    const MyAccountSectionX().marginOnly(bottom: 20),
                    const AboutAppSectionX(),
                   if (controller.app.isLogin.value)
                    const LogoutSectionX(),
                  const AppVersionSectionX(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
