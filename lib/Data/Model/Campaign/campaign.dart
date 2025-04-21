part of '../../data.dart';

class CampaignX {
  CampaignX({
    required this.id,
    required this.code,
    required this.title,
    required this.notes,
    required this.status,
    required this.donation,
    required this.donationStatus,
    required this.startDate,
    required this.endDate,
    this.link,
    required this.targetAmount,
    required this.statistics,
    required this.remainingDonations,
    required this.totalDonations,
    required this.currentDonations,
    required this.countDonations,
    required this.countDonor,
    required this.completionRate,
    this.statusLocalized,
  });

  final String id;
  final int code;
  final String title;
  // donor
  DonationX donation;
  final String notes;
  final CampaignStatusX status;
  final bool donationStatus;
  final DateTime startDate;
  final DateTime endDate;
  final MiniShareLinkX? link;
  final CampaignStatisticsX statistics;

  final num targetAmount;
  final num currentDonations;
  final num remainingDonations;
  final num totalDonations;
  final int countDonations;
  final int countDonor;
  final double completionRate;

  final String? statusLocalized;

  factory CampaignX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> donationJson =
    Map<String, Object?>.from(json[NameX.project] ?? {});
    Map<String, Object?> linkJson =
    Map<String, Object?>.from(json[NameX.affiliateData] ?? {});
    Map<String, Object?> statisticsJson =
    Map<String, Object?>.from(json[NameX.statistics] ?? {});

    return ModelUtilX.checkFromJson(
      json,
      (json) => CampaignX(
        id: json[NameX.id].toStrDefaultX(''),
        code: json[NameX.code].toIntDefaultX(0),
        title: json[NameX.title].toStrDefaultX(''),
        donation: DonationX.fromJson(donationJson),
        notes: json[NameX.notes].toStrDefaultX(''),
        status: CampaignStatusX.values.firstWhere((x) => x.name==json[NameX.status].toString(),orElse: () => CampaignStatusX.pending,),
        donationStatus: json[NameX.donationStatus].toBoolDefaultX(false),

        link: linkJson.toFromJsonNullableX(MiniShareLinkX.fromJson),
        statistics: CampaignStatisticsX.fromJson(statisticsJson),
        currentDonations: json[NameX.currentDonations].toIntDefaultX(0),
        targetAmount: json[NameX.targetAmount].toIntDefaultX(0),
        totalDonations: json[NameX.totalDonation].toIntDefaultX(0),
        remainingDonations: json[NameX.remainingDonations].toIntDefaultX(0),
        countDonations: json[NameX.countDonations].toIntDefaultX(0),
        countDonor: json[NameX.countDonor].toIntDefaultX(0),
        completionRate: json[NameX.completionRate].toDoubleDefaultX(0),
        startDate: json[NameX.startDate].toDateTimeX,
        endDate: json[NameX.endDate].toDateTimeX,
        statusLocalized: json[NameX.statusLocalized].toStrNullableX,
      ),
    );
  }
}
