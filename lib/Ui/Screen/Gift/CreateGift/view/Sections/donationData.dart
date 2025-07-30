import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../../Core/core.dart';
import '../../controller/Controller.dart';

class DonationDataSectionX extends GetView<CreateGiftController> {
  const DonationDataSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            const TextX(
              "Donation Data",
              fontWeight: FontWeight.w700,
            ).fadeAnimation700,
            const SizedBox(height: 14),

            /// Donation Amount Field
            ContainerX(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FreeDonationOptionsX(
                    isMarginTop: false,
                    onSelected: controller.onChangeDonationAmount,
                    selected: controller.freeDonationSelected.value,
                  ),
                  Form(
                    key: controller.formKeyDonationAmount,
                    autovalidateMode: controller.autoValidateDonationAmount,
                    child: TextFieldX(
                      controller: controller.donationAmount,
                      onChanged: controller.onChangeAmountForFreeDonationSelected,
                      textInputType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      hint: "0",
                      validate: ValidateX.giftMoney,
                      suffixWidget: Icon(
                        IconX.sar,
                        size: 16,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  )
                ],
              ),
            ).fadeAnimation700,

            /// Switches Options
            const SizedBox(height: 14),
            SwitchX(
              label: "Show the amount on the gift card",
              value: controller.isShowAmount.value,
              onChange: controller.onChangeShowAmount,
              margin: EdgeInsets.zero,
            ).fadeAnimation800,
            SwitchX(
              label: "Send a copy to my mobile phone",
              value: controller.isSendToMe.value,
              onChange: controller.onChangeSendToMe,
              margin: EdgeInsets.zero,
            ).fadeAnimation800,

            /// Phone for send to me
            if (controller.isSendToMe.value)
              Form(
                key: controller.formKeyPhoneSendToMe,
                autovalidateMode: controller.autoValidatePhoneSendToMe,
                child: PhoneFieldX(
                  label: 'Mobile Number',
                  color: context.isDarkMode ? null : Theme.of(context).cardColor,
                  controller: controller.phoneSendToMe,
                  onChangeCountryCode: controller.onChangeCountryCodeForSendToMe,
                  isDisableChangeCountryCode:!controller.app.generalSettings.isShowCountryCodeList,
                ).fadeAnimation100,
              ).paddingOnly(top: 4),

            SwitchX(
              key: const Key('Send later'),
              label: "Send later",
              value: controller.isSendLater.value,
              onChange: controller.onChangeSendLater,
              margin: EdgeInsets.zero,
            ).fadeAnimation800,

            /// Sending Date
            if (controller.isSendLater.value)
              TextFieldDateX(
                key: const Key('Date'),
                titleBottomSheet:"Date and time of submission",
                label: "Date and time of dispatch",
                controller: controller.date,
                icon: IconX.date,
                hint: "-- Select the date and time to send --",
                color: context.isDarkMode ? null : Theme.of(context).cardColor,
                validate: ValidateX.date,
                onChange: controller.onChangeDate,
                initialDate: controller.sendLaterDate.value,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).paddingOnly(top: 8).fadeAnimation100,

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
