import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class HeaderSectionX extends GetView<DeductionDetailsController> {
  const HeaderSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Deduction marker
              DeductionMarkerCardX(deduction: controller.deduction.recurring.name)
                  .fadeAnimation300,

              const SizedBox(width: 20),

              /// Share Button
              ButtonX.gray(
                width: 100,
                height: StyleX.buttonHeightSm,
                marginVertical: 0,
                onTap: controller.openShare,
                text: "Share",
                iconData: Icons.share,
                colorText: Theme.of(context).iconTheme.color,
              ).fadeAnimation300,
            ],
          ),

          /// Deduction Name
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextX(
              controller.deduction.name,
              color: Theme.of(context).primaryColor,
              style: TextStyleX.headerSmall,
            ),
          ).fadeAnimation300,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
