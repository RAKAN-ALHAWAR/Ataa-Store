import 'package:ataa/Data/Enum/gender_status.dart';
import 'package:ataa/Ui/Animation/animation.dart';
import 'package:ataa/Ui/Widget/Basic/Utils/future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Config/config.dart';
import '../../../../../Ui/Widget/widget.dart';
import '../../../../Widget/Custom/Card/giftCardForGifting.dart';
import '../controller/Controller.dart';

class PreviewGiftView extends GetView<PreviewGiftController> {
  const PreviewGiftView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: 'Preview gift',
        actions: [
          CartIconButtonsX(),
        ],
      ),
      body: SafeArea(
        child: FutureBuilderX(
          future: controller.getData,
          loading: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              vertical: StyleX.vPaddingApp,
              horizontal: StyleX.hPaddingApp,
            ),
            child: Column(
              children: [
                const AspectRatio(
                  aspectRatio: 310 / 473.8,
                  child: ShimmerAnimationX(
                    height: 1000,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Flexible(child: ShimmerAnimationShapeX.button()),
                    const SizedBox(width: 8),
                    Flexible(child: ShimmerAnimationShapeX.button()),
                  ],
                ),
              ],
            ),
          ),
          child: (data) => Stack(
            children: [
              /// Hidden item to load as image
              Column(
                children: [
                  RepaintBoundary(
                    key: controller.globalKey,
                    child: GiftCardForGiftX(
                      nameFrom: controller.giftOrder.giftBasic.donorName,
                      nameTo: controller.giftOrder.giftBasic.recipientName,
                      amount: controller.giftOrder.giftBasic.price.toString(),
                      isShowAmount: controller.giftOrder.isShowPrice,
                      orgName: controller.organization.name,
                      borderWidth: 0,
                      radius: 0,
                      color: Color(
                        int.parse(
                            "0xff${controller.giftOrder.giftBasic.color.code.substring(1)}"),
                      ),
                      giftCardFormByGender:
                      controller.giftOrder.giftBasic.recipientGender ==
                          GenderStatusX.male
                          ? controller.giftCategory.giftCardFormMale
                          : controller.giftCategory.giftCardFormFemale,
                    ).fadeAnimation200,
                  ),
                  const Spacer(),
                ],
              ),
              Positioned.fill(child: Scaffold(
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: StyleX.vPaddingApp,
                    horizontal: StyleX.hPaddingApp,
                  ),
                  child: Column(
                    children: [
                      GiftCardForGiftX(
                        nameFrom: controller.giftOrder.giftBasic.donorName,
                        nameTo: controller.giftOrder.giftBasic.recipientName,
                        amount: controller.giftOrder.giftBasic.price.toString(),
                        isShowAmount: controller.giftOrder.isShowPrice,
                        orgName: controller.organization.name,
                        borderWidth: 8,
                        radius: StyleX.radiusLg,
                        color: Color(
                          int.parse(
                              "0xff${controller.giftOrder.giftBasic.color.code.substring(1)}"),
                        ),
                        giftCardFormByGender: controller.giftOrder.giftBasic.recipientGender ==
                            GenderStatusX.male
                            ? controller.giftCategory.giftCardFormMale
                            : controller.giftCategory.giftCardFormFemale,
                      ).fadeAnimation200,
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Flexible(
                            child: ButtonX(
                              text: "Download Gift Card",
                              onTap: controller.onSavePng,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: ButtonX.second(
                              text: "Back",
                              onTap: Get.back,
                            ),
                          ),
                        ],
                      ).fadeAnimation300,
                    ],
                  ),
                ),
              ),),
            ],
          ),
        ),
      ),
    );
  }
}
