import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Config/config.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class StaticOptionsSectionX extends GetView<MoreSectionsController> {
  const StaticOptionsSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        right: StyleX.hPaddingApp,
        left: StyleX.hPaddingApp,
        top: StyleX.vPaddingApp,
        bottom: 140,
      ),
      child: Column(
        children: [
          MoreCardX(
            title: "Our Programs",
            icon: IconX.briefcase,
            onTap: controller.onAssociationPrograms,
          ).fadeAnimation200,

          /// TODO: Show >>> Sponsorships
          // MoreCardX(title: "Sponsorships", icon: Icons.thumb_up_rounded,onTap: controller.onSponsorships,).fadeAnimation200,
          MoreCardX(
            title: "Gifting",
            icon: IconX.gift,
            onTap: controller.onGifting,
          ).fadeAnimation300,

          MoreCardX(
            title: "Deductions",
            icon: IconX.creditCard,
            onTap: controller.onDeductions,
          ).fadeAnimation300,
          MoreCardX(
            title: "Zakat",
            icon: Icons.verified,
            onTap: controller.onZakat,
          ).fadeAnimation400,

          MoreCardX(
            title: "Donation campaigns",
            icon: IconX.speakerPhone,
            onTap: controller.onDonationCampaigns,
          ).fadeAnimation400,

          /// TODO: Show >>> Store
          // MoreCardX(title: "The Store", icon: Icons.shopping_bag_rounded,onTap: controller.onStore,).fadeAnimation400,
          MoreCardX(
            title: "More Pages",
            icon: Iconsax.category5,
            onTap: controller.root.changeMoreDynamicPage,
          ).fadeAnimation400,
        ],
      ),
    );
  }
}
