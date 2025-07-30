import 'package:get/get.dart';

import '../../../Data/data.dart';

class SortProductsControllerX extends GetxController {
  //============================================================================
  // Variables

  /// The values are fetched from enum
  late Rx<ProductSortEX> sortSelected = ProductSortEX.values[0].obs;

  //============================================================================
  // Functions

  onChange(ProductSortEX? val){
    sortSelected.value = val ?? ProductSortEX.values[0];
    Get.back();
  }
}
