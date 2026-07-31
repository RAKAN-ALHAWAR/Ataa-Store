import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Animation/animation.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/mainContent.dart';

class ContinueToAccountView extends GetView<ContinueToAccountController> {
  ContinueToAccountView({bool isSheet = false, super.key}) {
    /// if open this screen from bottom sheet as in share section
    if (isSheet) {
      Get.put(ContinueToAccountController());
      controller.isSheet = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isSheet) {
      return const MainContentLoginX();
    } else {
      return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 70.0,
              bottom: 20.0,
              left: StyleX.hPaddingApp,
              right: StyleX.hPaddingApp,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LogoX().fadeAnimation200,
                const SizedBox(height: 40.0),
                const MainContentLoginX(),
                const SponsorLogoX().marginOnly(top: 40).fadeAnimation900,
              ],
            ),
          ),
        ),
      );
    }
  }
}
