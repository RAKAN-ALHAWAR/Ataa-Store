import 'package:ataa/Config/config.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../Data/Enum/payment_status_status.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class HeaderSection extends GetView<PaymentSuccessfulController> {
  const HeaderSection({super.key});
  @override
  Widget build(BuildContext context) {
    bool isInitiated = controller.paymentTransaction.paymentDataBankTransfer != null || controller
        .paymentTransaction.status==PaymentStatusStatusX.initiated;
    return Column(
      children: [
        ContainerX(
          radius: StyleX.radiusMd,
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 20,
          ),
          color:
          isInitiated ? context.isDarkMode
                  ? Theme.of(context).cardTheme.color
                  : ColorX.grey.shade100
              : Theme.of(context).colorScheme.onPrimary,
          child: Icon(
            isInitiated
                ? IconX.payTransfer
                : Icons.check_rounded,
            color: isInitiated
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).primaryColor,
            size: 46,
          ),
        ).fadeAnimation200,
        const SizedBox(height: 24),
        TextX(
          isInitiated
              ? 'Pending review'
              : 'Payment completed successfully',
          style: TextStyleX.headerSmall,
          color: Theme.of(context).primaryColor,
        ).fadeAnimation250,
      ],
    );
  }
}
