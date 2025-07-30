import 'package:get/get.dart';
import 'filterByCountryController.dart';
import 'filterByGenderController.dart';
import 'filterByLanguageController.dart';
import 'filterByReligionController.dart';


class SponsorshipFilterControllerX extends GetxController{
  //============================================================================
  // Injection of required controls

  FilterByCountryControllerX filterByCountryController = Get.put(FilterByCountryControllerX());
  FilterByGenderControllerX filterByGenderController = Get.put(FilterByGenderControllerX());
  FilterByLanguageControllerX filterByLanguageController = Get.put(FilterByLanguageControllerX());
  FilterByReligionControllerX filterByPreviousReligionController = Get.put(FilterByReligionControllerX());

  //============================================================================
  // Variables

  bool isNewMuslim = false;

  //============================================================================
  // Functions

  /// The value is captured when the bottom sheet is closed, and the filter values are used in its controller
  onFilter() => Get.back(result: true);

  /// Erase all data and return it to its default state
  clearDate(){
    filterByCountryController.countrySelected.value="All";
    filterByGenderController.genderSelected.value="All";
    filterByLanguageController.languageSelected.value="All";
    filterByPreviousReligionController.previousReligionSelected.value="All";
  }
}