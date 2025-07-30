import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class InputSectionX extends GetView<EditProfileController> {
  const InputSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Name & Mobile & Email
        Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidate,
          child: Column(
            children: [
              TextFieldX(
                controller: controller.name,
                label: "Name",
                hint: "your name",
                isRequired: controller.nameIsRequired(),
                validate: controller.validateForName(),
                textInputType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ).fadeAnimation200,
              PhoneFieldX(
                controller: controller.phone,
                label: "Mobile Number",
                isRequired: true,
                onChangeCountryCode: controller.onChangeCountryCode,
                countryCode: controller.countryCode,
                isActiveError: controller.isEditPhoneAndEmailError.value,
                isDisableChangeCountryCode:
                !controller.app.generalSettings.isShowCountryCodeList,
              ).marginSymmetric(vertical: 10.0).fadeAnimation300,
              TextFieldX(
                controller: controller.email,
                label: "Email",
                hint: "name@example.com",
                isRequired: controller.emailIsRequired(),
                validate: controller.validateForEmail(),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                isActiveError: controller.isEditPhoneAndEmailError.value,
              ).fadeAnimation300,
            ],
          ),
        ),
        const SizedBox(height: 10),

        if (controller.isEditPhoneAndEmailError.value)
          const TextX(
            'Mobile number and email cannot be modified at the same time',
            color: ColorX.danger,
          ).marginOnly(bottom: 10),

        /// Gender
        const LabelInputX("Gender").fadeAnimation300,
        Obx(
              () {
            return Row(
              children: [
                Flexible(
                  child: RadioButtonX(
                    label: "Male",
                    groupValue: controller.gender.value,
                    value: "male",
                    onChanged: controller.onChangeGender,
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: RadioButtonX(
                    label: "Female",
                    groupValue: controller.gender.value,
                    value: "female",
                    onChanged: controller.onChangeGender,
                  ),
                ),
              ],
            ).fadeAnimation400;
          },
        ),
      ],
    ),);
  }
}
