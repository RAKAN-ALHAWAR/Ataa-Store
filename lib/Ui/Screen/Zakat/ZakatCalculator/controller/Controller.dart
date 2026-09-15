import 'dart:async';
import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/metal_karat_status.dart';
import 'package:ataa/Data/Enum/zakat_calculation_type_status.dart';
import 'package:ataa/Data/Model/ZakatCalculation/zakatCalculationForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Cart/cartGeneralController.dart';
import '../../../../../Core/Controller/SelectedOptions/zakatSelectionController.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Enum/model_type_status.dart';
import '../../../../../Data/Model/Donation/Order/donationOrderForm.dart';
import '../../../../../Data/Model/ZakatCalculation/Subclass/zakatCalculationGold.dart';
import '../../../../../Data/Model/ZakatCalculation/Subclass/zakatCalculationShares.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../ScreenSheet/Selection/Zakat/zakatSelectionSheet.dart';

class ZakatCalculatorController extends GetxController {
  ///============================================================================
  /// Injection of required controls

  final AppControllerX app = Get.find();
  final ZakatSelectionControllerX zakatSelectionController =
      Get.put(ZakatSelectionControllerX(), tag: 'ZakatCalculator');
  final CartGeneralControllerX cart = Get.find();

  ///============================================================================
  /// Variables

  //----------------------------------------------------------------------------
  // Processing and validation

  RxBool isPayOrCartLoading = false.obs;
  Rx<ButtonStateEX> payButtonState = ButtonStateEX.normal.obs;
  Rx<ButtonStateEX> addToCartButtonState = ButtonStateEX.normal.obs;
  RxBool isFocusAdditionalAmount = false.obs;

  GlobalKey<FormState> cashFormKey = GlobalKey();
  GlobalKey<FormState> goldFormKey = GlobalKey();
  AutovalidateMode goldAutoValidate = AutovalidateMode.disabled;
  GlobalKey<FormState> silverFormKey = GlobalKey();
  GlobalKey<FormState> sharesFormKey = GlobalKey();
  AutovalidateMode sharesAutoValidate = AutovalidateMode.disabled;
  GlobalKey<FormState> otherFormKey = GlobalKey();
  GlobalKey<FormState> additionalAmountFormKey = GlobalKey();

  //----------------------------------------------------------------------------
  // Inputs Zakat

  TextEditingController cash = TextEditingController();
  RxList<int> goldKarats = <int>[].obs;
  RxList<TextEditingController> goldGrams = [TextEditingController()].obs;
  TextEditingController silver = TextEditingController();
  RxList<TextEditingController> stockNames = [TextEditingController()].obs;
  RxList<int> sharesNumbers = <int>[1].obs;
  RxList<TextEditingController> sharesValues = [TextEditingController()].obs;
  TextEditingController others = TextEditingController();
  TextEditingController additionalAmount = TextEditingController();

  //----------------------------------------------------------------------------
  // Open and Close Zakat Section

  RxBool isCashMoney = false.obs;
  RxBool isGold = false.obs;
  RxBool isSilver = false.obs;
  RxBool isShares = false.obs;
  RxBool isOther = false.obs;

  //----------------------------------------------------------------------------
  // Done

  RxBool cashIsDone = false.obs;
  RxBool goldIsDone = false.obs;
  RxBool silverIsDone = false.obs;
  RxBool sharesIsDone = false.obs;
  RxBool otherIsDone = false.obs;

  //----------------------------------------------------------------------------
  // Loading

  RxBool cashIsLoading = false.obs;
  RxBool goldIsLoading = false.obs;
  RxBool silverIsLoading = false.obs;
  RxBool sharesIsLoading = false.obs;
  RxBool otherIsLoading = false.obs;

  //----------------------------------------------------------------------------
  // Errors

  Rx<String?> cashError = Rx<String?>(null);
  Rx<String?> goldError = Rx<String?>(null);
  Rx<String?> silverError = Rx<String?>(null);
  Rx<String?> sharesError = Rx<String?>(null);
  Rx<String?> otherError = Rx<String?>(null);

  //----------------------------------------------------------------------------
  // Total funds and zakat sections

  RxInt totalZakat = 0.obs;
  RxInt totalMoney = 0.obs;
  int totalCash = 0;
  int totalGold = 0;
  int totalSilver = 0;
  int totalShare = 0;
  int totalOther = 0;
  int totalAdditionalAmount = 0;

  ///============================================================================
  /// Functions

  // Verify whether there is an activated Zakat section or not
  isHasZakat() {
    if ((isCashMoney.isTrue ||
            isGold.isTrue ||
            isSilver.isTrue ||
            isShares.isTrue ||
            isOther.isTrue) &&
        totalMoney.value > 0) {
      return true;
    } else {
      return false;
    }
  }

