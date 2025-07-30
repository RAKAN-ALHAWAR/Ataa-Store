import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/Pay/directZakatPaymentController.dart';
import '../../../../Core/core.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Paying Zakat directly, follow the Zakat main page
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

directZakatPaymentSheetX() {
  //============================================================================
  // Injection of required controls

  final DirectZakatPaymentControllerX controller = Get.find();

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Pay your Zakat with ease",
    child: Obx(
      () {
        /// Main Content
        return AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              /// Label of Zakat amount
              const LabelInputX(
                "The Amount",
                marginTop: 0,
              ).fadeAnimation300,

              /// Input Zakat amount
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: TextFieldX(
                  controller: controller.money,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  hint: "0",
                  validate: ValidateX.money,
                  suffixWidget: Icon(
                    IconX.sar,
                    size: 16,
                    color: Theme.of(Get.context!).colorScheme.secondary,
                  ),
                ),
              ).fadeAnimation300,
              const SizedBox(height: 8),
              const LabelInputX('Project').fadeAnimation400,

              Obx(
                    () => MultipleSelectionCardX(
                  title: controller.zakatSelectionController.optionSelected
                      .value?.donationBasic.name ??'',
                  onTap: controller.onTapZakatSelection,
                ),
              ).fadeAnimation400,
              const SizedBox(height: 14),

              /// Buttons
              Row(
                children: [
                  Flexible(
                    child: ButtonStateX(
                      state: controller.buttonState.value,
                      onTap: ()async=>await controller.onAddToCart(isPay:true),
                      text: "Pay Zakat Now",
                      iconData: Icons.payments_rounded,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: ButtonStateX.second(
                      state: controller.addToCartButtonState.value,
                      onTap: controller.onAddToCart,
                      text: "Add to cart",
                      iconData: Icons.shopping_cart_rounded,
                    ),
                  ),
                ],
              ).fadeAnimation400
            ],
          ),
        );
      },
    ),
  );
}
