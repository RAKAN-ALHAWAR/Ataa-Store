import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../data.dart';
import 'Package/donationDeductionPackage.dart';
import 'Package/donationOpenPackage.dart';
import 'Shares/donationShares.dart';
import 'Shares/donationSharesPackage.dart';
import 'Subclass/donationBasic.dart';
import 'Subclass/donationCategory.dart';
import 'Subclass/donationDetails.dart';
import 'Subclass/donationSettings.dart';
import 'Subclass/donationType.dart';

class DonationX {
  final String id;
  final DonationBasicX donationBasic;
  final DonationDetailsX donationDetails;
  final DonationSettingsX donationSettings;
  final List<DonationCategoryX> categories;

  final DonationTypeX? donationType;
  final bool isShowPackages;
  final bool isCanEditAmount;
  final DonationSharesX? donationShares;
  final List<DonationSharesPackageX> sharesPackages;
  final List<DonationOpenPackageX> openPackages;
  final List<DonationDeductionPackageX> donationDeductionPackages;

  DonationX({
    required this.id,
    required this.donationBasic,
    required this.donationDetails,
    required this.donationSettings,
    required this.categories,
    this.donationType,
    required this.isShowPackages,
    required this.isCanEditAmount,
    this.donationShares,
    this.sharesPackages = const [],
    required this.openPackages,
    required this.donationDeductionPackages,
  });

  factory DonationX.fromJson(Map<String, dynamic> json) {
      Map<String, Object?> donationBasicJson =
          Map<String, Object?>.from(json[NameX.donationBasic] ?? {});
      Map<String, Object?> donationDetailsJson =
          Map<String, Object?>.from(json[NameX.donationDetails] ?? {});
      Map<String, Object?> donationSettingsJson =
          Map<String, Object?>.from(json[NameX.donationSettings] ?? {});
      Map<String, Object?> donationTypeDetailsJson =
          Map<String, Object?>.from(json[NameX.donationTypeDetails] ?? {});
      Map<String, Object?> donationTypeJson = Map<String, Object?>.from(
          (donationTypeDetailsJson[NameX.donationType] ?? {}) as Map);
      Map<String, Object?> donationShareJson = Map<String, Object?>.from(
          (donationTypeDetailsJson[NameX.donationShares] ?? {}) as Map);


      Map<String, dynamic> donationTypeDetailsJsonAsMapDynamic = Map<String, dynamic>.from(donationTypeDetailsJson);


      List<Map<String, dynamic>> donationSharesPackagesJsonList = List<Map<String, dynamic>>.from((donationTypeDetailsJson[NameX.donationSharesPackages] is! List ? ((donationTypeDetailsJsonAsMapDynamic[NameX.donationSharesPackages]?[NameX.data]!=null)?(donationTypeDetailsJsonAsMapDynamic[NameX.donationSharesPackages][NameX.data]):[]) : donationTypeDetailsJson[NameX.donationSharesPackages]) as List);

      List<Map<String, dynamic>> donationDeductionPackagesJsonList =
      List<Map<String, dynamic>>.from((donationTypeDetailsJson[NameX.donationDeductionPackages] is! List ? ((donationTypeDetailsJsonAsMapDynamic[NameX.donationDeductionPackages]?[NameX.data]!=null)?(donationTypeDetailsJsonAsMapDynamic[NameX.donationDeductionPackages][NameX.data]):[]) : donationTypeDetailsJson[NameX.donationDeductionPackages]) as List);

      List<Map<String, dynamic>> donationOpenPackagesJsonList =
      List<Map<String, dynamic>>.from((donationTypeDetailsJson[NameX.donationOpenPackages] is! List ? ((donationTypeDetailsJsonAsMapDynamic[NameX.donationOpenPackages]?[NameX.data]!=null)?(donationTypeDetailsJsonAsMapDynamic[NameX.donationOpenPackages][NameX.data]):[]): donationTypeDetailsJson[NameX.donationOpenPackages]) as List);

      List<Map<String, dynamic>> categoriesJsonList = List<Map<String, dynamic>>.from((json[NameX.donationCategories] is List ? json[NameX.donationCategories] : ((json[NameX.donationCategories]?[NameX.data]!=null)?(json[NameX.donationCategories][NameX.data]):[]))
          .map((item) => (item as Map).map(
            (key, value) => MapEntry(key.toString(), value),
      )).toList());

      return ModelUtilX.checkFromJson(
        json,
        (json) => DonationX(
          id: json[NameX.id].toStrDefaultX(''),
          donationBasic: DonationBasicX.fromJson(donationBasicJson),
          donationDetails: DonationDetailsX.fromJson(donationDetailsJson),
          donationSettings: DonationSettingsX.fromJson(donationSettingsJson),
          categories: categoriesJsonList.map((json) => DonationCategoryX.fromJson(json)).toList(),
          donationType: donationTypeJson.toFromJsonNullableX(DonationTypeX.fromJson),

          isShowPackages: donationTypeDetailsJson[NameX.isShowPackages].toBoolDefaultX(false),
          isCanEditAmount: donationTypeDetailsJson[NameX.isCanEditAmount].toBoolDefaultX(false),

          donationShares:donationShareJson.toFromJsonNullableX(DonationSharesX.fromJson),
          sharesPackages: donationSharesPackagesJsonList.map((json) => DonationSharesPackageX.fromJson(json)).toList(),
          donationDeductionPackages: donationDeductionPackagesJsonList.map((json) => DonationDeductionPackageX.fromJson(json)).toList(),
          openPackages: donationOpenPackagesJsonList.map((json) => DonationOpenPackageX.fromJson(json)).toList(),
        ),
      );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.donationBasic: donationBasic.toJson(),
      NameX.donationDetails: donationDetails.toJson(),
      NameX.donationSettings: donationSettings.toJson(),
      NameX.donationCategories: [...categories.map((category) => category.toJson())],
      NameX.donationTypeDetails: {
        NameX.donationType: donationType?.toJson(),
        NameX.isShowPackages: isShowPackages,
        NameX.isCanEditAmount: isCanEditAmount,
        NameX.donationShares: donationShares?.toJson(),
        NameX.donationSharesPackages:
            sharesPackages.map((package) => package.toJson()).toList(),
        NameX.donationDeductionPackages: donationDeductionPackages
            .map((package) => package.toJson())
            .toList(),
        NameX.donationOpenPackages:
            openPackages.map((package) => package.toJson()).toList(),
      },
    };
  }
}
