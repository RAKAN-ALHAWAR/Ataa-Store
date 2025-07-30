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
    if (controller.donation.donationDeductionPackages.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextX(
            'Select the type of donation',
            fontWeight: FontWeight.w400,
          ).fadeAnimation200,
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              return FlexList(
                horizontalSpacing: 6,
                verticalSpacing: 6,
                children: controller.donation.donationDeductionPackages.map(
                      (data) {
                    return IntrinsicWidth(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth / 3 - 12, // ملئ المساحة المتاحة لكل عنصر إلى النصف تقريبا
                        ),
                        child: Obx(
                              () => SelectedCardX<String>(
                            value: data.id,
                            label: data.name,
                            color: Theme.of(context).cardColor,
                            margin:EdgeInsets.zero,
                            onChanged: (_) =>
                                controller.onChangeDeductionPackage(data),
                            groupValue:
                            controller.sharesPackageSelected.value?.id,
                          ).fadeAnimation250,
                        ),
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
    } else {
      return const SizedBox();
    }
  }
}
