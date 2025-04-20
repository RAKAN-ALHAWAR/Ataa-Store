import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/Other/editCampaignController.dart';
import '../../../../Core/core.dart';
import '../../../../Data/data.dart';
import '../../../Widget/widget.dart';
import '../../Selection/Donation/donationSelectionSheet.dart';

editCampaignSheet(CampaignX campaign) {
  //============================================================================
  // Injection of required controls

  final EditCampaignControllerX controller = Get.put(
    EditCampaignControllerX(),
    tag: campaign.id,
  )
    ..campaign = campaign
    ..init();

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Edit campaign",
    child: Obx(
      () {
        /// Main Content
        return AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: Column(
            children: [
              /// Title
              Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: TextFieldX(
                  label: "Your campaign title",
                  controller: controller.title,
                  hint: "title",
                  validate: ValidateX.campaignTitle,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  maxLength: 50,
                ).fadeAnimation200,
              ),
              const SizedBox(height: 6),

              /// Project
              const LabelInputX("Project").fadeAnimation300,
              MultipleSelectionCardX(
                asInputField: true,
                icon: Iconsax.arrow_down_1,
                title: "-- Choose project --",
                onTap: () => donationSelectionSheetX(
                  controller: controller.donationSelectionController,
                ),
                selected: controller.donationSelectionController
                    .donationSelected.value?.donationBasic.name,
              ).fadeAnimation300,

              if (controller
                      .donationSelectionController.donationSelected.value !=
                  null)
                InkWell(
                  onTap: () => Get.toNamed(
                    RouteNameX.donationDetails,
                    arguments: controller.donationSelectionController
                        .donationSelected.value!.donationBasic.code,
                  ),
                  child: ContainerX(
                    isBorder: true,
                    margin: const EdgeInsets.only(top: 14),
                    color: Theme.of(Get.context!).cardTheme.color,
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        ImageNetworkX(
                          imageUrl: controller
                                  .donationSelectionController
                                  .donationSelected
                                  .value!
                                  .donationDetails
                                  .imageUrl ??
                              '',
                          width: 90,
                          height: 90,
                        ),
                        Flexible(
                          child: Container(
                            height: 90,
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextX(
                                  controller
                                      .donationSelectionController
                                      .donationSelected
                                      .value!
                                      .donationBasic
                                      .name,
                                  fontWeight: FontWeight.w600,
                                  style: TextStyleX.titleSmall,
                                ),
                                const Spacer(),
                                TextX(
                                  "${"Collected".tr} ${controller.donationSelectionController.donationSelected.value!.donationBasic.completionRate % 1 == 0 ? controller.donationSelectionController.donationSelected.value!.donationBasic.completionRate.toInt().toString() : controller.donationSelectionController.donationSelected.value!.donationBasic.completionRate.toStringAsFixed(2)}%",
                                  fontWeight: FontWeight.w500,
                                  style: TextStyleX.titleSmall,
                                  color: Get.theme.primaryColor,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Flexible(
                                      child: LinearProgressIndicator(
                                        value: controller
                                                .donationSelectionController
                                                .donationSelected
                                                .value!
                                                .donationBasic
                                                .currentDonations /
                                            controller
                                                .donationSelectionController
                                                .donationSelected
                                                .value!
                                                .donationBasic
                                                .totalDonations,
                                        borderRadius: BorderRadius.circular(50),
                                        minHeight: 10,
                                      ),
                                    ),
                                    const SizedBox(width: 60),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ).fadeAnimation200,
                ),

              const SizedBox(height: 14),

              /// Target amount
              DropdownX(
                title: 'Target amount',
                hint: "-- Choose target amount --",
                value: controller.targetAmount.value,
                list: controller.app.generalSettings.campaignTargetAmounts,
                onChanged: (val) {
                  controller.targetAmount.value = val;
                },
                valueWidget: (val) => Row(
                  children: [
                    TextX(
                      FunctionX.formatLargeNumber(val),
                      style: TextStyleX.titleSmall,
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      IconX.sar,
                      color: Theme.of(Get.context!).colorScheme.secondary,
                      size: 14,
                    ),
                  ],
                ),
              ).fadeAnimation400,

              const SizedBox(
                height: 10,
              ),

              /// Button
              Row(
                children: [
                  Flexible(
                    child: ButtonStateX(
                      state: controller.buttonState.value,
                      text: "Save changes",
                      onTap: controller.onEdit,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: ButtonX.gray(
                      text: "Cancel",
                      onTap: Get.back,
                    ),
                  ),
                ],
              ).fadeAnimation500,
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    ),
  );
}
