import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../UI/Widget/widget.dart';

class SharesSectionX extends StatelessWidget {
  const SharesSectionX(this.controller, {super.key});
  final PayDonationControllerX controller;
  @override
  Widget build(BuildContext context) {
    if (controller.donation.donationShares != null &&
        controller.donation.sharesPackages.isEmpty) {
      return Column(
        children: [
          /// this just for show label of share or not
          const LabelInputX("Number of Shares").fadeAnimation200,

          /// Enter the number of shares
          Obx(
            () => NumberFieldX(
              min: 1,
              onChanged: controller.onChangeStockValue,
              value: controller.numOfStock.value,
              max: 100000,
              color: Theme.of(context).cardColor,
            ),
          ).fadeAnimation200,
        ],
      );
    } else if (controller.donation.donationShares != null &&
        controller.donation.sharesPackages.isNotEmpty) {
      return Row(
        children: [
          Expanded(
            flex: 4,
            child: Obx(
              () => NumberFieldX(
                min: 1,
                onChanged: controller.onChangeStockValue,
                value: controller.numOfStock.value,
                margin: EdgeInsets.zero,
                max: 100000,
                color: Theme.of(context).cardColor,
              ),
            ).fadeAnimation300,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 6,
            child: Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidate,
              child: TextFieldX(
                controller: controller.donationAmount,
                onChanged: controller.removeFreeDonationSelected,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                hint: "0",
                onlyRead: !controller.donation.isCanEditAmount,
                validate: controller.validateAmount,
                suffixWidget: Icon(
                  IconX.sar,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ).fadeAnimation300,
          )
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
