import 'dart:async';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/gender_status.dart';
import 'package:ataa/Data/Enum/gift_color_status.dart';
import 'package:ataa/Data/Model/Gift/Subclass/giftBasic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Cart/cartGeneralController.dart';
import '../../../../../Core/Controller/Other/previewDedicateController.dart';
import '../../../../../Core/Error/error.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Enum/model_type_status.dart';
import '../../../../../Data/Model/Gift/Subclass/giftCardFormByGender.dart';
import '../../../../../Data/Model/Gift/Subclass/giftCategory.dart';
import '../../../../../Data/Model/Gift/gift.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../ScreenSheet/Other/PreviewGiftCard/previewGiftCardSheet.dart';

class CreateGiftController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();
  final CartGeneralControllerX basketController = Get.find();
  final CartGeneralControllerX cart = Get.find();
  PreviewGiftCardControllerX previewGiftCardController = Get.put(
    PreviewGiftCardControllerX(),
  );

  //============================================================================
  // Variables

  /// Loading
  RxBool isLoading = false.obs;
  RxBool isLoadingForGetGiftCategoryDetails = false.obs;
  Rx<ButtonStateEX> addToCartButtonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> payButtonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> previewButtonState = ButtonStateEX.normal.obs;

  /// Data
  final List<String> colors = GiftColorStatusX.values
      .map((e) => e.code.substring(1))
      .toList();
  RxList<GiftCategoryX> giftCategories = <GiftCategoryX>[].obs;
  RxList<OrganizationX> organizations = <OrganizationX>[].obs;

  /// Input
  GlobalKey<FormState> formKeyDonationAmount = GlobalKey();
  AutovalidateMode autoValidateDonationAmount = AutovalidateMode.disabled;
  GlobalKey<FormState> formKeyPhoneSendToMe = GlobalKey();
  AutovalidateMode autoValidatePhoneSendToMe = AutovalidateMode.disabled;
  GlobalKey<FormState> formKeyForDedicatesData = GlobalKey();
  AutovalidateMode autoValidateForDedicatesData = AutovalidateMode.disabled;
  TextEditingController donationAmount = TextEditingController();
  TextEditingController date = TextEditingController();

  /// Options
  RxBool isShowAmount = false.obs;

  RxBool isSendToMe = false.obs;
  late TextEditingController phoneSendToMe = TextEditingController(
    text: (app.user.value?.phone ?? '').toString(),
  );
  late int countryCodeForSendToMe =
      app.user.value?.countryCode ?? app.generalSettings.defaultCountryCode;

  RxBool isSendLater = false.obs;
  Rx<DateTime?> sendLaterDate = Rx<DateTime?>(null);

  /// Selected
  RxInt colorSelectedIndex = 0.obs;
  Rx<GiftCategoryX?> giftCategorySelected = Rx(null);
  Rx<GiftCardFormByGenderX?> giftCardFormByGenderSelected = Rx(null);
  Rx<OrganizationX?> orgSelected = Rx(null);
  RxInt freeDonationSelected = 0.obs;
  Rx<String> gender = "male".obs;
  late RxInt recipientCountryCode =
      (app.generalSettings.defaultCountryCode).obs;

  /// For Card
  RxString donorNameForCard = ''.obs;
  RxString recipientNameForCard = ''.obs;
  RxString donationAmountForCard = ''.obs;

  /// init
  final FlutterNativeContactPicker contactPicker = FlutterNativeContactPicker();

  /// The name Mahdi is fetched through the username
  late TextEditingController donorName = TextEditingController();
  TextEditingController recipientName = TextEditingController();
  TextEditingController recipientPhone = TextEditingController();

  //============================================================================
  // Functions

  Future<void> getData() async {
    try {
      giftCategories.value = await DatabaseX.getAllGiftCategories();
      if (giftCategories.isNotEmpty) {
        giftCategorySelected.value = giftCategories.first;
        await getGiftCategoryDetails(giftCategories.first.id);
      }
    } catch (e) {
      rethrow;
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

  Future<List<GiftCategoryX>> getGiftCategories(
    ScrollRefreshLoadMoreParametersX data,
  ) async {
    return await DatabaseX.getAllGiftCategories(
      page: data.page,
      perPage: data.perPage,
    );
  }

  getGiftCategoryDetails(String id) async {
    isLoadingForGetGiftCategoryDetails.value = true;
    giftCategorySelected.value = await DatabaseX.getGiftCategoryDetails(id: id);
    organizations.value = giftCategorySelected.value?.donationCategories ?? [];
    orgSelected.value = null;
    isLoadingForGetGiftCategoryDetails.value = false;
    onChangeGiftCardFormByGender();
  }

  //----------------------------------------------------------------------------
  // Change

  onChangeGiftCardFormByGender() {
    giftCardFormByGenderSelected.value = gender.value == 'male'
        ? giftCategorySelected.value?.giftCardFormMale
        : giftCategorySelected.value?.giftCardFormFemale;
  }

  onChangeCategory(index) {
    giftCategorySelected.value = giftCategories[index];
    getGiftCategoryDetails(giftCategorySelected.value?.id ?? '');
  }

  onChangeColor(index) => colorSelectedIndex.value = index;
  onChangeOrg(index) {
    orgSelected.value = organizations[index];
  }

  onChangeShowAmount(bool val) => isShowAmount.value = val;
  onChangeSendToMe(bool val) => isSendToMe.value = val;
  onChangeSendLater(bool val) => isSendLater.value = val;
  onChangeDate(DateTime? date) => sendLaterDate.value = date;
  onChangeDonationAmount(int val) {
    donationAmount.text = val.toString();
    freeDonationSelected.value = val;
  }

  onChangeAmountForFreeDonationSelected(val) {
    if (int.tryParse(val) != null) {
      freeDonationSelected.value = int.parse(val);
    }
  }

  onChangeGender(String? value) {
    gender.value = value!;
    onChangeGiftCardFormByGender();
  }

  onChangeCountryCode(String val) {
    final newCode = int.parse(val);
    if (!app.generalSettings.isShowCountryCodeList &&
        newCode != app.generalSettings.defaultCountryCode) {
      ToastX.error(message: "Changing the country code is not allowed".tr);
      recipientCountryCode.value = app.generalSettings.defaultCountryCode;
      return;
    }
    recipientCountryCode.value = newCode;
  }

  onChangeCountryCodeForSendToMe(String val) {
    final newCode = int.parse(val);
    if (!app.generalSettings.isShowCountryCodeList &&
        newCode != app.generalSettings.defaultCountryCode) {
      ToastX.error(message: "Changing the country code is not allowed".tr);
      countryCodeForSendToMe = app.generalSettings.defaultCountryCode;
      return;
    }
    countryCodeForSendToMe = newCode;
  }

  //----------------------------------------------------------------------------
  // Phone From Contacts

  /// Get the Mahdi's information from his contacts
  onPhoneFromContacts() async {
    try {
      Contact? contact = await contactPicker.selectContact();
      if (contact != null) {
        /// If name is empty, it returns the previous value
        recipientName.text = contact.fullName ?? recipientName.text;

        /// To check if there is a phone number and then check if this number is empty or not
        if (contact.phoneNumbers != null && contact.phoneNumbers!.isNotEmpty) {
          /// Separate the phone number from the country code
          var result = FunctionX.extractCountryCodeAndPhoneNumber(
            contact.phoneNumbers![0],
          );

          final phoneNumber = result.$1;
          final extractedCode = result.$2;

          if (!app.generalSettings.isShowCountryCodeList) {
            /// Country code is locked
            if (extractedCode != null &&
                extractedCode != app.generalSettings.defaultCountryCode) {
              /// Extracted country code differs from default
              ToastX.error(
                  message: "Changing the country code is not allowed".tr);
              return;
            }

            /// Validate number format for Saudi (default 966)
            if (app.generalSettings.defaultCountryCode == 966 &&
                !(phoneNumber.startsWith('05') ||
                    phoneNumber.startsWith('5'))) {
              ToastX.error(
                  message: "Enter a Saudi Arabian phone number".tr);
              return;
            }
          }

          recipientPhone.text = phoneNumber;
          recipientCountryCode.value =
              extractedCode ?? recipientCountryCode.value;
        }
      }
    } catch (e) {
      return Future.error(e);
    }
  }
  //----------------------------------------------------------------------------
  // Auxiliary functions

  /// Erase all data and return it to its default state
  clearData() {
    donationAmount.text = "";
    date.text = "";
    recipientName.text = "";
    recipientPhone.text = "";
    isShowAmount.value = false;
    isSendToMe.value = false;
    isSendLater.value = false;
    sendLaterDate.value = null;
    freeDonationSelected.value = 0;

    giftCategorySelected.value = giftCategories.first;
    colorSelectedIndex.value = 0;
    orgSelected.value = null;
    autoValidateDonationAmount = AutovalidateMode.disabled;
    update();
  }

  /// Verify the entered data
  bool dataVerification({bool isPreview = false}) {
    if (orgSelected.value == null) {
      return throw "You must choose the field of donation";
    } else if (!formKeyForDedicatesData.currentState!.validate()) {
      autoValidateForDedicatesData = AutovalidateMode.always;
      return throw "There is an error in the gift data, please check the fields";
    } else if (!(formKeyDonationAmount.currentState?.validate() ?? false)) {
      autoValidateDonationAmount = AutovalidateMode.always;
      return throw "Make sure you enter a valid value in donation amount";
    } else if (!isPreview &&
        isSendToMe.isTrue &&
        !formKeyPhoneSendToMe.currentState!.validate()) {
      autoValidatePhoneSendToMe = AutovalidateMode.always;
      return throw "You must enter a phone number in the designated phone field to send a copy to your mobile.";
    } else if (!isPreview && isSendLater.value && sendLaterDate.value == null) {
      return throw "You must enter the date the gift was sent";
    } else if (giftCategorySelected.value == null) {
      return throw "You must choose the type of gift.";
    } else {
      return true;
    }
  }

  //----------------------------------------------------------------------------
  // Main processors

  onAddToCart({bool isPay = false}) async {
    if (isLoading.isFalse) {
      try {
        if (dataVerification()) {
          isLoading.value = true;
          isPay
              ? payButtonState.value = ButtonStateEX.loading
              : addToCartButtonState.value = ButtonStateEX.loading;

          try {
            GiftX gift = GiftX(
              isShowAmount: isShowAmount.value,
              isSendToMe: isSendToMe.value,
              isSendLater: isSendLater.value,
              giftCategoryId: giftCategorySelected.value!.id,
              donationCategoryId: orgSelected.value!.id,
              sendLaterDate: sendLaterDate.value,
              giftBasic: GiftBasicX(
                donorName: donorName.text,
                donorMobile: isSendToMe.value
                    ? int.parse(
                        countryCodeForSendToMe.toString() + phoneSendToMe.text,
                      )
                    : null,
                recipientName: recipientName.text,
                recipientMobile: int.parse(
                  recipientCountryCode.value.toString() + recipientPhone.text,
                ),
                recipientGender: GenderStatusX.values.firstWhere(
                  (x) => x.name == gender.value,
                ),
                price: donationAmount.text.toIntX,
                color: GiftColorStatusX.values.firstWhere(
                  (x) => x.code == '#${colors[colorSelectedIndex.value]}',
                ),
              ),
            );

            var data = await DatabaseX.createGiftOrder(gift: gift);

            String message = await cart.addItem(
              modelId: data.modelId,
              modelType: ModelTypeStatusX.gift,
              price: donationAmount.text.toIntX,
              isPayNow: isPay,
            );

            /// The time delay here is aesthetically beneficial
            isPay
                ? payButtonState.value = ButtonStateEX.success
                : addToCartButtonState.value = ButtonStateEX.success;

            await Future.delayed(
              const Duration(seconds: StyleX.successButtonSecond),
            );

            /// This controller form bottom sheet
            if (!isPay) {
              ToastX.success(message: message);
            }

            /// Clear date on controller
            clearData();
          } catch (error) {
            error.toErrorX.log();
            ToastX.error(message: error.toString());
            isPay
                ? payButtonState.value = ButtonStateEX.failed
                : addToCartButtonState.value = ButtonStateEX.failed;
          }
          isLoading.value = false;

          /// Reset the button state
          Timer(
            const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
            () {
              addToCartButtonState.value = ButtonStateEX.normal;
              payButtonState.value = ButtonStateEX.normal;
            },
          );
        }
      } catch (e) {
        ToastX.error(message: e.toString());
      }
    }
  }

  onPreviewGift() async {
    if (isLoading.isFalse) {
      try {
        if (dataVerification(isPreview: true)) {
          isLoading.value = true;
          previewGiftCardController.nameFrom = donorNameForCard.value;
          previewGiftCardController.nameTo = recipientNameForCard.value;
          previewGiftCardController.amount = donationAmountForCard.value;
          previewGiftCardController.isShowAmount = isShowAmount.value;
          previewGiftCardController.orgName = orgSelected.value!.name;
          previewGiftCardController.color = Color(
            int.parse("0xff${colors[colorSelectedIndex.value]}"),
          );
          previewGiftCardController.giftCardFormByGender =
              giftCardFormByGenderSelected.value!;
          await previewGiftCardSheetX(controller: previewGiftCardController);
        }
      } catch (error) {
        ToastX.error(message: error.toString());
        previewButtonState.value = ButtonStateEX.failed;
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          previewButtonState.value = ButtonStateEX.normal;
        },
      );
    }
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    donorName.text = app.isLogin.value ? app.user.value!.name : "";
    donorNameForCard.value = donorName.text;
    donorName.addListener(() => donorNameForCard.value = donorName.text);
    recipientName.addListener(
      () => recipientNameForCard.value = recipientName.text,
    );
    donationAmount.addListener(
      () => donationAmountForCard.value = donationAmount.text,
    );
    super.onInit();
  }

  @override
  void dispose() {
    donorName.dispose();
    recipientName.dispose();
    donationAmount.dispose();
    super.dispose();
  }
}
