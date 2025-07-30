import 'package:ataa/Config/config.dart';
import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class AssignPaymentTransactionSection
    extends GetView<PaymentSuccessfulController> {
  const AssignPaymentTransactionSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.app.isLogin.isFalse) {
          return RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: "${'You can'.tr} ",
              style: TextStyleX.titleMedium.copyWith(color: Get.iconColor,fontFamily: FontX.fontFamily),
              children: <TextSpan>[
                TextSpan(
                  text: 'create an account'.tr,
                  style: TextStyleX.titleMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async => await controller.onAuth(isLogin: false),
                ),
                TextSpan(
                  text: ' ${'or'.tr} ',
                  style: TextStyleX.titleMedium,
                ),
                TextSpan(
                  text: 'login'.tr,
                  style: TextStyleX.titleMedium.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = controller.onAuth,
                ),
                TextSpan(
                  text: ' ${'to link this donation to your account'.tr}',
                  style: TextStyleX.titleMedium,
                ),
              ],
            ),
          ).fadeAnimation300.marginOnly(top: 20);
        } else if (controller.isLoadingAssign.value) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextX(
                'Linking the payment process to your account',
                textAlign: TextAlign.center,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: 16),
              const SizedBox(
                height: 18,
                width: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ],
          ).fadeAnimation200.marginOnly(top: 20).paddingSymmetric(vertical: 15);
        } else if (controller.isCanAssignPayment &&
            controller.isDoneAssignPaymentTransaction.isFalse) {
          return GestureDetector(
            onTap: controller.onAssign,
            child: ContainerX(
              isBorder: true,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
              child:  TextX(
                'Click to retry linking the payment process to your account',
                textAlign: TextAlign.center,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ).fadeAnimation200.marginOnly(top: 20);
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
