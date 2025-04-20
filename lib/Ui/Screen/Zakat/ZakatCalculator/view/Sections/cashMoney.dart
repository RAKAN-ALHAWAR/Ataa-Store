import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Core/core.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class CashMoneySectionX extends GetView<ZakatCalculatorController> {
  const CashMoneySectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ZakatCalculatorCardX(
        title: "Zakat on cash",
        isOpen: controller.isCashMoney.value,
        onChangeOpen: controller.onOpenCashMoney,
        error: controller.cashError.value,
        isLoading: controller.cashIsLoading.value,
        isDone: controller.cashIsDone.value,
        child: Column(
          children: [
            const LabelInputX("The Amount", marginTop: 0),
            Form(
              key: controller.cashFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFieldX(
                /// To calculate the value of Zakat after changing the value
                onEditingComplete: (_) async => await controller.calculateCashMoney(),
                controller: controller.cash,
                textInputType: TextInputType.number,
                textInputAction: TextInputAction.done,
                validate: ValidateX.moneyOptional,
                color: Theme.of(context).cardColor,
                errorMaxLines: 2,
                hint: "0",
                suffixWidget: Icon(
                  IconX.sar,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ],
        ),
      ).fadeAnimation200,
    );
  }
}
