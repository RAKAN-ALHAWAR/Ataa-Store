import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../UI/Widget/widget.dart';

class DonationAmountSectionX extends StatelessWidget {
  const DonationAmountSectionX(this.controller, {super.key});
  final PayDonationControllerX controller;
  @override
  Widget build(BuildContext context) {
    /// Enter and display the donation amount
    if (controller.donation.sharesPackages.isEmpty) {
      return Form(
        key: controller.formKey,
        autovalidateMode: controller.autoValidate,
        child: TextFieldX(
          controller: controller.donationAmount,
          onChanged: controller.removeFreeDonationSelected,
          textInputType: TextInputType.number,
          textInputAction: TextInputAction.done,
          hint: "0",
          onlyRead: controller.donation.isCanEditAmount == false && (controller.donation.donationDeductionPackages.isNotEmpty || controller.donation.openPackages.isNotEmpty),
          validate: controller.validateAmount,
          suffixWidget: Icon(
            IconX.sar,
            size: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ).fadeAnimation300;
    } else {
      return const SizedBox();
    }
  }
}
