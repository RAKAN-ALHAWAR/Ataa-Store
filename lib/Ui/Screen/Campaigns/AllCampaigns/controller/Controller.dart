import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Sort/sortByGeneralController.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../ScreenSheet/Other/MandatoryAuth/mandatoryAuth.dart';
import '../../../../ScreenSheet/Pay/PayDonation/payDonationSheet.dart';
import '../../../../ScreenSheet/Sort/SortByGeneral/sortByGeneral.dart';

class AllCampaignsController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AppControllerX app = Get.find();
  SortByGeneralControllerX sortByGeneralController= Get.put(SortByGeneralControllerX(),tag: "All Campaigns");
  //============================================================================
  // Variables

  TextEditingController search = TextEditingController();
  ScrollController scrollController = ScrollController();

  //============================================================================
  // Functions

  Future<List<CampaignX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    try {
      List<CampaignX> results = await DatabaseX.getCampaignsBySearch(
        page: data.page,
        perPage: data.perPage,
        sortType: data.orderBy,
        searchQuery: data.searchQuery,
      );
      return results;
    } catch (e) {
      return Future.error(e);
    }
  }

  //----------------------------------------------------------------------------
  // Search & Filter

  onFilter() async {
    await sortByGeneralSheetX(controller: sortByGeneralController);
  }

  //----------------------------------------------------------------------------

  onTapCampaign(CampaignX campaign) =>
      Get.toNamed(RouteNameX.campaignDetails, arguments: campaign.code);

  onCampaignDonation(CampaignX campaign) async {
    await payDonationSheet(campaign.donation,campaign:campaign);
  }

  onAddToCart(CampaignX campaign) async {
    await payDonationSheet(campaign.donation,campaign:campaign, onlyAddToCart: true);
  }

  createCampaign(){
    if(app.isLogin.value){
      Get.toNamed(RouteNameX.createCampaign);
    }else{
      mandatoryAuthSheetX();
    }
  }

}
