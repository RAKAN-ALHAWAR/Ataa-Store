import 'package:ataa/Config/config.dart';
import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Data/data.dart';
import '../../../../Section/PreSavedPaymentCards/view/View.dart';
import '../../../../Widget/Basic/Utils/future_builder.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class DeductionPaymentView extends GetView<DeductionPaymentController> {
  const DeductionPaymentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(
        title: 'Complete the deduction process',
      ),
      body: SafeArea(
        child: FutureBuilderX(
          future: controller.getData,
          child: (data) => Obx(
            () => AbsorbPointer(
              absorbing: controller.isLoading.value,
              // || controller.appleAndGooglePayController.isLoading.value,
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
                          if (controller.error.value != null)
                            MessageCardX(
                                    isError: true,
                                    maxLine: 4,
                                    message: controller.error.value?.message,
                                    description: controller
                                        .error
                                        .value
                                        ?.details[NameX.errors]
                                            ?[NameX.description]
                                        ?.toString())
                                .fadeAnimation200
                                .marginOnly(bottom: 14),
                          ContainerX(
                            child: Column(
                              children: [
                                // if(controller.isShowAppleAndGooglePay)
                                // AppleAndGooglePaySectionX(
                                //   controller: controller.appleAndGooglePayController,
                                // ).marginOnly(bottom: 20).fadeAnimation200,
                                // if(controller.isShowPaymentCard && controller.isShowAppleAndGooglePay && controller.appleAndGooglePayController.error.value==null && controller.appleAndGooglePayController.initError.isFalse)
                                // /// The word "OR" is an element
                                //   Row(
                                //     children: [
                                //       const Flexible(child: Divider()),
                                //       Padding(
                                //         padding:
                                //         const EdgeInsets.symmetric(horizontal: 25),
                                //         child: TextX(
                                //           "OR",
                                //           fontWeight: FontWeight.w700,
                                //           color: ColorX.grey.shade400,
                                //         ),
                                //       ),
                                //       const Flexible(child: Divider()),
                                //     ],
                                //   ).marginOnly(bottom: 20).fadeAnimation200,
                                if (controller.isShowPaymentCard)
                                  PreSavedPaymentCardsSectionX(
                                    controller: controller
                                        .preSavedPaymentCardsController,
                                  ),
                                if (controller.isShowPaymentCard)
                                  ButtonStateX(
                                    disabled: !controller
                                        .preSavedPaymentCardsController
                                        .isValidate
                                        .value,
                                    onTap: controller.onPay,
                                    text: 'Confirm the deduction process',
                                    state: controller.buttonState.value,
                                  ).fadeAnimation400
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // if(controller.appleAndGooglePayController.isLoading.value)
                  //   const Positioned.fill(
                  //     child: BlurX(
                  //       blur: 2,
                  //       child: Center(child: CircularProgressIndicator()),
                  //     ),
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
