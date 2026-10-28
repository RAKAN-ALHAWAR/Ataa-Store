import 'package:ataa/Core/Util/arabicDigitsFormatter.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../Config/config.dart';
import '../../../../Core/core.dart';
import '../../../Widget/widget.dart';
import '../controller/Controller.dart';

class PreSavedPaymentCardsSectionX extends StatelessWidget {
  PreSavedPaymentCardsSectionX({
    super.key,
    this.header,
    this.padding,
    PreSavedPaymentCardsController? controller,
  }) {
    this.controller = controller ?? Get.put(PreSavedPaymentCardsController());
  }
  final Widget? header;
  final EdgeInsets? padding;
  late final PreSavedPaymentCardsController controller;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(controller.paymentCards.isNotEmpty)
          const TextX(
            'Pre-saved cards',
            fontWeight: FontWeight.w700,
          ).fadeAnimation100.marginOnly(bottom: 12),
          for (var data in controller.paymentCards)
            RadioButtonX<String>(
              value: data.id,
              onChanged: (_) => controller.onChange(data),
              groupValue: controller.paymentCardSelected.value?.id,
              margin: const EdgeInsets.only(bottom: 8),
              color: Theme.of(context).cardTheme.color,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageNetworkX(
                        imageUrl: data.iconUrl ?? '',
                        width: 55,
                        height: 55,
                        failed: const Icon(
                          Icons.credit_card,
                          size: 55.0,
                          color: ColorX.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextX(
                            data.name,
                            style: TextStyleX.titleLarge,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(height: 4),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: TextX(
                              "****${data.last4Digits}",
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (data.isDefault)
                    TextX(
                      "Default",
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary,
                    ).paddingSymmetric(horizontal: 16),
                ],
              ),
            ).fadeAnimation200,
          if (controller.paymentCards.isNotEmpty)
            Divider(
              color: context.isDarkMode ? null : ColorX.grey.shade200,
            ).fadeAnimation300,
          if (controller.paymentCards.isNotEmpty)
            InkWell(
              onTap: controller.onChangeOpenAddNewCard,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outlined,
                      color: !controller.isAddNewCardOpen.value
                          ? Theme.of(context).primaryColor
                          : context.isDarkMode
                              ? Theme.of(context).colorScheme.secondary
                              : ColorX.grey.shade400,
                    ),
                    const SizedBox(width: 8),
                    TextX(
                      'Add a new card',
                      color: !controller.isAddNewCardOpen.value
                          ? Theme.of(context).primaryColor
                          : context.isDarkMode
                              ? Theme.of(context).colorScheme.secondary
                              : ColorX.grey.shade400,
                    ),
                  ],
                ),
              ),
            ).fadeAnimation400.marginOnly(bottom: 4),
          if (controller.isAddNewCardOpen.value ||
              controller.paymentCards.isEmpty)
            Column(
              children: [
                Form(
                  key: controller.formKey,
                  autovalidateMode: controller.autoValidate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name
                      TextFieldX(
                        label: "Name on the card",
                        hint: "name",
                        controller: controller.name,
                        validate: ValidateX.fullName,
                        textInputType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                      ).fadeAnimation200,
                      const SizedBox(height: 10),

                      /// Card number
                      CreditCardNumberFieldX(
                        label: "Card number",
                        hint: "5428 **** **** ****",
                        controller: controller.cardNum,
                        textInputAction: TextInputAction.next,
                      ).fadeAnimation200,
                      const SizedBox(height: 10),

                      /// Expiry Date & CVV
                      Row(
                        children: [
                          Flexible(
                            child: TextFieldX(
                              label: "Expiry Date",
                              hint: "MM/YY",
                              inputFormatters: [
                                const ArabicDigitsInputFormatter(),
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMonthInputFormatter()
                              ],
                              controller: controller.date,
                              validate: ValidateX.creditCardDate,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                            ).fadeAnimation300,
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextFieldX(
                              label: "CVV Verification Number",
                              hint: "123",
                              inputFormatters: [
                                const ArabicDigitsInputFormatter(),
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              controller: controller.cvv,
                              validate: ValidateX.cvv,
                              textInputType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                            ).fadeAnimation300,
                          ),
                        ],
                      ),

                      /// Save for later
                      SwitchX(
                        label: "Save for later",
                        value: controller.isSaveForLater.value,
                        onChange: controller.onChangeSaveForLater,
                      ).fadeAnimation400,
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
