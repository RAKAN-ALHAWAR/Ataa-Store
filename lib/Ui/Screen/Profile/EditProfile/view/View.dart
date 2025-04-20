import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/input.dart';
import 'Sections/profileImage.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: "Edit Profile"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: Column(
          children: [
            /// Card Inputs
            const ContainerX(
              width: double.maxFinite,
              child: Column(
                children: [
                  /// Image Input
                  ProfileImageSectionX(),
                  SizedBox(height: 20),

                  /// Text Input
                  InputSectionX(),
                ],
              ),
            ),
            const SizedBox(height: 25),

            /// Save & Cancel Buttons
            Row(
              children: [
                Flexible(
                  child: Obx(
                    () => ButtonStateX(
                      state: controller.buttonState.value,
                      onTap: controller.onEdit,
                      text: "Save",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: ButtonX.gray(
                    onTap: () => Get.back(),
                    text: "Cancel",
                  ),
                ),
              ],
            ).fadeAnimation500
          ],
        ),
      ),
    );
  }
}
