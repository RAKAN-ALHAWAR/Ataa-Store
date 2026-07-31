part of '../../core.dart';

class AppControllerX extends GetxController {
  //============================================================================
  // Variables

  Rx<UserX?> user = Rx<UserX?>(null);

  late GeneralAppSettingsX generalSettings;
  late GeneralPaymentMethodsSettingsX generalPaymentMethodsSettings;
  late HomeElementSettingsX homeElementSettings;
  RxBool isLogin = LocalDataX.token.isNotEmpty.obs;

  //============================================================================
  // Functions

  init() async {
    /// General Settings
    generalSettings = await DatabaseX.getGeneralSettings();
    generalPaymentMethodsSettings =
        await DatabaseX.getGeneralPaymentMethodsSettings();
    homeElementSettings = await DatabaseX.getHomeElementSettings();

    /// Profile
    if (isLogin.value) {
      user.value = await DatabaseX.getProfile();
    }
    update();
  }

  onLoginSheet() async {
    if (generalSettings.accountCreationMethodIsTraditionalForm) {
      await bottomSheetX(child: LoginView(isSheet: true).paddingOnly(top: 14));
    } else {
      await bottomSheetX(
        child: ContinueToAccountView(isSheet: true).paddingOnly(top: 14),
      );
    }
  }

  onSignUpSheet() async {
    await bottomSheetX(child: SignUpView(isSheet: true).paddingOnly(top: 14));
  }

  logOut() async {
    String route = generalSettings.accountCreationMethodIsTraditionalForm
        ? RouteNameX.login
        : RouteNameX.continueToAccount;
    try {
      isLogin.value = false;
      user.value = null;
      LocalDataX.remove(LocalKeyX.token);

      LocalDataX.put(LocalKeyX.route, route);
      Get.find<CartGeneralControllerX>().delete();
      Get.delete<AllDonationController>();
      Get.lazyPut(() => AllDonationController());
      if (Get.currentRoute != route) {
        await Future.wait([
          DatabaseX.logout(),
          Future.microtask(() => Get.offAllNamed(route)),
        ]);
      } else {
        await DatabaseX.logout();
      }
    } catch (_) {}
  }

  deleteAccount() async {
    try {
      var meesage = await DatabaseX.deleteAccount();
      if (meesage != null) {
        ToastX.success(message: meesage);
      }
      isLogin.value = false;
      user.value = null;
      LocalDataX.remove(LocalKeyX.token);
      LocalDataX.put(LocalKeyX.route, RouteNameX.login);
      Get.find<CartGeneralControllerX>().delete();
      Get.delete<AllDonationController>();
      Get.lazyPut(() => AllDonationController());
      if (Get.currentRoute != RouteNameX.login) {
        await Future.wait([
          Future.microtask(() => Get.offAllNamed(RouteNameX.login)),
        ]);
      }
    } catch (_) {
      ToastX.error();
    }
  }
}
