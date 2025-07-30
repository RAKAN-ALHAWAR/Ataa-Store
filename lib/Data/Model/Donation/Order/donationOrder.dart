import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/model_type_status.dart';
import 'package:ataa/Data/Model/Donation/Subclass/donationBasic.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';
import '../Package/donationDeductionPackage.dart';
import '../Package/donationOpenPackage.dart';
import '../Shares/donationShares.dart';
import '../Shares/donationSharesPackage.dart';
import '../Subclass/donationData.dart';
import '../Subclass/donationType.dart';

class DonationOrderX extends OrderX {
  final int? code;
  final String status;
  final String? statusLocalized;
  final DonationDataX donationData;
  final DonationBasicX? donationBasic;
  final DonationTypeX? donationType;
  final bool isShowPackages;
  final bool isCanEditAmount;
  final DonationSharesX? donationShares;
  final List<DonationSharesPackageX> sharesPackages;
  final List<DonationOpenPackageX> openPackages;
  final List<DonationDeductionPackageX> donationDeductionPackages;

  DonationOrderX({
    required super.modelId,
    required super.modelType,
    required super.createdAt,
    required this.status,
    required this.statusLocalized,
    required this.donationData,
    required this.code,
    required this.donationBasic,
    this.donationType,
    this.isShowPackages = false,
    this.isCanEditAmount = false,
    this.donationShares,
    this.sharesPackages = const [],
    this.openPackages = const [],
    this.donationDeductionPackages = const [],
  });

  factory DonationOrderX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> donationJson = Map<String, Object?>.from(json[NameX.project] ?? {});
    Map<String, Object?> donationBasicJson = Map<String, Object?>.from((donationJson[NameX.donationBasic] ?? {})as Map);
    Map<String, Object?> donationDataJson = Map<String, Object?>.from(json[NameX.donationData] ?? {});
    Map<String, Object?> donationTypeDetailsJson = Map<String, Object?>.from((donationJson[NameX.donationTypeDetails] ?? {}) as Map);
    Map<String, Object?> donationTypeJson = Map<String, Object?>.from((donationTypeDetailsJson[NameX.donationType] ?? {}) as Map);
    Map<String, Object?> donationShareJson = Map<String, Object?>.from((donationTypeDetailsJson[NameX.donationShares] ?? {}) as Map);
    List<Map<String, dynamic>> donationSharesPackagesJsonList = ((donationTypeDetailsJson[NameX.donationSharesPackages] ?? [])as List)
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();
    List<Map<String, dynamic>> donationDeductionPackagesJsonList = ((donationTypeDetailsJson[NameX.donationDeductionPackages] ?? [])as List)
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();
    List<Map<String, dynamic>> donationOpenPackagesJsonList = ((donationTypeDetailsJson[NameX.donationOpenPackages] ?? [])as List)
        .map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e))
        .toList();

    return ModelUtilX.checkFromJson(
      json,
      (json) => DonationOrderX(
        modelId: json[NameX.id].toStrX,
        modelType: ModelTypeStatusX.donation,
        status: json[NameX.status].toStrX,
        statusLocalized: json[NameX.statusLocalized].toStrNullableX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        code: json[NameX.code].toIntNullableX,
        donationData: DonationDataX.fromJson(donationDataJson),
        donationBasic: donationBasicJson.toFromJsonNullableX(DonationBasicX.fromJson) ?? donationJson.toFromJsonNullableX(DonationBasicX.fromJson),
        donationType: donationTypeJson.toFromJsonNullableX(DonationTypeX.fromJson),
        isShowPackages: donationTypeDetailsJson[NameX.isShowPackages].toBoolDefaultX(false),
        isCanEditAmount: donationTypeDetailsJson[NameX.isCanEditAmount].toBoolDefaultX(false),
        donationShares: donationShareJson.toFromJsonNullableX(DonationSharesX.fromJson),
        sharesPackages: donationSharesPackagesJsonList.map((json) => DonationSharesPackageX.fromJson(json)).toList(),
        donationDeductionPackages: donationDeductionPackagesJsonList.map((json) => DonationDeductionPackageX.fromJson(json)).toList(),
        openPackages: donationOpenPackagesJsonList.map((json) => DonationOpenPackageX.fromJson(json)).toList(),
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.status,
        NameX.code,
        NameX.donationData,
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      NameX.id: modelId,
      NameX.modelType: modelType.name,
      NameX.status: status,
      NameX.statusLocalized: statusLocalized,
      NameX.createdAt: createdAt,
      NameX.code: code,
      NameX.project: {
        NameX.donationData: donationData.toJson(),
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
      },
      NameX.donationBasic: donationBasic?.toJson(),
    };
  }
}