  onTapZakatSelection() async {
    await zakatSelectionSheetX(controller: zakatSelectionController);
  }
  //----------------------------------------------------------------------------
  // Activate and close sections
  // then calculate the value of the money after removing or adding entries for the section that was changed.

  onOpenCashMoney(bool val) async {
    isCashMoney.value = val;
    // Delayed execution due to interface animation
    await Future.delayed(const Duration(milliseconds: 400));
    await calculateCashMoney();
  }

  onOpenGold(bool val) async {
    isGold.value = val;
    // Delayed execution due to interface animation
    await Future.delayed(const Duration(milliseconds: 400));
    await calculateGold();
  }

  onOpenSilver(bool val) async {
    isSilver.value = val;
    // Delayed execution due to interface animation
    await Future.delayed(const Duration(milliseconds: 400));
    await calculateSilver();
  }

  onOpenShares(bool val) async {
    isShares.value = val;
    await Future.delayed(const Duration(milliseconds: 400));
    await calculateShares();
  }

  onOpenOther(bool val) async {
    isOther.value = val;
    // Delayed execution due to interface animation
    await Future.delayed(const Duration(milliseconds: 400));
    await calculateOther();
  }

  //----------------------------------------------------------------------------
  // Metal processing
  /// To add the word “karat” to the karat to be displayed on the screen

  List<String> getGoldKaratsListToShowInScreen() {
    return MetalKaratStatusX.values
        .map((x) => "${x.karat} ${"Karat".tr}")
        .toList();
  }

  /// To add the word “karat” to the selected value so that it is similar to the values in the list of values
  getGoldKaratValueToShowInScreen(index) {
    if (goldKarats.asMap()[index] != null) {
      return "${goldKarats[index]} ${"Karat".tr}";
    }
  }

  /// When changing one of the gold karat values
  onChangeGoldKarat(String val, int index) async {
    /// The value is returned to a number after the word karat is added to it
    var karat = int.parse(val.substring(0, val.indexOf(" ")));

    /// It checks whether there is a previous value to modify or create a new value
    if (goldKarats.asMap()[index] != null) {
      goldKarats[index] = karat;
    } else {
      goldKarats.insert(index, karat);
    }

    await calculateGold();
  }

  /// When an additional gold field is added
  onAddZakatGoldRow() {
    if (checkIfCanAddRowOnGold()) {
      goldGrams.add(TextEditingController());
    } else {
      goldError.value =
          'Make sure all existing gold fields are filled before adding new gold.';
    }
  }

  /// When a gold field is removed
  onRemoveZakatGoldRow(int i) async {
    /// There must be more than one field
    if (goldGrams.length > 1) {
      goldGrams.removeAt(i);
      if (goldKarats.asMap()[i] != null) {
        goldKarats.removeAt(i);
      }
      await calculateGold();
    }
  }

  /// Ensure that karat values are present in all input fields
  checkIfCanAddRowOnGold() {
    if (goldGrams.length != goldKarats.length) {
      return false;
    }
    for (int i = 0; i < goldGrams.length; i++) {
      if (ValidateX.gram(goldGrams[i].text) != null) {
        return false;
      }
    }
    return true;
  }

  //----------------------------------------------------------------------------
  // Shares

  /// When the number of shares is changed
  onChangeShareNumber(double val, int index) async {
    sharesNumbers[index] = val.toInt();
    await calculateShares();
  }

  /// When an additional field field is added
  onAddZakatShareRow() {
    if (checkIfCanAddRowOnShares()) {
      stockNames.add(TextEditingController());
      sharesValues.add(TextEditingController());
      sharesNumbers.add(1);
    } else {
      sharesError.value =
          'Make sure all existing shares fields are filled in before adding a new shares.';
    }
  }

  /// When a Share field is removed
  onRemoveZakatShareRow(int i) async {
    /// There must be more than one field
    if (stockNames.length > 1) {
      stockNames.removeAt(i);
      sharesValues.removeAt(i);
      sharesNumbers.removeAt(i);
      await calculateShares();
    }
  }

  checkIfCanAddRowOnShares() {
    for (int i = 0; i < sharesValues.length; i++) {
      if (ValidateX.money(sharesValues[i].text) != null) {
        return false;
      }
    }
    return true;
  }

  //----------------------------------------------------------------------------
  // Sections Calculator
  /// Calculate the total funds in each section and then activate the calculation of the general zakat value
  /// Important Note: Only the valid value is calculated and errors are later shown when payment is made

