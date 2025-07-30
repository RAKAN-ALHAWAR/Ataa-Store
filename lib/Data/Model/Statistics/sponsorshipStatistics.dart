import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class SponsorshipStatisticsX {
  SponsorshipStatisticsX({
    required this.countSponsorships,
    required this.totalAmountSponsorships,
  });

  int countSponsorships;
  double totalAmountSponsorships;


  factory SponsorshipStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => SponsorshipStatisticsX(
              countSponsorships: json[NameX.countSponsorships].toIntX,
              totalAmountSponsorships: json[NameX.totalAmountSponsorships].toDoubleX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.countSponsorships,
            NameX.totalAmountSponsorships,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.countSponsorships: countSponsorships,
      NameX.totalAmountSponsorships: totalAmountSponsorships,
    };
  }
}
