import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class CampaignStatisticsX {
  CampaignStatisticsX({
    required this.visits,
    required this.registrations,
    required this.logins,
    required this.donationsCount,
    required this.donorsCount,
    required this.donationsSum,
  });

  int visits;
  int registrations;
  int logins;
  int donationsCount;
  int donorsCount;
  num donationsSum;


  factory CampaignStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => CampaignStatisticsX(
              visits: json[NameX.visits].toIntDefaultX(0),
              registrations: json[NameX.registrations].toIntDefaultX(0),
              logins: json[NameX.logins].toIntDefaultX(0),
              donationsCount: json[NameX.donationsCount].toIntDefaultX(0),
              donorsCount: json[NameX.donorsCount].toIntDefaultX(0),
              donationsSum: json[NameX.donationsSum].toIntDefaultX(0),
        ),
    );
  }
}
