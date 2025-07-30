import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class MyCampaignStatisticsX {
  MyCampaignStatisticsX({
    required this.campaignCount,
    required this.totalAmountCampaign,
    required this.donorCount,
    required this.countVisits,
    required this.registrationsCount,
    required this.donationCount,
  });

  int campaignCount;
  num totalAmountCampaign;
  int donorCount;
  int countVisits;
  int registrationsCount;
  int donationCount;


  factory MyCampaignStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => MyCampaignStatisticsX(
              campaignCount: json[NameX.campaignCount].toIntX,
              totalAmountCampaign: json[NameX.donationAmount].toDoubleX,
              donorCount: json[NameX.donorCount].toIntX,
              countVisits: json[NameX.countCampaignVisits].toIntX,
              registrationsCount: json[NameX.registrationsCount].toIntX,
              donationCount: json[NameX.donationCount].toIntX,
        ),
    );
  }
}
