import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../Widget/Custom/Card/giftOrgCard.dart';
import '../../controller/Controller.dart';

class OrgBarSectionX extends GetView<CreateGiftController> {
  const OrgBarSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        const TextX(
          "Choose the donation field",
          fontWeight: FontWeight.w700,
        ).paddingSymmetric(horizontal: StyleX.hPaddingApp).fadeAnimation600,
        const SizedBox(height: 14),

        Obx(() {
          if (controller.organizations.isEmpty) {
            return ContainerX(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(
                horizontal: StyleX.hPaddingApp,
              ),
              color: Theme.of(context).colorScheme.onError,
              height: 110,
              child: Center(
                child:  TextX(
                  'Please select a gift type above to view the available donation fields',
                textAlign: TextAlign.center,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            );
          } else {
            /// Organization Options
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: StyleX.hPaddingApp,
              ),
              child: Row(
                children: [
                  for (int index = 0;
                      index < controller.organizations.length;
                      index++)
                    GiftOrgCardX(
                      onTap: () => controller.onChangeOrg(index),
                      org: controller.organizations[index],
                      isSelected: controller.orgSelected.value?.id ==
                          controller.organizations[index].id,
                    ),
                ],
              ),
            ).fadeAnimation200;
          }
        }).fadeAnimation600,

        const SizedBox(height: 24),
      ],
    );
  }
}
