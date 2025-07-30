import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/Other/donateOnBehalfOfFamilyController.dart';
import '../../../../Core/core.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~{{ Why this part of bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~
/// Enter data to donate on his behalf, and it contains its own controller.
/// This section is used in more than one bottom sheet
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class DonateOnBehalfOfFamilyPartOfSheetX extends StatelessWidget {
  const DonateOnBehalfOfFamilyPartOfSheetX({
    required this.controller,
    super.key,
  });

  //============================================================================
  // Injection of required controls

  final DonateOnBehalfOfFamilyController controller;

  //============================================================================
  // Content

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          /// Activate or hide the section
          SwitchX(
            value: controller.isEnable.value,
            onChange: controller.onEnable,
            margin: const EdgeInsets.only(top: 5),
            label: "Donate on behalf of your family and friends",
          ).fadeAnimation300,
          if (controller.isEnable.value)
            ///
            Form(
              key: controller.formKey,
              autovalidateMode: controller.autoValidate,
              child: Column(
                children: [
                  /// Donor's name
                  TextFieldX(
                    controller: controller.donorName,
                    label: "Donor's name",
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validate: ValidateX.name,
                    hint: "your name",
                  ).fadeAnimation300,

                  /// Gifted to him
                  TextFieldX(
                    controller: controller.recipientName,
                    label: "Recipient’s Name",
                    textInputType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    hint: "name of gifted",
                    validate: ValidateX.name,
                  ).fadeAnimation400,

                  /// Phone Number
                  PhoneFieldX(
                    label: "Recipient’s Mobile Number",
                    key: Key(controller.countryCode.value.toString()),
                    controller: controller.giftedPhone,
                    onChangeCountryCode: controller.onChangeCountryCode,
                    countryCode: controller.countryCode.value,
                    isDisableChangeCountryCode: !controller.app.generalSettings.isShowCountryCodeList,
                  ).fadeAnimation400,

                  /// Get data from contacts
                  InkWell(
                    onTap: controller.onPhoneFromContacts,
                    borderRadius: BorderRadius.circular(StyleX.radius),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 20,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(width: 8),
                          TextX(
                            "Choose from contacts",
                            style: TextStyleX.titleSmall,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColor,
                          )
                        ],
                      ),
                    ),
                  ).fadeAnimation500,
                  const SizedBox(height: 4),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
