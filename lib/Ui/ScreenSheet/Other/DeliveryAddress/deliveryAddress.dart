import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../Config/Translation/translation.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/Cart/deliveryAddressController.dart';
import '../../../../Core/core.dart';
import '../../../../Data/data.dart';
import '../../../Widget/Package/google_map_location_picker_flutter/src/map.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Enter product delivery information
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

deliveryAddressSheetX({required DeliveryAddressControllerX controller}) {
  return bottomSheetX(
    title: "Delivery Address",
    child: Column(
      children: [
        Obx(
          () {
            /// A message clarifying that valid location data was entered
            if (controller.latitude.value != 0 &&
                controller.longitude.value != 0) {
              return ContainerX(
                color: Get.isDarkMode
                    ? ColorX.primary.shade900.withValues(alpha: 0.3)
                    : Get.theme.colorScheme.onPrimary,
                margin: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Get.theme.primaryColor,
                    ),
                    const SizedBox(width: 10),
                    const TextX("The location has been determined"),
                  ],
                ),
              ).fadeAnimation200;
            } else {
              return const SizedBox();
            }
          },
        ),

        /// Locate button on map
        ButtonX.second(
          text: "Locate the address on the map",
          iconData: Icons.location_pin,
          onTap: () async {
            controller.onChangeLocation(
              await showGoogleMapLocationPicker(
                pinWidget: const Icon(
                  Icons.location_pin,
                  color: ColorX.danger,
                  size: 55,
                ),
                pinColor: ColorX.danger,
                context: Get.context!,
                confirmButtonColor: Get.theme.primaryColor,
                apiKey: ApiKeysX.googleMap,
                addressPlaceHolder: "Move the map".tr,
                addressTitle: "Delivery Address".tr,
                appBarTitle: "Select a delivery location".tr,
                confirmButtonText: "Confirm location".tr,
                searchHint: "Find a location".tr,
                confirmButtonTextColor: Colors.black,
                country: "sa",
                language: TranslationX.getLanguageCode,
                initialLocation: LatLng(
                    controller.latitude.value != 0
                        ? controller.latitude.value
                        : 24.713515,
                    controller.longitude.value != 0
                        ? controller.longitude.value
                        : 46.675189),
              ),
            );
          },
        ).fadeAnimation200,
        const SizedBox(height: 10),

        /// Country & District
        Obx(
          () => Row(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelInputX("Country"),
                    DropdownX<String>(
                      value: controller.countrySelected.value,
                      list: controller.countries,
                      onChanged: controller.onChangedCountry,
                      hint: "-- Choose --",
                    ),
                  ],
                ).fadeAnimation200,
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const LabelInputX("City"),
                    DropdownX<String>(
                      value: controller.citySelected.value,
                      list: controller.cities,
                      onChanged: controller.onChangedCity,
                      hint: controller.isLoadingCities.value
                          ? "Loading..."
                          : "-- Choose --",
                    ),
                  ],
                ).fadeAnimation200,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        /// Inputs Fields
        Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidate,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Street
              TextFieldX(
                label: "Street",
                controller: controller.street,
                validate: ValidateX.street,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.streetAddress,
              ).fadeAnimation300,
              const SizedBox(height: 10),

              /// District
              TextFieldX(
                label: "District",
                controller: controller.district,
                validate: ValidateX.district,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.streetAddress,
              ).fadeAnimation300,
              const SizedBox(height: 10),

              /// Address
              const LabelInputX("Address", isOptional: true).fadeAnimation400,
              TextFieldX(
                minLines: 5,
                controller: controller.address,
                validate: ValidateX.address,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.streetAddress,
              ).fadeAnimation400,
            ],
          ),
        ),
        const SizedBox(height: 10),

        /// Save Button
        Obx(
          () => ButtonStateX(
            text: "Save",
            onTap: controller.onSave,
            state: controller.buttonState.value,
          ).fadeAnimation500,
        )
      ],
    ),
  );
}
