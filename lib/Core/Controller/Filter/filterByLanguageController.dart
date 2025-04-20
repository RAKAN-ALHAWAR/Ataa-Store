import 'dart:async';
import 'package:get/get.dart';

class FilterByLanguageControllerX extends GetxController {
  //============================================================================
  // Variables

  RxString languageSelected = "All".obs;
  List<String> options = [];

  //============================================================================
  // Functions

  onChange(String? val){
    languageSelected.value = val ?? "";
    Get.back();
  }

  getData() async {
    try {
      /// TODO: Database >>> Fetch available countries in the filtering process
      await Future.delayed(const Duration(seconds: 1)); // delete this
      // options = ["All", ...TestDataX.language];
    } catch (e) {
      return Future.error(e);
    }
  }
}
