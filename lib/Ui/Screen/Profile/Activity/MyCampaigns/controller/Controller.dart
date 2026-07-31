import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Data/Enum/campaign_status.dart';
import '../../../../../../Data/Enum/linkable_type_status.dart';
import '../../../../../../Data/data.dart';
import '../../../../../../UI/ScreenSheet/Other/Share/shareSheet.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../ScreenSheet/Other/EditCampaign/editCampaignSheet.dart';
import '../../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';

class MyCampaignsController extends GetxController {
  //============================================================================
  // Variables

  bool isLoading = false;
  GlobalKey<ScrollRefreshLoadMoreXState<CampaignX>> scrollRefreshLoadMoreKey =
      GlobalKey<ScrollRefreshLoadMoreXState<CampaignX>>();

  //============================================================================
  // Functions

  Future<List<CampaignX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    return await DatabaseX.getMyCampaigns(
      page: data.page,
      perPage: data.perPage,
    );
  }

  createCampaign() async {
    await Get.toNamed(RouteNameX.createCampaign);
    scrollRefreshLoadMoreKey.currentState?.refresh();
  }

  onTapCampaign(CampaignX campaign) {
    if (campaign.status != CampaignStatusX.accepted) {
      Get.toNamed(RouteNameX.myCampaignDetails, arguments: campaign.id);
    } else {
      Get.toNamed(RouteNameX.myCampaignDetails, arguments: campaign.code);
    }
  }

  onEdit(CampaignX campaign) async {
    if (!isLoading) {
      isLoading = true;
      update();
      try {
        var newCampaign = await editCampaignSheet(campaign);
        if (newCampaign != null) {
          scrollRefreshLoadMoreKey.currentState?.updateItemByCondition(
            (x) => x.id == campaign.id,
            newCampaign,
          );
        }
      } catch (e) {
        ToastX.error(message: e.toString());
      }
      isLoading = false;
      update();
    }
  }

  openShare(CampaignX campaign) async {
    await shareSheet(
      id: campaign.id,
      code: campaign.code,
      type: LinkableTypeStatusX.campaign,
    );
  }
}
