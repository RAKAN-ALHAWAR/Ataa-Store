import 'dart:async';
import 'package:ataa/Config/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Data/data.dart';
import '../../../Ui/Widget/Package/google_map_location_picker_flutter/src/address_result.dart';
import '../../../Ui/Widget/widget.dart';

class DeliveryAddressControllerX extends GetxController {
  //============================================================================
  // Variables

  RxBool isLoading = false.obs;
  RxBool isLoadingCities = false.obs;
  RxBool isHasData = false.obs;
  Rx<ButtonStateEX> buttonState = ButtonStateEX.normal.obs;

  DeliveryLocationX deliveryAddress = DeliveryLocationX.empty();

  List<String> countries = [];
  List<String> cities = [];

  RxString countrySelected = ''.obs;
  RxString citySelected = ''.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;

  TextEditingController street = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController address = TextEditingController();

  //============================================================================
  // Functions

  getData() async {
    try {
      /// TODO: Database >>> Add code to check availability and retrieve delivery information

      /// Fetch available countries
      await getCountries();

      /// Filling the fields with data if there is previous data in the database
      if (deliveryAddress.id.isNotEmpty) {
        countrySelected.value = deliveryAddress.country;
        citySelected.value = deliveryAddress.city;
        street.text = deliveryAddress.street;
        district.text = deliveryAddress.district;
        address.text = deliveryAddress.address ?? '';
        latitude.value = deliveryAddress.latitude;
        longitude.value = deliveryAddress.longitude;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  getCountries() async {
    try {
      /// TODO: Database >>> Fetch available countries
      // countries = TestDataX.countries;

      /// If the country is not empty, data for the cities belonging to the country is retrieved
      if (countrySelected.isNotEmpty) {
        await getCities();
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  getCities() async {
    isLoadingCities.value = true;
    try {
      /// Because the country has changed, so the city must be empty
      citySelected.value = '';
      cities=[];
      update();

      /// TODO: Database >>> Fetch available cities by country
      await Future.delayed(const Duration(seconds: 1)); // delete this
      // cities = TestDataX.cities;
    } catch (e) {
      return Future.error(e);
    }
    isLoadingCities.value = false;
  }

  /// Verify the entered data
  bool dataVerification() {
    if (latitude.value == 0 && longitude.value == 0) {
      // check location
      return throw "The address must be specified on the map";
    } else if (countrySelected.isEmpty) {
      // check country
      return throw "You must specify the country";
    } else if (citySelected.isEmpty) {
      // check city
      return throw "You must specify the city";
    } else if (!formKey.currentState!.validate()) {
      // check text fields
      autoValidate = AutovalidateMode.always;
      return throw "Make sure the input fields are correct";
    }
    return true;
  }

  onSave() async {
    if (isLoading.isFalse) {
      try {
        if (dataVerification()) {
          isLoading.value = true;
          buttonState.value = ButtonStateEX.loading;

          /// TODO: Database >>> Add & Edit delivery address from database
          await Future.delayed(const Duration(seconds: 1)); // delete this

          if (deliveryAddress.id.isEmpty) {
            /// TODO: Database >>> get id from database after create delivery object in database
            deliveryAddress.id = '1';
          }

          /// update object
          deliveryAddress.country = countrySelected.value;
          deliveryAddress.country = citySelected.value;
          deliveryAddress.street = street.text;
          deliveryAddress.district = district.text;
          deliveryAddress.address = address.text;

          /// this for update widget in basket screen
          isHasData.value = true;

          /// The time delay here is aesthetically beneficial
          buttonState.value = ButtonStateEX.success;
          await Future.delayed(
            const Duration(seconds: StyleX.successButtonSecond),
          );

          /// close sheet
          Get.back();
          ToastX.success(
              title: "Delivery Address", message: "It was successful");
        }
      } catch (error) {
        ToastX.error(message: error);
        buttonState.value = ButtonStateEX.failed;
      }
      isLoading.value = false;

      /// Reset the button state
      Timer(const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
          () {
        buttonState.value = ButtonStateEX.normal;
      });
    }
  }

  onChangeLocation(AddressResult? result) async {
    if (result != null) {
      latitude.value = result.latlng.latitude;
      longitude.value = result.latlng.longitude;
    }
  }

  onChangedCountry(val) async {
    countrySelected.value = val;

    /// Every time the country changes, the cities must change
    await getCities();
  }

  onChangedCity(val) {
    citySelected.value = val;
  }
}
