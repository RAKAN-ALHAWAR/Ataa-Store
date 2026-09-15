import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/data.dart';
import '../../../Data/Model/Donation/donation.dart';

class ZakatSelectionControllerX extends GetxController {
  //============================================================================
  // Variables

  late Rx<DonationX?> optionSelected = Rx<DonationX?>(null);
  List<(String, DonationX)> options = [];
  ScrollController scrollController = ScrollController();
  //============================================================================
  // Functions

  onChange(DonationX val) {
      optionSelected.value = val;
    Get.back();
  }

  /// Ensure a project is pre-selected so the field is never shown empty:
  /// use the admin default zakat when valid, otherwise fall back to the first
  /// zakat project. Does nothing when a valid project is already selected.
  Future<void> ensureDefaultSelected(DonationX? defaultZakat) async {
    if (optionSelected.value != null &&
        optionSelected.value!.id.isNotEmpty) {
      return;
    }

    if (defaultZakat != null && defaultZakat.id.isNotEmpty) {
      optionSelected.value = defaultZakat;
      return;
    }

    try {
      final List<DonationX> list =
          await DatabaseX.getAllDonations(isZakat: true);
      final bool stillEmpty = optionSelected.value == null ||
          optionSelected.value!.id.isEmpty;
      if (stillEmpty && list.isNotEmpty) {
        optionSelected.value = list.first;
      }
    } catch (_) {
      // No default available; leave the field empty rather than crash.
    }
  }

  /// Erase all data and return it to its default state
  clearData() {
    optionSelected.value = null;
  }

  Future<List<DonationX>> getData(
    ScrollRefreshLoadMoreParametersX data,
  ) async {
    return await DatabaseX.getAllDonations(
      page: data.page,
      perPage: data.perPage,
      isZakat: true,
    );
  }
}
