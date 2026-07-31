import 'package:ataa/Core/Controller/Cart/cartGeneralController.dart';
import 'package:get/get.dart';
import '../../../../../../Data/data.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../Core/Service/deep_link_service.dart';

class LoadingController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  CartGeneralControllerX cart = Get.find();

  //============================================================================
  // Functions

  Future<void> init() async {
    /// Configure the global controller when it is on the home page when the application opens so that it fetches user data
    await app.init();
    await cart.getData();
  }

  finish() {
    // إخبار خدمة الديب لينك أن التطبيق جاهز لمعالجة الروابط
    var resutl = DeepLinkServiceX.setAppReady();
    if (resutl == false) {
      String route = LocalDataX.route;
      if (route == RouteNameX.login || route == RouteNameX.continueToAccount) {
        route = app.generalSettings.accountCreationMethodIsTraditionalForm
            ? RouteNameX.login
            : RouteNameX.continueToAccount;
      }
      Get.offAllNamed(route);
    }
  }
}
