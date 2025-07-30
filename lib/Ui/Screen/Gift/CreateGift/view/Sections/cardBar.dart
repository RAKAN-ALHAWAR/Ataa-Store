import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../Widget/Custom/Card/giftCardForGifting.dart';
import '../../controller/Controller.dart';

class CardBarSectionX extends GetView<CreateGiftController> {
  const CardBarSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const TextX(
          "Gift Card",
          fontWeight: FontWeight.w700,
        ).paddingSymmetric(horizontal: StyleX.hPaddingApp).fadeAnimation400,
        const SizedBox(height: 14),

        /// Gift Card
        Obx(
          () => GiftCardForGiftX(
            isPreview: true,
            nameFrom: controller.donorNameForCard.value,
            nameTo: controller.recipientNameForCard.value,
            amount: controller.donationAmountForCard.value,
            isShowAmount: controller.isShowAmount.value,
            orgName: controller.orgSelected.value?.name,
            color: Color(
              int.parse(
                  "0xff${controller.colors[controller.colorSelectedIndex.value]}"),
            ),
            giftCardFormByGender: controller.giftCardFormByGenderSelected.value,
          ).paddingSymmetric(horizontal: 40).fadeAnimation400,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
