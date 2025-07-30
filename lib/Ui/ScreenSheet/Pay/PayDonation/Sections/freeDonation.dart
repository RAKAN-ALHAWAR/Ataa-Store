import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../UI/Widget/widget.dart';

class FreeDonationSectionX extends StatelessWidget {
  const FreeDonationSectionX(this.controller, {super.key});
  final PayDonationControllerX controller;
  @override
  Widget build(BuildContext context) {
    /// Free Donation Options [ 20 , 50 , 100 ] SAR
    if (controller.donation.donationShares == null &&
        controller.donation.openPackages.isEmpty) {
      return Obx(
        () => FreeDonationOptionsX(
          isMarginTop: false,
          onSelected: controller.onChangeDonationAmount,
          selected: controller.freeDonationSelected.value,
        ),
      ).fadeAnimation200;
    } else {
      return const SizedBox();
    }
  }
}
