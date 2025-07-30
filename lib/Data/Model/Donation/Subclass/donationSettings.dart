import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationSettingsX{
  DonationSettingsX({
    required this.isShowHome,
    required this.isShowDonationsPercentage,
    required this.isShowCompletionIndicator,
    required this.isShowGifting,
    required this.isZakat,
    required this.isShowDonorsCount,
  });

  late bool isShowHome;
  late bool isShowDonationsPercentage;
  late bool isShowCompletionIndicator;
  late bool isShowGifting;
  late bool isZakat;
  late bool isShowDonorsCount;

  factory DonationSettingsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationSettingsX(
            isShowHome: json[NameX.isShowHome].toBoolDefaultX(false),
            isShowDonationsPercentage: json[NameX.isShowDonationsPercentage] .toBoolDefaultX(false),
            isShowCompletionIndicator: json[NameX.isShowCompletionIndicator] .toBoolDefaultX(false),
            isShowGifting: json[NameX.isShowGifting] .toBoolDefaultX(false),
            isZakat: json[NameX.isZakat] .toBoolDefaultX(false),
            isShowDonorsCount: json[NameX.isShowDonorsCount] .toBoolDefaultX(false),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.isShowHome: isShowHome,
      NameX.isShowDonationsPercentage: isShowDonationsPercentage,
      NameX.isShowCompletionIndicator: isShowCompletionIndicator,
      NameX.isShowGifting: isShowGifting,
      NameX.isZakat: isZakat,
      NameX.isShowDonorsCount: isShowDonorsCount,
    };
  }
}