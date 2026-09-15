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

  /// True while the fallback (first zakat project) is being fetched.
  RxBool isLoadingDefault = false.obs;
  //============================================================================
  // Functions

  onChange(DonationX val) {
      optionSelected.value = val;
    Get.back();
  }

  /// A project is only usable as a selection when it has both an id and a
  /// display name. The admin default can come back as an empty shell (id and
  /// name blank) when none is configured, which must NOT be shown.
  bool _isUsable(DonationX? d) =>
      d != null && d.id.isNotEmpty && d.donationBasic.name.trim().isNotEmpty;

  /// Ensure a usable project is pre-selected so the field is never shown empty:
  /// use the admin default zakat when usable, otherwise fall back to the first
  /// zakat project. Does nothing when a usable project is already selected.
  Future<void> ensureDefaultSelected(DonationX? defaultZakat) async {
    if (_isUsable(optionSelected.value)) return;

    if (_isUsable(defaultZakat)) {
      optionSelected.value = defaultZakat;
      return;
    }

    try {
      isLoadingDefault.value = true;
      final List<DonationX> list =
          await DatabaseX.getAllDonations(isZakat: true);
      if (!_isUsable(optionSelected.value) && list.isNotEmpty) {
        optionSelected.value = list.first;
      }
    } catch (_) {
      // No default available; leave the field empty rather than crash.
    } finally {
      isLoadingDefault.value = false;
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
