import 'package:ataa/Config/config.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Core/core.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class DetailsSection extends GetView<PaymentSuccessfulController> {
  const DetailsSection({super.key});
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardTheme.color,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(top: 28),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextX(
                'Transaction number',
                color: Theme.of(context)
                    .colorScheme
                    .secondary,
              ),
              GestureDetector(
                onTap: () => ClipboardX.copy(controller.paymentTransaction.code.toString()),
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      const Icon(IconX.copy),
                      const SizedBox(width: 6),
                      TextX(
                        controller.paymentTransaction.code.toString(),
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 18,vertical: 8),
           Divider(color: context.isDarkMode?null:ColorX.grey.shade100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextX(
                'Payment method',
                color: Theme.of(context)
                    .colorScheme
                    .secondary,
              ),
              TextX(
                controller.paymentTransaction.paymentMethodLocalized??controller.paymentTransaction.paymentMethod.name,
                fontWeight: FontWeight.w700,
              ),
            ],
          ).paddingSymmetric(horizontal: 18,vertical: 8),
          Divider(color: context.isDarkMode?null:ColorX.grey.shade100),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextX(
                'Total amount',
                color: Theme.of(context)
                    .colorScheme
                    .secondary,
              ),
              Row(
                children: [
                  TextX(
                    FunctionX.formatLargeNumber(controller.paymentTransaction.price??0),
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(width: 6),
                  const Icon(IconX.sar,size: 16),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 18,vertical: 8),
        ],
      ),
    ).fadeAnimation350;
  }
}
