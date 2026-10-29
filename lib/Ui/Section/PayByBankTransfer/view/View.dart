import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Data/data.dart';
import '../../../Widget/widget.dart';
import '../controller/Controller.dart';

class PayByBankTransferSectionX extends StatelessWidget {
  PayByBankTransferSectionX({
    super.key,
    this.header,
    this.padding,
    PayByBankTransferController? controller,
  }) {
    this.controller = controller ?? Get.put(PayByBankTransferController());
  }
  final Widget? header;
  final EdgeInsets? padding;
  late final PayByBankTransferController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownX<BankX>(
            title: 'Transfer to bank',
            value: controller.bankSelected.value,
            valueShow: (x) => x.name,
            list: controller.banks,
            hint: '-- Choose bank --',
            onChanged: controller.onChangeBank,
          ).fadeAnimation250,
          const SizedBox(height: 10),
          DropdownX<BankAccountX>(
            title: 'Transfer to account',
            value: controller.bankAccountSelected.value,
            valueShow: (x) => x.name,
            list: controller.bankSelected.value?.bankAccounts ?? [],
            hint: '-- Choose account --',
            onChanged: controller.onChangeBankAccount,
          ).fadeAnimation300,
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFieldX(
                  controller: controller.iban,
                  label: 'IBAN',
                  onlyRead: true,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: controller.onCopyIban,
                child: ContainerX(
                  isBorder: true,
                  height: StyleX.inputHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Icon(
                      IconX.copy,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ).marginSymmetric(vertical: 5),
            ],
          ).fadeAnimation350,
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextFieldX(
                  controller: controller.imageName,
                  label: 'Transfer image',
                  onlyRead: true,
                  borderRadius: const BorderRadiusDirectional.horizontal(start: Radius.circular(StyleX.radius)),
                ),
              ),
              GestureDetector(
                onTap: controller.changeImage,
                child: ContainerX(
                  isBorder: true,
                  borderRadius: const BorderRadiusDirectional.horizontal(end: Radius.circular(StyleX.radius)),
                  height: StyleX.inputHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: Theme.of(context).primaryColor,
                  child: const Center(
                    child: TextX('Browse',color: Colors.white,),
                  ),
                ),
              ).marginSymmetric(vertical: 5),
            ],
          ).fadeAnimation400,
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
