import 'dart:async';
import 'package:get/get.dart';

class FilterByReligionControllerX extends GetxController {
  //============================================================================
  // Variables

  RxString previousReligionSelected = "All".obs;
  List<String> options = [];

  //============================================================================
  // Functions

  onChange(String? val) {
    previousReligionSelected.value = val ?? "";
    Get.back();
  }

  getData() async {
    try {
      /// TODO: Database >>> Fetch available countries in the filtering process
      await Future.delayed(const Duration(seconds: 1)); // delete this
      // options = ["All", ...TestDataX.religions];
    } catch (e) {
      return Future.error(e);
    }
  }
}
