import 'dart:async';

import 'package:ataa/Data/Enum/rate_type_status.dart';
import 'package:ataa/Data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Model/PaymentTransaction/paymentTransaction.dart';
import '../../../../../Ui/Widget/widget.dart';

class PaymentSuccessfulController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  PaymentTransactionX paymentTransaction = Get.arguments;
  Rx<int?> rateSelected = Rx<int?>(null);
  RxBool isLoadingRate = false.obs;
  RxBool isLoadingAssign = false.obs;
  RxBool isDoneAssignPaymentTransaction = false.obs;
  late bool isCanAssignPayment = app.isLogin.isFalse;
  RxBool isRated = false.obs;
  TextEditingController rateComment = TextEditingController();
  Rx<ButtonStateEX> submitRatingButtonState = ButtonStateEX.normal.obs;

  //============================================================================
  // Functions

  onAuth({bool isLogin = true}) async {
    try {
      if (app.isLogin.isFalse) {
        if (isLogin) {
          await app.onLoginSheet();
        } else {
          await app.onSignUpSheet();
        }
      }
      // انتظر حتى يتم إغلاق جميع شاشات البوتم شيت المفتوحة
      while (Get.isBottomSheetOpen ?? false) {
        await Future.delayed(
          const Duration(milliseconds: 100),
        ); // إضافة تأخير بسيط للتحقق بشكل دوري
      }
      if (app.isLogin.isTrue) {
        await onAssign();
      }
    } catch (e) {
      ToastX.error(message: e);
    }
  }

  onAssign() async {
    try {
      if (app.isLogin.value) {
        isLoadingAssign.value = true;
        await DatabaseX.assignPaymentTransaction(
          paymentTransactionCode: paymentTransaction.code,
        );
        isLoadingAssign.value = false;
        isDoneAssignPaymentTransaction.value = true;
        await Future.delayed(const Duration(milliseconds: 1000));
        if (Get.isBottomSheetOpen == true) {
          Get.back();
        }
        await bottomSheetSuccessX(
          icon: Icons.check_rounded,
          title: "The donation has been successfully linked to your account",
          okText: "View my donations",
          cancelText: "Close",
          onOk: () => Get.offAndToNamed(RouteNameX.myDonations),
        );
      }
    } catch (e) {
      ToastX.error(message: e);
    }
    isLoadingAssign.value = false;
  }

  onSubmitRating() async {
    try {
      if (isLoadingRate.isFalse && isRated.isFalse) {
        isLoadingRate.value = true;
        submitRatingButtonState.value = ButtonStateEX.loading;

        await DatabaseX.rating(
          id: paymentTransaction.id,
          type: RateTypeStatusX.payment,
          rate: rateSelected.value!,
          comment: rateComment.text,
        );
        isRated.value = true;

        /// The time delay here is aesthetically beneficial
        submitRatingButtonState.value = ButtonStateEX.success;

        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );
        Get.back();
      }
    } catch (error) {
      ToastX.error(message: error.toString());
      submitRatingButtonState.value = ButtonStateEX.failed;
    }
    isLoadingRate.value = false;

    /// Reset the button state
    Timer(
      const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
      () {
        submitRatingButtonState.value = ButtonStateEX.normal;
      },
    );
  }
}
