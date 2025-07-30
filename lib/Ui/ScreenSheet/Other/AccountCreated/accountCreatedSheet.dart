import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../UI/Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Display the option to complete account information after account creation
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

accountCreatedSheet() {
  return bottomSheetSuccessX(
    icon: Icons.check_rounded,
    title: "Your account has been created successfully",
    message: "Would you like to complete your account information now?",
    okText: "Ok",
    cancelText: "Complete later",
    onOk: () => Get.toNamed(RouteNameX.completeAccountData),
  );
}
