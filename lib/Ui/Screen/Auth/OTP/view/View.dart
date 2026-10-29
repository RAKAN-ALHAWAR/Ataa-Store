import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/data.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/backButton.dart';
import 'Sections/mainContent.dart';

class OTPView extends GetView<OTPController> {
  OTPView({bool isSheet = false, OtpX? otp, super.key}) {
    /// if open this screen from bottom sheet as in share section
    if (isSheet) {
      Get.put(OTPController());
      controller.isSheet = true;
      if (otp != null) {
        controller.otp = otp;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.isSheet) {
      return const MainContentOtpX();
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).canvasColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 20.0,
              left: StyleX.hPaddingApp,
              right: StyleX.hPaddingApp,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BackButtonSectionX(),
                    const SizedBox(height: 30.0),
                    const LogoX().fadeAnimation200,
                    const SizedBox(height: 40.0),
                    const MainContentOtpX(),
                  ],
                ),
                /// Sponsor Logo
                const SponsorLogoX().fadeAnimation700,
              ],
            ),
          ),
        ),
      );
    }
  }
}
