import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../Core/Controller/Create/addPaymentCardController.dart';
import '../../../../Core/core.dart';
import '../../../../UI/Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Enter bank card information and save it
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

addPaymentCardSheetX({required AddPaymentCardControllerX controller}) async {
  return await bottomSheetX(
    title: "Add a new card",
    child: Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoading.value,
        child: Column(
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

                  /// Default Card
                  SwitchX(
                    label: "Set as a default card",
                    value: controller.isDefault.value,
                    onChange: controller.onChangeDefault,
                  ).fadeAnimation400,
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// Save Button
            ButtonStateX(
              text: "Save the card",
              onTap: controller.onAddCard,
              state: controller.buttonState.value,
            ).fadeAnimation400,
          ],
        ),
      ),
    ),
  );
}
