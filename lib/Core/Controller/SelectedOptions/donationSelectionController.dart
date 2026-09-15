import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../Data/data.dart';
import '../../core.dart';

/// Where the donation selection sheet pulls its list from.
enum DonationSelectionSourceX {
  /// All active donation projects (projects/search), paginated + server search.
  allDonations,

  /// Only campaign-eligible projects (projects/show_campaign): the backend
  /// already excludes completed projects.
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

  Rx<DonationX?> donationSelected = Rx<DonationX?>(null);
  TextEditingController search = TextEditingController();

  //============================================================================
  // Functions

  Future<List<DonationX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    if (source == DonationSelectionSourceX.campaign) {
      return await DatabaseX.getAllDonationInCampaign(
        page: data.page,
        perPage: data.perPage,
        searchQuery: data.searchQuery,
      );
    }
    return await DatabaseX.getDonationsBySearch(
      page: data.page,
      perPage: data.perPage,
      searchQuery: data.searchQuery,
    );
  }

  /// Erase all data and return it to its default state
  clearData() {
    donationSelected.value = null;
    search.text = "";
  }

  onChange(DonationX? val) {
    donationSelected.value = val;
    Get.back();
  }
}
