import 'dart:async';
import 'dart:io';
import 'package:ataa/Core/Error/error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/SelectedOptions/quickDonationSelectionController.dart';
import '../../../../Core/core.dart';
import '../../../../Data/Enum/payment_method_status.dart';
import '../../../../Data/Model/PaymentTransaction/paymentTransaction.dart';
import '../../../../Data/Model/PaymentTransaction/paymentTransactionForm.dart';
import '../../../../Data/data.dart';
import '../../../../Ui/Widget/widget.dart';
import '../../../ScreenSheet/Selection/Donation/quickDonationSelectionSheet.dart';
import '../../../Section/AppleAndGooglePay/controller/Controller.dart';

class QuickDonationController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  QuickDonationSelectionController quickDonationSelectionController = Get.put(
    QuickDonationSelectionController(),
    tag: "Quick Donation",
  );
  late final AppleAndGooglePayController appleAndGooglePayController = Get.put(
    AppleAndGooglePayController()
      ..onPayDoneCallback = onPayByAppleOrGoogle
      ..isDisabled.value = true
      ..onTapDisabledCallback = onTapDisabledAppleAndGooglePay,
    tag: 'QuickDonation-AppleAndGooglePay',
  );

  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  bool isInit = false;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  List<OrganizationX> organizations = [];
  RxInt freeDonationSelected = 0.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  TextEditingController donationAmount = TextEditingController();

  //============================================================================
  // Functions

  Future init() async {
    if (!isInit) {
      await appleAndGooglePayController.init(
        total: 0,
      );
      isInit = true;
    }
  }

  String? validateAmount(String? val) {
    String? message;
    message = ValidateX.money(val);

    /// Verify the lowest possible donation value in Free Donation
    if (message == null &&
        num.parse(donationAmount.text) <
            app.generalSettings.minimumDonationAmount) {
      message =
          "${"The minimum donation amount is".tr} ${app.generalSettings.minimumDonationAmount} ${"SAR".tr}";
    }
    return message;
  }

  get isShowAppleAndGooglePay =>(Platform.isAndroid && app.generalPaymentMethodsSettings.isGooglePay) || (Platform.isIOS && app.generalPaymentMethodsSettings.isApplePay);

  onTapDisabledAppleAndGooglePay() {
    try {
      dataVerification();
    } catch (error) {
      ToastX.error(message: error.toString());
    }
  }
  //----------------------------------------------------------------------------
  // Other

  onChangeDonationAmount(int val) {
    donationAmount.text = val.toString();
    freeDonationSelected.value = val;
    appleAndGooglePayController.isDisabled.value = !isDataVerification();
    appleAndGooglePayController.createPaymentItems(freeDonationSelected.value + 0.0);
  }

  removeFreeDonationSelected(String val) {
    if (int.tryParse(val) != null) {
      freeDonationSelected.value = int.parse(val);
      appleAndGooglePayController.createPaymentItems(freeDonationSelected.value + 0.0);
    }
    appleAndGooglePayController.isDisabled.value = !isDataVerification();
  }

  onTapChooseDonationProject() async {
    await quickDonationSelectionSheetX(quickDonationSelectionController);
    appleAndGooglePayController.isDisabled.value = !isDataVerification();
  }

  //----------------------------------------------------------------------------
  // Data processing

  /// Erase all data and return it to its default state
  clearData() {
    donationAmount.text = '';
    freeDonationSelected.value = 0;
    autoValidate = AutovalidateMode.disabled;
    quickDonationSelectionController.selected.value = null;
    appleAndGooglePayController.isDisabled.value = true;
    appleAndGooglePayController.paymentItems.value = [];
  }

  /// Verify the entered data
  dataVerification() {
    if (!formKey.currentState!.validate()) {
      // check input fields
      autoValidate = AutovalidateMode.always;
      throw "Make sure you enter a valid value in donation amount";
    }
    if (quickDonationSelectionController.selected.value == null && app.generalSettings.defaultQuickDonation==null) {
      throw "You must choose one of the donations";
    }
  }

  isDataVerification() {
    if (validateAmount(donationAmount.text)!=null || (quickDonationSelectionController.selected.value == null && app.generalSettings.defaultQuickDonation==null)) {
      return false;
    } else {
      return true;
    }
  }

  // ----------------------------------------------------------------------------
  // Main processors

  onPayByAppleOrGoogle(String token) async {
    try {
      PaymentTransactionFormX form = PaymentTransactionFormX(
        price: double.parse(donationAmount.text),
        paymentMethod: Platform.isIOS
            ? PaymentMethodStatusX.applePay
            : PaymentMethodStatusX.googlePay,
        applePayToken: Platform.isIOS ? token : null,
        googlePayToken: Platform.isIOS ? null : token,
      );
      await sendPayToServer(form: form);
    } catch (error) {
      error.toErrorX.log();
      ToastX.error(message: error.toString());
    }
  }

  sendPayToServer({required PaymentTransactionFormX form}) async {
    PaymentTransactionX paymentTransaction =
        await DatabaseX.createPaymentTransactionForQuickDonation(
      form: form,
      projectId: quickDonationSelectionController.selected.value!=null?quickDonationSelectionController.selected.value!.id:app.generalSettings.defaultQuickDonation!.id,
    );

    /// Clear date on controller
    clearData();

    /// Close the bottom sheet
    Get.back();

    Get.toNamed(
      RouteNameX.paymentSuccessful,
      arguments: paymentTransaction,
    );
  }

  onDonatingByApp() async {
    if (isLoading.isFalse) {
      isLoading.value = true;
      try {
        /// check is validate data
        await dataVerification();

        /// Close the bottom sheet
        Get.back();

        await Get.toNamed(
          RouteNameX.generalPayment,
          arguments: {
            NameX.amount: double.parse(donationAmount.text),
            NameX.orgId: quickDonationSelectionController.selected.value!=null?quickDonationSelectionController.selected.value!.id:app.generalSettings.defaultQuickDonation!.id,
          },
        );

        /// clear date on controller
        clearData();
      } catch (error) {
        ToastX.error(message: error.toString());
        buttonState.value = ButtonStateEX.failed;
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          buttonState.value = ButtonStateEX.normal;
        },
      );
    }
  }
}
