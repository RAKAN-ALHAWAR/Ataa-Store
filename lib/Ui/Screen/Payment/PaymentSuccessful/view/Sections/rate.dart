import 'package:ataa/Config/config.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class RateSection extends GetView<PaymentSuccessfulController> {
  const RateSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AbsorbPointer(
        absorbing: controller.isLoadingRate.value || controller.isRated.value,
        child: Column(
          children: [
            TextX(
              'How would you rate the donation process?',
              style: TextStyleX.titleLarge,
              color: Theme.of(context).primaryColor,
              textAlign: TextAlign.center,
            ).fadeAnimation400,
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FittedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => controller.rateSelected.value = 5,
                      child: Opacity(
                        opacity: controller.rateSelected.value == 5 ? 1 : context.isDarkMode? 0.6: 0.4,
                        child: Column(
                          children: [
                            Image.asset(ImageX.excellent, width: 37),
                            const SizedBox(height: 4),
                            const TextX('Excellent')
                          ],
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 10),
                    GestureDetector(
                      onTap: () => controller.rateSelected.value = 4,
                      child: Opacity(
                        opacity: controller.rateSelected.value == 4 ? 1 : context.isDarkMode? 0.6: 0.4,
                        child: Column(
                          children: [
                            Image.asset(ImageX.good, width: 37),
                            const SizedBox(height: 4),
                            const TextX('Good')
                          ],
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 10),
                    GestureDetector(
                      onTap: () => controller.rateSelected.value = 3,
                      child: Opacity(
                        opacity: controller.rateSelected.value == 3 ? 1 : context.isDarkMode? 0.6: 0.4,
                        child: Column(
                          children: [
                            Image.asset(ImageX.average, width: 37),
                            const SizedBox(height: 4),
                            const TextX('Average')
                          ],
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 10),
                    GestureDetector(
                      onTap: () => controller.rateSelected.value = 2,
                      child: Opacity(
                        opacity: controller.rateSelected.value == 2 ? 1 : context.isDarkMode? 0.6: 0.4,
                        child: Column(
                          children: [
                            Image.asset(ImageX.poor, width: 37),
                            const SizedBox(height: 4),
                            const TextX('Poor')
                          ],
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 10),
                    GestureDetector(
                      onTap: () => controller.rateSelected.value = 1,
                      child: Opacity(
                        opacity: controller.rateSelected.value == 1 ? 1 : context.isDarkMode? 0.6: 0.4,
                        child: Column(
                          children: [
                            Image.asset(ImageX.bad, width: 37),
                            const SizedBox(height: 4),
                            const TextX('Bad')
                          ],
                        ),
                      ),
                    ).paddingSymmetric(horizontal: 10),
                  ],
                ).fadeAnimation400,
              ),
            ),
            if (controller.rateSelected.value != null)
              Column(
                children: [
                  const SizedBox(height: 30),
                  const TextX(
                    'Thank you for your rating, can you tell us more?',
                    fontWeight: FontWeight.w600,
                  ).fadeAnimation200,
                  const SizedBox(height: 9),
                  Form(
                    child: TextFieldX(
                      controller: controller.rateComment,
                      minLines: 3,
                    ),
                  ).fadeAnimation250,
                  const SizedBox(height: 8),
                  ButtonStateX(
                    text: 'Submit rating',
                    state: controller.submitRatingButtonState.value,
                    marginVertical: 0,
                    onTap: controller.onSubmitRating,
                  ).fadeAnimation300,
                ],
              ),
          ],
        ),
      ),
    );
  }
}
