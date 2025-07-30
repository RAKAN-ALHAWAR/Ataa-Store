import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class HeaderSectionX extends GetView<DonationDetailsController> {
  const HeaderSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Zakat marker
              if (controller.donation.donationSettings.isZakat)
                const ZakatDisbursementsCardX().fadeAnimation300,

              /// Replace the title if the zakat mark is empty
              if (!controller.donation.donationSettings.isZakat)
                Flexible(
                  child: TextX(
                    controller.donation.donationBasic.name,
                    color: Theme.of(context).primaryColor,
                    style: TextStyleX.headerSmall,
                  ).fadeAnimation300,
                ),
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

          /// Location of the original address if there is a zakat mark
          if (controller.donation.donationSettings.isZakat)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextX(
                controller.donation.donationBasic.name,
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
