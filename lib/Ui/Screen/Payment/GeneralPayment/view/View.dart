import 'package:ataa/Config/config.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:ataa/Ui/Section/AppleAndGooglePay/view/View.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Data/data.dart';
import '../../../../Section/PayByBankTransfer/view/View.dart';
import '../../../../Section/PreSavedPaymentCards/view/View.dart';
import '../../../../Widget/Basic/Utils/future_builder.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class GeneralPaymentView extends GetView<GeneralPaymentController> {
  const GeneralPaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(
        title: 'Completion of the payment process',
      ),
      body: SafeArea(
        child: FutureBuilderX(
          future: controller.getData,
          child: (data) => Obx(() {
            return AbsorbPointer(
              absorbing: controller.isLoading.value ||
                  controller.appleAndGooglePayController.isLoading.value,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.symmetric(
                        vertical: StyleX.vPaddingApp,
                        horizontal: StyleX.hPaddingApp,
                      ),
                      child: Column(
                        children: [
                          if (controller.error.value != null ||
                              controller.appleAndGooglePayController.error
                                      .value !=
                                  null)
                            MessageCardX(
                              isError: true,
                              maxLine: 4,
                              message: controller.error.value?.message ??
                                  controller.appleAndGooglePayController.error
                                      .value?.message,
                              description: controller
                                      .error
                                      .value
                                      ?.details[NameX.errors]
                                          ?[NameX.description]
                                      ?.toString() ??
                                  controller
                                      .appleAndGooglePayController
                                      .error
                                      .value
                                      ?.details[NameX.errors]
                                          ?[NameX.description]
                                      ?.toString(),
                            ).fadeAnimation200.marginOnly(bottom: 14),
                          ContainerX(
                            child: Column(
                              children: [
                                if (controller.isShowAppleAndGooglePay &&
                                    controller.appleAndGooglePayController
                                        .initError.isFalse)
                                  AppleAndGooglePaySectionX(
                                    controller:
                                        controller.appleAndGooglePayController,
                                  ).marginOnly(bottom: 20).fadeAnimation200,
                                if ((controller.isShowBank ||
                                        controller.isShowPaymentCard) &&
                                    controller.isShowAppleAndGooglePay &&
                                    controller.appleAndGooglePayController
                                        .initError.isFalse)

                                  /// The word "OR" is an element
                                  Row(
                                    children: [
                                      const Flexible(child: Divider()),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: TextX(
                                          "OR",
                                          fontWeight: FontWeight.w700,
                                          color: ColorX.grey.shade400,
                                        ),
                                      ),
                                      const Flexible(child: Divider()),
                                    ],
                                  ).marginOnly(bottom: 20).fadeAnimation200,
                                if (controller.isShowBank &&
                                    controller.isShowPaymentCard)
                                  TabSegmentX(
                                    controller: controller.payVia,
                                    tabs: {
                                      1: 'Pay by card'.tr,
                                      2: 'Pay by bank transfer'.tr,
                                    },
                                  ).marginOnly(bottom: 16).fadeAnimation300,
                                if (controller.isViaCard.value &&
                                    controller.isShowPaymentCard)
                                  PreSavedPaymentCardsSectionX(
                                    controller: controller
                                        .preSavedPaymentCardsController,
                                  ),
                                if (!controller.isViaCard.value &&
                                    controller.isShowBank)
                                  PayByBankTransferSectionX(
                                    controller:
                                        controller.payByBankTransferController,
                                  ),
                                if (controller.isShowBank ||
                                    controller.isShowPaymentCard)
                                  ButtonStateX(
                                    disabled: controller.isViaCard.value
                                        ? !controller
                                            .preSavedPaymentCardsController
                                            .isValidate
                                            .value
                                        : !controller
                                            .payByBankTransferController
                                            .isValidate
                                            .value,
                                    onTap: controller.onPay,
                                    state: controller.buttonState.value,
                                    text: 'Completing the payment process',
                                  ).fadeAnimation400
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.appleAndGooglePayController.isLoading.value)
                    const Positioned.fill(
                      child: BlurX(
                        blur: 2,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
