import 'package:get/get.dart';

import '../../../../../Config/Translation/translation.dart';
import '../../../../../Data/Enum/linkable_type_status.dart';
import '../../../../../Data/Model/Campaign/campaignDonation.dart';
import '../../../../../Data/data.dart';
import '../../../../../UI/ScreenSheet/Other/Share/shareSheet.dart';
import 'package:intl/date_symbol_data_local.dart';

class MyCampaignDetailsController extends GetxController {
  //============================================================================
  // Injection of required controls

  //============================================================================
  // Variables

  late CampaignX campaign;
  final String codeOrId = Get.arguments.toString();
  //============================================================================
  // Functions

  Future<void> getData() async {
    campaign = num.tryParse(codeOrId) == null
        ? await DatabaseX.getCampaignDetailsById(id: codeOrId)
        : await DatabaseX.getCampaignDetails(code: codeOrId);
  }

  openShare() async {
    await shareSheet(
      id: campaign.id,
      code: campaign.code,
      type: LinkableTypeStatusX.campaign,
    );
  }

  Future<List<CampaignDonationX>> getCampaignDonations(
    ScrollRefreshLoadMoreParametersX data,
  ) async {
    return await DatabaseX.getAllCampaignDonations(
      page: data.page,
      perPage: data.perPage,
      campaignId: campaign.id,
    );
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();
    initializeDateFormatting(TranslationX.getLanguageCode, null);
  }
}
