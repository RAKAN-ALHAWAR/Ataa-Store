import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../Data/data.dart';
import '../../core.dart';

/// Where the donation selection sheet pulls its list from.
enum DonationSelectionSourceX {
  /// All active donation projects, paginated with server-side search.
  allDonations,

  /// Only campaign-eligible projects (`projects/show_campaign`): the full list
  /// at once, already excluding completed projects, searched locally.
  campaign,
}

class DonationSelectionControllerX extends GetxController {
  //============================================================================
  // GetX tags (each use-case is isolated: Get.put keeps the first instance
  // registered under a key, so campaign and share-link must not share one).

  static const String campaignTag = 'campaign_project_selection';

  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();

  //============================================================================
  // Variables

  /// The list this sheet is bound to.
  final DonationSelectionSourceX source;

  DonationSelectionControllerX({
    this.source = DonationSelectionSourceX.allDonations,
  });

  bool get isCampaignSource => source == DonationSelectionSourceX.campaign;

  Rx<DonationX?> donationSelected = Rx<DonationX?>(null);
  TextEditingController search = TextEditingController();

  //============================================================================
  // Campaign source: full list loaded once, searched instantly on-device

  final RxList<DonationX> _campaignProjects = <DonationX>[].obs;
  final RxBool isCampaignLoading = false.obs;
  final RxnString campaignError = RxnString();
  final RxString query = ''.obs;

  /// Projects filtered by the current local query (campaign source only).
  List<DonationX> get campaignResults {
    final String normalizedQuery = _normalizeForSearch(query.value);
    if (normalizedQuery.isEmpty) return _campaignProjects;
    return _campaignProjects
        .where(
          (d) =>
              _normalizeForSearch(d.donationBasic.name).contains(normalizedQuery),
        )
        .toList();
  }

  Future<void> loadCampaignProjects() async {
    try {
      isCampaignLoading.value = true;
      campaignError.value = null;
      final List<DonationX> data = await DatabaseX.getAllDonationInCampaign();
      _campaignProjects.assignAll(data);
    } catch (error) {
      campaignError.value = error.toString();
    } finally {
      isCampaignLoading.value = false;
    }
  }

  //============================================================================
  // All-donations source: paginated list with server-side search

  Future<List<DonationX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    return await DatabaseX.getDonationsBySearch(
      page: data.page,
      perPage: data.perPage,
      searchQuery: data.searchQuery,
    );
  }

  //============================================================================
  // Functions

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
    query.value = "";
  }

  onChange(DonationX? val) {
    donationSelected.value = val;
    Get.back();
  }
}
