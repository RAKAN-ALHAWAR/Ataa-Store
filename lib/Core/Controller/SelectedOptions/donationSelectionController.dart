import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Data/Model/Donation/donation.dart';
import '../../../Data/data.dart';
import '../../core.dart';

class DonationSelectionControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  Rx<DonationX?> donationSelected = Rx<DonationX?>(null);
  TextEditingController search = TextEditingController();

  /// Full campaign-eligible list as returned by the endpoint on the first page.
  List<DonationX> _projects = [];

  //============================================================================
  // Functions

  Future<List<DonationX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    /// `projects/show_campaign` returns the whole list on the first page and
    /// already excludes completed projects. Any later page would just repeat
    /// the same list, so return nothing to end the pagination cleanly.
    if (data.page > 1) return [];

    _projects = await DatabaseX.getAllDonationInCampaign();

    /// The endpoint ignores the server search param, so filter locally by name.
    final String query = _normalizeForSearch(data.searchQuery ?? '');
    if (query.isEmpty) return _projects;

    return _projects
        .where((d) => _normalizeForSearch(d.donationBasic.name).contains(query))
        .toList();
  }

  /// Arabic-aware normalization for the local search (strip diacritics and
  /// unify alef, alef-maqsura and ta-marbuta so matches are forgiving).
  String _normalizeForSearch(String input) {
    return input
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[ً-ْ]'), '')
        .replaceAll(RegExp(r'[أإآ]'), 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ة', 'ه');
  }

  /// Erase all data and return it to its default state
  clearData() {
    donationSelected.value = null;
    search.text = "";
  }

  onChange(DonationX? val){
    donationSelected.value = val;
    Get.back();
  }
}
