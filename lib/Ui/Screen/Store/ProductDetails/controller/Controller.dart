import 'dart:async';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Cart/cartGeneralController.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../Ui/Widget/widget.dart';

class ProductDetailsController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();
  final CartGeneralControllerX basketController = Get.find();

  //============================================================================
  // Variables

  late ProductX product;

  RxBool isLoading = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  /// if use controller form add to card sheet
  late String id = Get.arguments ?? "";

  String sizeSelected = "";
  RxInt productNum = 1.obs;
  RxInt imageSelectedIndex = 0.obs;
  RxInt colorSelectedIndex = 0.obs;

  //============================================================================
  // Functions

  getData() async {
    try {
      /// TODO: Database >>> Fetch product details
      await Future.delayed(const Duration(seconds: 1)); // delete this

      // product = TestDataX.products.firstWhere((element) => element.id == id);

      /// Set a default size
      if (product.sizes.length == 1) {
        sizeSelected = product.sizes.first;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Initialize the controller if it is used from a bottom sheet
  sheetInit(ProductX product) {
    this.product = product;

    /// Set a default size
    if (product.sizes.length == 1) {
      sizeSelected = product.sizes.first;
    }
  }

  /// clear date on controller
  removeController() async {
    Get.delete<ProductDetailsController>(tag: product.id);
  }

  //----------------------------------------------------------------------------
  // Other

  onChangeSize(val) => sizeSelected = val;

  onChangeImage(index) => imageSelectedIndex.value = index;

  onChangeColor(index) => colorSelectedIndex.value = index;

  onChangeProductNum(double val) => productNum.value = val.toInt();

  //----------------------------------------------------------------------------
  // Main processors

  /// Erase all data and return it to its default state
  clearDate() {
    if (product.sizes.length == 1) {
      sizeSelected = product.sizes.first;
    }
    colorSelectedIndex.value = 0;
    productNum.value = 1;
    onChangeProductNum(1);
  }

  /// Verify the entered data
  bool dataVerification() {
    if (product.sizes.isNotEmpty && sizeSelected.isEmpty) {
      // Verify size selection
      throw "You must choose one of the sizes";
    }
    return true;
  }

  onAddToCart() async {
    if (isLoading.isFalse) {
      try {
        /// check is validate data
        if (dataVerification()) {
          isLoading.value = true;
          buttonState.value = ButtonStateEX.loading;

          /// Connect to basket Controller to add to cart in database
          // await basketController.addProduct(product);

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// if use this controller form bottom sheet
          if (id.isEmpty) {
            Get.back();

            /// clear date on controller
            removeController();
          } else {
            /// Clear date on controller
            clearDate();
          }

          ToastX.success(message: "Added to cart successfully");
        }
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