  calculateCashMoney() async {
    /// Verify the activation of the section and ensure that the entries are correct
    totalCash = 0;
    cashError.value = null;
    cashIsDone.value = false;
    if (isCashMoney.value) {
      if (cashFormKey.currentState!.validate()) {
        cashIsLoading.value = true;
        if (ValidateX.money(cash.text) == null) {
          /// Add the entered value to the department's total funds
          try {
            totalCash = await DatabaseX.getZakatCalculation(
              form: ZakatCalculationFormX(
                type: ZakatCalculationTypeStatusX.money,
                money: cash.text.toDoubleX,
              ),
            );
            cashIsDone.value = true;
          } catch (e) {
            e.toErrorX.log();
            cashError.value = e.toString();
          }
        } else {
          if (cash.text.isNotEmpty) {
            cashError.value = ValidateX.money(cash.text);
          }
        }

        cashIsLoading.value = false;

        /// Calculating the value of general zakat
      }
    }
    calculateTotal();
  }

  calculateGold() async {
    totalGold = 0;
    goldError.value = null;
    goldIsDone.value = false;

    /// Verify the activation of the section
    if (isGold.value) {
      if (goldFormKey.currentState!.validate()) {
        if (goldGrams.length > 1 ||
            (goldGrams.first.text.isNotEmpty && goldKarats.isNotEmpty)) {
          goldIsLoading.value = true;

          List<ZakatCalculationGoldX> golds = [];

          /// Go through all entered values
          for (int i = 0; i < goldGrams.length; i++) {
            /// Check the grams value entered must be correct and make sure to choose a gold karat value for this value
            if (ValidateX.gram(goldGrams[i].text) == null &&
                goldKarats.asMap()[i] != null) {
              golds.add(
                ZakatCalculationGoldX(
                  karat: MetalKaratStatusX.values
                      .firstWhere((e) => e.karat == goldKarats[i]),
                  gram: int.parse(goldGrams[i].text),
                ),
              );
            } else {
              goldIsLoading.value = false;
              return goldError.value = ValidateX.gram(goldGrams[i].text)!=null?'Check gold weight fields':
                  'Make sure to select gold carats for all fields.';
            }
          }
          if (goldGrams.length == 1 || golds.length == goldGrams.length) {
            try {
              totalGold = await DatabaseX.getZakatCalculation(
                form: ZakatCalculationFormX(
                  type: ZakatCalculationTypeStatusX.gold,
                  golds: golds,
                ),
              );
              goldIsDone.value = true;
            } catch (e) {
              goldError.value = e.toString();
            }
          } else {
            return sharesError.value =
                'Empty gold fields must be filled in or removed.';
          }

          goldIsLoading.value = false;
        }
      }
    }

    /// Calculating the value of general zakat
    calculateTotal();
  }

  calculateSilver() async {
    totalSilver = 0;
    silverError.value = null;
    silverIsDone.value = false;
    if (isSilver.value) {
      if (silverFormKey.currentState!.validate()) {
        silverIsLoading.value = true;
        if (ValidateX.gram(silver.text) == null) {
          try {
            totalSilver = await DatabaseX.getZakatCalculation(
              form: ZakatCalculationFormX(
                type: ZakatCalculationTypeStatusX.silver,
                weight: int.parse(silver.text),
              ),
            );
            silverIsDone.value = true;
          } catch (e) {
            silverError.value = e.toString();
          }
        } else {
          if (silver.text.isNotEmpty) {
            silverError.value = ValidateX.gram(silver.text);
          }
        }
        silverIsLoading.value = false;
      }
    }

    /// Calculating the value of general zakat
    calculateTotal();
  }

  calculateShares() async {
    totalShare = 0;
    sharesError.value = null;
    sharesIsDone.value = false;
    if (isShares.value) {
      if (sharesFormKey.currentState!.validate()) {
        if (sharesValues.length > 1 || sharesValues.first.text.isNotEmpty) {
          sharesIsLoading.value = true;

          List<ZakatCalculationSharesX> shares = [];

          for (int i = 0; i < sharesNumbers.length; i++) {
            if (sharesValues[i].text.isEmpty) {
              continue;
            }
            if (ValidateX.money(sharesValues[i].text) == null &&
                sharesNumbers[i] >= 1) {
              shares.add(ZakatCalculationSharesX(
                  price: sharesValues[i].text.toDoubleX,
                  count: sharesNumbers[i]));
            } else {
              sharesIsLoading.value = false;
              return sharesError.value = ValidateX.gram(sharesValues[i].text);
            }
          }
          if (sharesValues.length == 1 ||
              shares.length == sharesValues.length) {
            try {
              totalShare = await DatabaseX.getZakatCalculation(
                form: ZakatCalculationFormX(
                  type: ZakatCalculationTypeStatusX.share,
                  shares: shares,
                ),
              );
              sharesIsDone.value = true;
            } catch (e) {
              sharesError.value = e.toString();
            }
          } else {
            return sharesError.value =
                'Empty fields for stocks must be filled in or removed.';
          }

          sharesIsLoading.value = false;
        }
      }
    }

    /// Calculating the value of general zakat
    calculateTotal();
  }

