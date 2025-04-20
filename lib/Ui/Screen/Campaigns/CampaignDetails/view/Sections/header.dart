import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class HeaderSectionX extends GetView<CampaignDetailsController> {
  const HeaderSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Zakat marker
              if (controller.campaign.donation.donationSettings.isZakat)
                const ZakatDisbursementsCardX().fadeAnimation300,

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
          const SizedBox(height: 6)
        ],
      ),
    );
  }
}
