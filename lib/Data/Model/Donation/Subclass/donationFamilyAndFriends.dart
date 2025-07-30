import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationFamilyAndFriendsX {
  String donorName;
  String recipientName;
  late int recipientMobile;
  int? recipientCountryCode;
  int? recipientPhoneWithoutCountry;

  DonationFamilyAndFriendsX({
    required this.donorName,
    required this.recipientName,
    int? recipientMobile,
    this.recipientCountryCode,
    this.recipientPhoneWithoutCountry,
  }){
    this.recipientMobile = recipientMobile??'$recipientCountryCode$recipientPhoneWithoutCountry'.toIntX;
  }

  factory DonationFamilyAndFriendsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationFamilyAndFriendsX(
            donorName: json[NameX.donorName].toStrX,
            recipientName: json[NameX.recipientName].toStrX,
            recipientMobile: json[NameX.recipientMobile].toIntX,
      ),
      requiredDataKeys: [
        NameX.donorName,
        NameX.recipientName,
        NameX.recipientMobile,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.donorName: donorName,
      NameX.recipientName: recipientName,
      NameX.recipientMobile: recipientMobile,
    };
  }
}