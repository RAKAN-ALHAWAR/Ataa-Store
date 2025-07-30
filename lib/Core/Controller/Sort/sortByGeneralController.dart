import 'package:get/get.dart';

import '../../../Data/data.dart';

class SortByGeneralControllerX extends GetxController {
  //============================================================================
  // Variables

  /// The values are fetched from enum
  late Rx<GeneralSortEX> generalSelected = GeneralSortEX.values[0].obs;

  //============================================================================
  // Functions

  onChange(GeneralSortEX? val) {
    generalSelected.value = val ?? GeneralSortEX.values[0];
    Get.back();
  }

  /// Erase all data and return it to its default state
  clearData(){
    generalSelected.value = GeneralSortEX.values[0];
  }
}
