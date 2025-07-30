import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../Data/Enum/recurring_status.dart';
import '../../../../../UI/Widget/widget.dart';

class DeductionMessageSectionX extends StatelessWidget {
  const DeductionMessageSectionX(this.controller, {super.key});
  final PayDonationControllerX controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.deductionPackageSelected.value != null &&
            controller.donation.donationDeductionPackages.isNotEmpty) {
          return MessageCardX(
            message: controller
                .deductionPackageSelected.value!.recurring.name ==
                RecurringStatusX.monthly.name
                ? 'The amount will be automatically deducted on the first day of every calendar month.'.tr
                : '${'The amount is automatically deducted every'.tr} ${(controller
                .deductionPackageSelected.value!.recurring.name == RecurringStatusX.daily.name) ? '' : '${DateFormat('EEEE').format(DateTime.now()).toLowerCase().tr} ${'of each week.'.tr}'}',
          ).marginSymmetric(vertical: 8).fadeAnimation200;
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
