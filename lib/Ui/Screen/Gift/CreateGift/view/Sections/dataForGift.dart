import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../../Core/core.dart';
import '../../controller/Controller.dart';

class DataForGiftSectionX extends GetView<CreateGiftController> {
  const DataForGiftSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          const TextX(
            "Dedication Data",
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 14),

          /// Gift Card
          ContainerX(
            child: Form(
              key: controller.formKeyForDedicatesData,
              autovalidateMode: controller.autoValidateForDedicatesData,
              child: Column(
                children: [
                  /// Giver's name
                  TextFieldX(
                    controller: controller.donorName,
                    label: "Your Name (or the Donor’s Name)",
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validate: ValidateX.name,
                  ).paddingOnly(bottom: 10).fadeAnimation300,

                  /// Gifted to him
                  TextFieldX(
                    controller: controller.recipientName,
                    label: "Recipient’s Name",
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validate: ValidateX.name,
                  ).paddingOnly(bottom: 10).fadeAnimation400,

                  /// Input Phone Number
                  Obx(
                    () => PhoneFieldX(
                      key:
                          Key(controller.recipientCountryCode.value.toString()),
                      label: "Recipient’s Mobile Number",
                      controller: controller.recipientPhone,
                      onChangeCountryCode: controller.onChangeCountryCode,
                      countryCode: controller.recipientCountryCode.value,
                      isDisableChangeCountryCode:
                          !controller.app.generalSettings.isShowCountryCodeList,
                    ).paddingOnly(bottom: 10).fadeAnimation400,
                  ),

                  /// Get data from contacts
                  InkWell(
                    onTap: controller.onPhoneFromContacts,
                    borderRadius: BorderRadius.circular(StyleX.radius),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 20,
                          color: Get.theme.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        TextX(
                          "Choose from contacts",
                          style: TextStyleX.titleSmall,
                          fontWeight: FontWeight.w600,
                          color: Get.theme.primaryColor,
                        )
                      ],
                    ),
                  ).fadeAnimation500,
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ).fadeAnimation500,
    );
  }
}
