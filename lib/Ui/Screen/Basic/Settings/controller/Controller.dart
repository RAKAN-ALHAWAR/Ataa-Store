import 'package:get/get.dart';
import '../../../../../Config/Translation/translation.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../Widget/widget.dart';

class SettingsController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  RxBool themeIsDark = ThemeX.isDarkMode.obs;

  //============================================================================
  // Functions

  changeLanguage(String val) async {
    try {
      /// Switch language
      await TranslationX.changeLocale(val);

      /// Save the language to internal storage
      LocalDataX.settings.language = val;
      LocalDataX.put(LocalKeyX.settings, LocalDataX.settings.toJson());

      /// Close the bottom sheet
      Get.back();
    } catch (e) {
      ToastX.error(message: e.toString());
    }
  }

  changeTheme() {
    try {
      /// Change the values of variables
      themeIsDark.value = !themeIsDark.value;
      LocalDataX.settings.themeIsDark = themeIsDark.value;

      /// Switch Theme
      ThemeX.change(themeIsDark.value);

      /// Save the theme to internal storage
      LocalDataX.put(LocalKeyX.settings, LocalDataX.settings.toJson());
    } catch (e) {
      ToastX.error(message: e.toString());
    }
  }
}
