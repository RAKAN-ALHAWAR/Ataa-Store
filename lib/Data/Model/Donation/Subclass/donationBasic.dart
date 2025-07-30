import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationBasicX {
  final int code;
  final String name;
  
  final bool isDefaultZakat;
  
  final int order; // don't know
  final bool status; // don't know

  final num currentDonations;
  final num remainingDonations;
  final num totalDonations;
  final int countDonations;
  final int countDonor;
  final double completionRate;

  DonationBasicX({
    required this.code,
    required this.name,
    required this.isDefaultZakat,
    required this.order,
    required this.status,
    required this.currentDonations,
    required this.remainingDonations,
    required this.totalDonations,
    required this.countDonations,
    required this.countDonor,
    required this.completionRate,
  });

  bool get isDone=> completionRate>=100;

  factory DonationBasicX.fromJson(Map<String, dynamic> json) {
      return ModelUtilX.checkFromJson(
        json,
            (json) => DonationBasicX(
          code: json[NameX.code].toIntDefaultX(0),
          name: json[NameX.donationName].toStrDefaultX(''),

          isDefaultZakat: json[NameX.isDefaultZakat].toBoolDefaultX(false),

          order: json[NameX.order].toIntDefaultX(0),
          status: json[NameX.status].toBoolDefaultX(true),

          currentDonations: json[NameX.currentDonations].toIntDefaultX(0),
          totalDonations: json[NameX.totalDonations].toIntDefaultX(0),
          remainingDonations: json[NameX.remainingDonations].toIntDefaultX(0),
          countDonations: json[NameX.countDonations].toIntDefaultX(0),
          countDonor: json[NameX.countDonor].toIntDefaultX(0),
          completionRate: json[NameX.completionRate].toDoubleDefaultX(0),
        ),
      );
  }
  
  Map<String, dynamic> toJson() {
    return {
      NameX.code:code,
      NameX.donationName:name,
      NameX.isDefaultZakat:isDefaultZakat.toIntX,
      NameX.currentDonations:currentDonations,
      NameX.totalDonations:totalDonations,
      NameX.remainingDonations:remainingDonations,
      NameX.countDonations:countDonations,
      NameX.countDonor:countDonor,
      NameX.completionRate:completionRate,
    };
  }
}