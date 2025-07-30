import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Core/core.dart';
import '../../../../UI/Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Displaying a message informing the user that the section he wants to interact
/// with requires a mandatory login
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mandatoryAuthSheetX() {
  //============================================================================
  // Injection of required controls

  final AppControllerX controller = Get.find();

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Mandatory login",
    child: Column(
      children: [
        /// Description
        const TextX(
          "You must log in to complete the process",
          fontWeight: FontWeight.w600,
        ).fadeAnimation200,
        const SizedBox(height: 16),

        /// Login Button
        ButtonX(
          onTap: () async {
            /// Close this bottom sheet
            Get.back();

            /// Open the bottom sheet to login
            await controller.onLoginSheet();
          },
          text: "Login",
        ).fadeAnimation300,
      ],
    ),
  );
}
