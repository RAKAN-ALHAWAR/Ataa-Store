import '../../data.dart';

class CampaignFormX {
  final String title;
  final String donationId;
  final num targetAmount;

  CampaignFormX({
    required this.title,
    required this.donationId,
    required this.targetAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.title: title.trim(),
      NameX.donationId: donationId,
      NameX.price: targetAmount,
    };
  }
}