  calculateOther() async {
    totalOther = 0;
    otherError.value = null;
    otherIsDone.value = false;
    if (isOther.value) {
      if (otherFormKey.currentState!.validate()) {
        otherIsLoading.value = true;
        if (ValidateX.money(others.text) == null) {
          try {
            totalOther = await DatabaseX.getZakatCalculation(
              form: ZakatCalculationFormX(
                type: ZakatCalculationTypeStatusX.other,
                money: others.text.toDoubleX,
              ),
            );
            otherIsDone.value = true;
          } catch (e) {
            otherError.value = e.toString();
          }
        } else {
          if (others.text.isNotEmpty) {
            otherError.value = ValidateX.money(others.text);
          }
        }
        otherIsLoading.value = false;
      }
    }

    /// Calculating the value of general zakat
    calculateTotal();
  }

  calculateAdditionalAmount() {
    if (additionalAmount.text.isNotEmpty &&
        ValidateX.money(additionalAmount.text) == null) {
      totalAdditionalAmount = int.parse(additionalAmount.text);
      calculateTotal();
    }
  }

  //----------------------------------------------------------------------------
  // Calculate Total
  /// Calculating the total public funds with the value of zakat

  calculateTotal() {
    /// Zero the value to start a new calculation
    totalZakat.value = 0;
    totalMoney.value = 0;

    /// Only active departments' funds are added
    if (isCashMoney.value) totalZakat.value += totalCash;
    if (isGold.value) totalZakat.value += totalGold;
    if (isSilver.value) totalZakat.value += totalSilver;
    if (isShares.value) totalZakat.value += totalShare;
    if (isOther.value) totalZakat.value += totalOther;
    totalMoney.value = totalZakat.value;
    totalZakat.value += totalAdditionalAmount;
  }

  //===============================================================
  // Clear Data
  /// Reset all values after paying zakat

  clearData() {
    cash.text = "";
    goldKarats.value = [];
    goldGrams.value = [TextEditingController()];
    silver.text = "";
    stockNames.value = [TextEditingController()];
    sharesNumbers.value = [1];
    sharesValues.value = [TextEditingController()];
    others.text = "";

    isCashMoney.value = false;
    isGold.value = false;
    isSilver.value = false;
    isShares.value = false;
    isOther.value = false;

    totalZakat.value = 0;
    totalMoney.value = 0;
    totalCash = 0;
    totalGold = 0;
    totalSilver = 0;
    totalShare = 0;
    totalOther = 0;
    totalAdditionalAmount = 0;
    additionalAmount.text = "";
  }

  //===============================================================
  // Main processors

  onAddToCart({bool isPay = false}) async {
    if (isPayOrCartLoading.isFalse) {
      if (zakatSelectionController.optionSelected.value == null && app.generalSettings.defaultZakat==null) {
        ToastX.error(message: 'You must choose one of the donations');
      } else if (additionalAmountFormKey.currentState!.validate()) {
        isPayOrCartLoading.value = true;
        isPay
            ? payButtonState.value = ButtonStateEX.loading
            : addToCartButtonState.value = ButtonStateEX.loading;

        try {
          var data = await DatabaseX.createDonationOrder(
            form: DonationOrderFormX(
              donationId: zakatSelectionController.optionSelected.value!=null?zakatSelectionController.optionSelected.value!.id:app.generalSettings.defaultZakat!.id,
              price: totalZakat.value,
              donationOnBehalfOfFamilyAndFriends: false,
            ),
          );

          String message = await cart.addItem(
            modelId: data.modelId,
            modelType: ModelTypeStatusX.donation,
            price: totalZakat.value,
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
          zakatSelectionController.clearData();
          if(app.generalSettings.defaultZakat!=null) {
            zakatSelectionController.optionSelected=app.generalSettings.defaultZakat.obs;
          }
        } catch (error) {
          error.toErrorX.log();
          ToastX.error(message: error.toString());
          isPay
              ? payButtonState.value = ButtonStateEX.failed
              : addToCartButtonState.value = ButtonStateEX.failed;
        }
        isPayOrCartLoading.value = false;

        /// Reset the button state
        Timer(
          const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
            addToCartButtonState.value = ButtonStateEX.normal;
            payButtonState.value = ButtonStateEX.normal;
          },
        );
      }else{
        ToastX.error(message: 'There is an error in the additional amount field data.');
      }
    }
  }

  //============================================================================
  @override
  void onInit() {
    super.onInit();
    zakatSelectionController
        .ensureDefaultSelected(app.generalSettings.defaultZakat);
  }
}
