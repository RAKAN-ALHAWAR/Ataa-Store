import 'package:get/get.dart';

import '../../../Data/data.dart';

class SortByFrequencyControllerX extends GetxController {
  //============================================================================
  // Variables

  /// The values are fetched from enum
  late Rx<RecurringSortEX> frequencySelected = RecurringSortEX.values[0].obs;

  //============================================================================
  // Functions

  onChange(RecurringSortEX? val) {
    frequencySelected.value = val ?? RecurringSortEX.values[0];
    Get.back();
  }
  /// Erase all data and return it to its default state
  clearData(){
    frequencySelected.value = RecurringSortEX.values[0];
  }
}
