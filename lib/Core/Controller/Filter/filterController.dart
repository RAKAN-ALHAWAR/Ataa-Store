import 'package:ataa/Data/data.dart';
import 'package:get/get.dart';
import '../../../Ui/ScreenSheet/Filter/FilterByOrganization/filterByOrganizationSheet.dart';
import '../../../Ui/ScreenSheet/Sort/SortByFrequency/sortByFrequency.dart';
import '../../../Ui/ScreenSheet/Sort/SortByGeneral/sortByGeneral.dart';
import '../Sort/sortByFrequencyController.dart';
import '../Sort/sortByGeneralController.dart';
import 'filterByOrganizationController.dart';

class FilterControllerX extends GetxController {
  final String tag;
  FilterControllerX({required this.tag});

  //============================================================================
  // Injection of required controls

  late FilterByOrganizationControllerX filterByOrgController;
  late SortByGeneralControllerX sortByGeneralController;
  late SortByFrequencyControllerX sortByFrequencyController;

  @override
  void onInit() {
    super.onInit();
    filterByOrgController = Get.put(
      FilterByOrganizationControllerX(),
      tag: tag,
    );
    sortByGeneralController = Get.put(
      SortByGeneralControllerX(),
      tag: tag,
    );
    sortByFrequencyController = Get.put(
      SortByFrequencyControllerX(),
      tag: tag,
    );
  }

  //============================================================================
  // Variables

  RxBool isZakat = false.obs;
  RxString sort = "All".obs;
  Rx<String?> orderBy = Rx<String?>(null);
  RxMap<String, dynamic> filters = RxMap<String, dynamic>({});

  bool isShowZakat = true;
  bool isShowDeduction = false;
  bool isShowOrganization = true;
  bool isShowSort = true;

  // ============================================================================
  // Functions

  onChangeSort(String val) => sort.value = val;
  onChangeZakat(bool val) => isZakat.value = val;

  onTapFilterByOrganization() =>
      filterByOrganizationSheetX(controller: filterByOrgController);

  onTapSortByFrequency() =>
      sortByFrequencySheetX(controller: sortByFrequencyController);


  onTapSortByGeneral() =>
      sortByGeneralSheetX(controller: sortByGeneralController);

  /// Erase all data and return it to its default state
  clearData() {
    sort.value = "All";
    isZakat.value = false;
    filterByOrgController.clearData();
    sortByGeneralController.clearData();
    sortByFrequencyController.clearData();
  }

  /// The return value is captured and filtered accordingly, and the filtering data is taken from the value of the variables
  onFilter() {
    filters.value = {};
    if (isShowZakat) {
      filters[NameX.isZakat] = isZakat.value;
    }
    if (isShowDeduction) {
      if (sortByFrequencyController.frequencySelected.value !=
          RecurringSortEX.all) {
        filters[NameX.recurring] =
            sortByFrequencyController.frequencySelected.value.name;
      }
    }
    if (isShowOrganization) {
      if (filterByOrgController.optionSelected.value.$2.id.isNotEmpty) {
        filters[NameX.categoryId] =
            filterByOrgController.optionSelected.value.$2.id;
      }
    }
    if (sortByGeneralController.generalSelected.value != GeneralSortEX.all) {
      orderBy.value = sortByGeneralController.generalSelected.value.name;
    } else {
      orderBy.value = null;
    }
    Get.back();
  }
}
