import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Data/Enum/model_type_status.dart';
import 'package:ataa/Ui/ScreenSheet/Other/MandatoryAuth/mandatoryAuth.dart';
import 'package:get/get.dart';
import '../../../Config/config.dart';
import '../../../Data/Model/Cart/cart.dart';
import '../../../Data/data.dart';

class CartGeneralControllerX extends GetxController {
  //============================================================================
  // Variables

  late Rx<CartX> cart;
  RxInt countItem = 0.obs;
  //============================================================================
  // Functions

  openCart() => Get.toNamed(RouteNameX.cart);
  delete() {
    LocalDataX.put(LocalKeyX.cartIdIsAssign, false);
    countItem.value = 0;
    cart.value = CartX(
      id: '',
      totalPrice: 0,
      countItem: 0,
      currency: '',
      isProduct: false,
    );
  }

  saveCartID() {
    if (LocalDataX.token.isEmpty) {
      LocalDataX.put(LocalKeyX.cartId, cart.value.id);
    }
  }

  assignCart(String token) async {
    try {
      if (LocalDataX.cartID.isNotEmpty && !LocalDataX.cartIdIsAssign) {
        await DatabaseX.assignCart(LocalDataX.cartID, token);
        LocalDataX.remove(LocalKeyX.cartId);
        LocalDataX.put(LocalKeyX.cartIdIsAssign, true);
      }
    } catch (e) {
      e.toErrorX.log();
    }
  }

  getData({bool isLogin = false}) async {
    if (LocalDataX.token.isNotEmpty) {
      cart = (await DatabaseX.getAllCartItems()).obs;
    } else if (LocalDataX.cartID.isNotEmpty) {
      cart = (await DatabaseX.getAllCartItems(cartId: LocalDataX.cartID)).obs;
    } else if (LocalDataX.cartID.isEmpty) {
      cart = (await DatabaseX.createCart()).obs;
      saveCartID();
    }
    countItem.value = cart.value.countItem;
  }

  Future<String> addItem({
    required String modelId,
    required ModelTypeStatusX modelType,
    required bool isPayNow,
    required int price,
    bool isCloseSheet = false,
    int quantity = 1,
  }) async {
    var data = await DatabaseX.createCartItem(cart.value.id, modelType, modelId);
    countItem.value = data.countItem;
    cart.value.countItem = data.countItem;
    cart.value.id = data.id;
    saveCartID();
    if (isCloseSheet) {
      Get.back();
    }
    if (isPayNow) {
      if (cart.value.countItem == 1 && LocalDataX.token.isEmpty) {
        await mandatoryAuthSheetX();
        // انتظر حتى يتم إغلاق جميع شاشات البوتم شيت المفتوحة
        while (Get.isBottomSheetOpen ?? false) {
          await Future.delayed(const Duration(
              milliseconds: 100)); // إضافة تأخير بسيط للتحقق بشكل دوري
        }
      }
      if (cart.value.countItem == 1 && LocalDataX.token.isNotEmpty) {
        Get.toNamed(
          RouteNameX.generalPayment,
          arguments: {
            NameX.totalCart: price+0.0,
          },
        );
      } else {
        Get.toNamed(RouteNameX.cart);
      }
    }
    return data.message;
  }
}
