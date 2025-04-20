import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../ScreenSheet/Selection/Donation/donationSelectionSheet.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class CreateCampaignView extends GetView<CreateCampaignController> {
  const CreateCampaignView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Create a campaign",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: StyleX.hPaddingApp,
              vertical: StyleX.vPaddingApp,
            ),
            child: AbsorbPointer(
              absorbing: controller.isLoading.value,

              /// Card
              child: ContainerX(
                color: Theme.of(context).cardColor,
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

                    if (controller.donationSelectionController.donationSelected
                            .value !=
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
                          color: Theme.of(context).cardTheme.color,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              borderRadius:
                                                  BorderRadius.circular(50),
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
                      list:
                          controller.app.generalSettings.campaignTargetAmounts,
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
                            color: Theme.of(context).colorScheme.secondary,
                            size: 14,
                          ),
                      ],),
                    ).fadeAnimation400,

                    const SizedBox(height: 10),

                    /// Agree to the terms
                    SwitchX(
                      value: controller.isAgreed.value,
                      onChange: controller.onChangeAgreed,
                      isSmallTitle: true,
                      isFittedTitle: false,
                      label:
                          "I agree that the donations I will collect will be spent by the Ataa platform for the project identified in this campaign.",
                    ).fadeAnimation500,
                    const SizedBox(
                      height: 10,
                    ),

                    /// Button
                    ButtonStateX(
                      disabled: !controller.isAgreed.value,
                      colorDisabledButton: context.isDarkMode
                          ? ColorX.primary.shade300.withOpacity(0.2)
                          : ColorX.primary.withOpacity(0.4),
                      colorDisabledBorder: Colors.transparent,
                      colorDisabledText:
                          context.isDarkMode ? Colors.white38 : Colors.white,
                      state: controller.buttonState.value,
                      text: "Next",
                      onTap: controller.onCreate,
                    ).fadeAnimation600
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
