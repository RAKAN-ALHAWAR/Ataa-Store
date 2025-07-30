import 'package:ataa/Core/core.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Core/Controller/Pay/payDonationController.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Widget/Basic/Input/selectedCard.dart';
import '../../../../Widget/Package/flex_list.dart';

class SharesPackagesSectionX extends StatelessWidget {
  const SharesPackagesSectionX(this.controller, {super.key});
  final PayDonationControllerX controller;
  @override
  Widget build(BuildContext context) {
    /// Choose the best packages available
    if (controller.donation.isShowPackages &&
        controller.donation.sharesPackages.isNotEmpty) {
      if (controller.donation.sharesPackages.length > 4) {
        return Obx(
          () => MultipleSelectionCardX(
            title: "Select the category that suits you",
            selected: controller.sharesPackageSelected.value != null
                ? '${FunctionX.formatLargeNumber(controller.sharesPackageSelected.value!.sharesCount * controller.donation.donationShares!.price)} ${'SAR'.tr}  ( ${controller.sharesPackageSelected.value!.name} )'
                : '',
            onTap: () async {
              await bottomSheetX(
                title: "Select the category that suits you",
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...controller.donation.sharesPackages.map(
                        (data) {
                          return RadioButtonX<String>(
                            label:
                                '${FunctionX.formatLargeNumber(data.sharesCount * controller.donation.donationShares!.price)} ${'SAR'.tr}  ( ${data.name} )',
                            value: data.id,
                            onChanged: (_) {
                              controller.onChangeSharesPackage(data);
                              Get.back();
                            },
                            groupValue:
                                controller.sharesPackageSelected.value?.id,
                          ).fadeAnimation250;
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ).marginOnly(bottom: 4),
        ).fadeAnimation200;
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
                return Align(
                  alignment: Alignment.centerRight,
                  child: FlexList(
                    horizontalSpacing: 6,
                    verticalSpacing: 6,
                    children: controller.donation.sharesPackages.map(
                      (data) {
                        return Directionality(
                          textDirection: Directionality.of(context),
                          child: IntrinsicWidth(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth / 2 -
                                    6, // ملئ المساحة المتاحة لكل عنصر إلى النصف تقريبا
                              ),
                              child: Obx(
                                () => SelectedCardX<String>(
                                  value: data.id,
                                  color: Theme.of(context).cardColor,
                                  margin: EdgeInsets.zero,
                                  onChanged: (_) =>
                                      controller.onChangeSharesPackage(data),
                                  groupValue: controller
                                      .sharesPackageSelected.value?.id,
                                  child: FittedBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Row(
                                      children: [
                                        TextX(
                                          '${FunctionX.formatLargeNumber(data.sharesCount * controller.donation.donationShares!.price)} ${'SAR'.tr}',
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        const SizedBox(width: 10),
                                        TextX(data.name),
                                      ],
                                    ),
                                  ),
                                ).fadeAnimation250,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
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
