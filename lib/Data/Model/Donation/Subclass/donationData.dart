import 'package:ataa/Core/Error/error.dart';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Model/Donation/Subclass/donationFamilyAndFriends.dart';

import '../../../../Core/Helper/model/model.dart';
import '../../../Enum/model_donation_data_type_status.dart';
import '../../../data.dart';

class DonationDataX {
  final double price;
  final int? sharesQuantity;
  final String? donationSharesPackageId;
  final String? donationOpenPackageId;
  final String? donationDeductionPackageId;
  final bool donationOnBehalfOfFamilyAndFriends;
  final DonationFamilyAndFriendsX? familyAndFriends;
  final bool isPackagesEnabled;
  final ModelDonationDataTypeStatusX donationType;

  DonationDataX({
    required this.price,
    this.sharesQuantity,
    this.donationSharesPackageId,
    this.donationOpenPackageId,
    this.donationDeductionPackageId,
    required this.donationOnBehalfOfFamilyAndFriends,
    this.familyAndFriends,
    required this.isPackagesEnabled,
    required this.donationType,
  });

  factory DonationDataX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> familyAndFriendsJson = Map<String, Object?>.from(json[NameX.bankAccount] is List ? ((json[NameX.bankAccount] as List).isEmpty?{}:(json[NameX.bankAccount] as List).first): json[NameX.bankAccount] ?? {});
    try{
      return ModelUtilX.checkFromJson(
        json,
            (json) => DonationDataX(
          price: json[NameX.price].toDoubleDefaultX(0),
          sharesQuantity: json[NameX.sharesQuantity].toIntNullableX,
          donationSharesPackageId: json[NameX.donationSharesPackageId].toStrNullableX,
          donationOpenPackageId: json[NameX.donationOpenPackageId].toStrNullableX,
          donationDeductionPackageId: json[NameX.donationDeductionPackageId].toStrNullableX,
          donationOnBehalfOfFamilyAndFriends: json[NameX.donationOnBehalfOfFamilyAndFriends].toBoolDefaultX(false),
          familyAndFriends: familyAndFriendsJson.toFromJsonNullableX(DonationFamilyAndFriendsX.fromJson),
          isPackagesEnabled: json[NameX.isPackagesEnabled].toBoolX,
          donationType: ModelDonationDataTypeStatusX.values.firstWhere((x) => x.name==json[NameX.donationType].toStrX),
        ),
        requiredDataKeys: [
          NameX.price,
          NameX.isPackagesEnabled,
          NameX.donationType,
        ],
      );
    }catch(e){
      e.toErrorX.log();
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.price: price,
      NameX.donationOnBehalfOfFamilyAndFriends: donationOnBehalfOfFamilyAndFriends,
      NameX.familyAndFriends: familyAndFriends,
      NameX.isPackagesEnabled: isPackagesEnabled,
      NameX.donationType: donationType.name,
    };
  }
}