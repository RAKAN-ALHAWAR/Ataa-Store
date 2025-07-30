import 'package:ataa/Core/core.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Basic/Input/selectedCard.dart';
import '../../../../Widget/Package/flex_list.dart';

class OpenPackagesSectionX extends StatelessWidget {
  const OpenPackagesSectionX(this.controller, {super.key});
  final PayDonationControllerX controller;
  @override
  Widget build(BuildContext context) {
    /// Choose the best packages available
    if (controller.donation.isShowPackages &&
        controller.donation.openPackages.isNotEmpty) {
      if (controller.donation.openPackages.length > 4) {
        return Obx(
          () => MultipleSelectionCardX(
            title: "Select the category that suits you",
            selected: controller.openPackageSelected.value!=null?'${FunctionX.formatLargeNumber(controller.openPackageSelected.value!.price)} ${'SAR'.tr}  ( ${controller.openPackageSelected.value!.name} )':'',
            onTap: () async {
              await bottomSheetX(
                title: "Select the category that suits you",
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: [
                        ...controller.donation.openPackages.map(
                          (data) {
                            return RadioButtonX<String>(
                              label:
                                  '${FunctionX.formatLargeNumber(data.price)} ${'SAR'.tr}  ( ${data.name} )',
                              value: data.id,
                              onChanged: (_){
                                controller.onChangeOpenPackage(data);
                                Get.back();
                              },
                              groupValue:
                                  controller.openPackageSelected.value?.id,
                            ).fadeAnimation250;
                          },
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ).marginOnly(bottom: 4).fadeAnimation200;
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextX(
              'Select the category that suits you',
              fontWeight: FontWeight.w400,
            ).fadeAnimation200,
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                return FlexList(
                  horizontalSpacing: 6,
                  verticalSpacing: 6,
                  children: controller.donation.openPackages.map(
                    (data) {
                      return IntrinsicWidth(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: constraints.maxWidth / 2 - 6, // ملئ المساحة المتاحة لكل عنصر إلى النصف تقريبا
                          ),
                          child: Obx(
                            () => SelectedCardX<String>(
                              margin: EdgeInsets.zero,
                              value: data.id,
                              color: Theme.of(context).cardColor,
                              onChanged: (_) =>
                                  controller.onChangeOpenPackage(data),
                              groupValue:
                                  controller.openPackageSelected.value?.id,
                              child: FittedBox(
                                alignment: AlignmentDirectional.centerStart,
                                child: Row(
                                  children: [
                                    TextX(
                                      '${FunctionX.formatLargeNumber(data.price)} ${'SAR'.tr}',
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    const SizedBox(width: 10),
                                    TextX(data.name),
                                  ],
                                ),
                              ),
                            ),
                          ).fadeAnimation250,
                        ),
                      );
                    },
                  ).toList(),
                );
              },
            ),
            const SizedBox(width: double.infinity),
          ],
        ).marginOnly(bottom: 4);
      }
    } else {
      return const SizedBox();
    }
  }
}
