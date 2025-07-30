import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/Pay/subscriptionDeductionController.dart';
import '../../../../Data/Enum/recurring_status.dart';
import '../../../../Data/Model/Deduction/deduction.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View the deduction details and subscribe to it
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

subscriptionDeductionSheetX(DeductionX deduction) {
  //============================================================================
  // Injection of required controls

  final SubscriptionDeductionControllerX controller = Get.put(
    SubscriptionDeductionControllerX(),
    tag: deduction.id,
  );
  controller.init(deduction);

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Subscribe to deduction",
    child: Obx(
      () {
        /// Mandatory login
        if (!controller.app.isLogin.value) {
          return Column(
            children: [
              const TextX(
                "Log in to participate in the deduction",
                fontWeight: FontWeight.w600,
              ).fadeAnimation200,
              const SizedBox(height: 16),
              ButtonX(
                onTap: controller.app.onLoginSheet,
                text: "Login",
              ).fadeAnimation300,
            ],
          );
        } else {
          /// Main Content
          return AbsorbPointer(
            absorbing: controller.isLoading.value,
            child: Column(
              children: [
                /// Display the fixed deduction value
                if (!deduction.isOpenPrice)
                  ContainerX(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: Get.theme.colorScheme.onSecondary,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        /// Title
                        TextX(
                          "Deduction amount",
                          color: Get.theme.primaryColor,
                        ),
                        const SizedBox(height: 6),

                        /// Fixed Deduction Amount
                        Row(
                          children: [
                            TextX(
                              controller.deduction.initialPrice.toString(),
                              style: TextStyleX.titleLarge,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(width: 6),
                            const Icon(
                              IconX.sar,
                              size: 16,
                            )
                          ],
                        )
                      ],
                    ),
                  ).fadeAnimation200,

                /// Enter the deduction amount manually
                if (deduction.isOpenPrice)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Free Deduction Options [ 20 , 50 , 100 ] SAR
                      FreeDonationOptionsX(
                        title:'Deduction amount',
                        isMarginTop: false,
                        onSelected: controller.onChangeDeductionAmount,
                        selected: controller.freeDeductionSelected.value,
                      ).fadeAnimation300,

                      /// Field to enter the deduction value
                      Form(
                        key: controller.formKey,
                        autovalidateMode: controller.autoValidate,
                        child: TextFieldX(
                          controller: controller.deductionAmount,
                          onChanged: controller.removeFreeDonationSelected,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          hint: "0",
                          validate: controller.validateAmount,
                          suffixWidget: Icon(
                            IconX.sar,
                            size: 16,
                            color: Theme.of(Get.context!).colorScheme.secondary,
                          ),
                        ),
                      ).fadeAnimation300,
                    ],
                  ),

                /// Alert message about deduction
                MessageCardX(
                  message: controller
                      .deduction.recurring.name ==
                      RecurringStatusX.monthly.name
                      ? 'The amount will be automatically deducted on the first day of every calendar month.'.tr
                      : '${'The amount is automatically deducted every'.tr} ${(deduction.recurring.name == RecurringStatusX.daily.name) ? '' : '${controller.deduction.day?.tr ?? controller.deduction.dayLocalized} ${'of each week.'.tr}'}',
                ).marginSymmetric(vertical: 11).fadeAnimation400,

                /// Subscription Button
                ButtonStateX(
                  state: controller.buttonState.value,
                  onTap: controller.onDeduction,
                  text: "Subscribe Now",
                  iconData: Icons.payments_rounded,
                ).fadeAnimation500
              ],
            ),
          );
        }
      },
    ),
  );
}
