import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class DonationStatisticsX {
  DonationStatisticsX({
    required this.countOfDonations,
    required this.countCompletedDonations,
    required this.countProjectDonations,
    required this.totalAmountDonation,
  });

  int countOfDonations;
  int countCompletedDonations;
  int countProjectDonations;
  double totalAmountDonation;


  factory DonationStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => DonationStatisticsX(
              countOfDonations: json[NameX.countOfDonations].toIntX,
              countCompletedDonations: json[NameX.countCompletedDonations].toIntX,
              countProjectDonations: json[NameX.countProjectDonations].toIntX,
              totalAmountDonation: json[NameX.totalAmountDonation].toDoubleX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.countOfDonations,
            NameX.countCompletedDonations,
            NameX.countProjectDonations,
            NameX.totalAmountDonation,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.countOfDonations: countOfDonations,
      NameX.countCompletedDonations: countCompletedDonations,
      NameX.countProjectDonations: countProjectDonations,
      NameX.totalAmountDonation: totalAmountDonation,
    };
  }
}
