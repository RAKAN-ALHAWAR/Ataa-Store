import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class ShareLinkStatisticsX {
  ShareLinkStatisticsX({
    required this.countLinks,
    required this.countNewRegistrationsViaLinks,
    required this.countDonationsViaLinks,
    required this.countLinkVisits,
    required this.totalAmountDonationsViaLinks,
  });

  int countLinks;
  int countNewRegistrationsViaLinks;
  int countDonationsViaLinks;
  int countLinkVisits;
  double totalAmountDonationsViaLinks;

  factory ShareLinkStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => ShareLinkStatisticsX(
              countLinks: json[NameX.countLinks].toIntX,
              countNewRegistrationsViaLinks: json[NameX.countNewRegistrationsViaLinks].toIntX,
              countDonationsViaLinks: json[NameX.countDonationsViaLinks].toIntX,
              countLinkVisits: json[NameX.countLinkVisits].toIntX,
              totalAmountDonationsViaLinks: json[NameX.totalAmountDonationsViaLinks].toDoubleX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.countLinks,
            NameX.countNewRegistrationsViaLinks,
            NameX.countDonationsViaLinks,
            NameX.countLinkVisits,
            NameX.totalAmountDonationsViaLinks,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.countLinks: countLinks,
      NameX.countNewRegistrationsViaLinks: countNewRegistrationsViaLinks,
      NameX.countDonationsViaLinks: countDonationsViaLinks,
      NameX.countLinkVisits: countLinkVisits,
      NameX.totalAmountDonationsViaLinks: totalAmountDonationsViaLinks,
    };
  }
}
