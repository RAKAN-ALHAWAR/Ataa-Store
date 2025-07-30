part of '../../data.dart';

class GeneralAppSettingsX{
  GeneralAppSettingsX({
    this.id,
    required this.isShowRegisterEmail,
    required this.isRequiredRegisterName,
    this.isShowTechnicalSupportIcon = false,
    required this.isActiveQuickDonation,
    this.isShowBrowserApplePayMessage = false,
    this.isShowCountryCodeList = false,
    this.isActiveDonationSearch = false,
    this.isActiveDeductionSearch = false,
    this.isActiveCampaignSearch = false,
    this.isActiveComments = false,
    required this.minimumDonationAmount,
    required this.minimumDeductionAmount,
    required this.productShippingAmount,
    this.browserApplePayMessage,
    this.projectCompletionImageUrl,
    required this.defaultCountryCode,
    this.defaultQuickDonation,
    this.defaultZakat,
    this.campaignTargetAmounts=const[],
    this.campaignApprovalStatus,
  });

  String? id;
  bool isShowRegisterEmail;
  bool isRequiredRegisterName;

  bool isShowTechnicalSupportIcon;
  bool isActiveQuickDonation;
  bool isShowBrowserApplePayMessage;

  bool isShowCountryCodeList;

  bool isActiveDonationSearch;
  bool isActiveDeductionSearch;
  bool isActiveCampaignSearch;
  bool isActiveComments;

  int minimumDonationAmount;
  int minimumDeductionAmount;
  int productShippingAmount;

  String? browserApplePayMessage;
  String? projectCompletionImageUrl;

  int defaultCountryCode;
  DonationX? defaultQuickDonation;
  DonationX? defaultZakat;

  List<num> campaignTargetAmounts;
  String? campaignApprovalStatus;

  factory GeneralAppSettingsX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.projectCompletionImage] ?? {});
    Map<String, Object?> defaultQuickDonationJson = Map<String, Object?>.from(json[NameX.defaultQuickDonation] ?? {});
    Map<String, Object?> defaultZakatJson = Map<String, Object?>.from(json[NameX.defaultZakat] ?? {});

    return ModelUtilX.checkFromJson(
        json,
            (json) => GeneralAppSettingsX(
          id: json[NameX.id].toStrNullableX,
          isShowRegisterEmail: json[NameX.isShowRegisterEmail].toBoolX,
          isRequiredRegisterName:
          json[NameX.isRequiredRegisterName].toBoolX,
          isShowTechnicalSupportIcon:
          json[NameX.isShowTechnicalSupportIcon].toBoolDefaultX(false),
          isActiveQuickDonation: json[NameX.isActiveQuickDonation].toBoolX,
          isShowBrowserApplePayMessage:
          json[NameX.isShowBrowserApplePayMessage].toBoolDefaultX(false),
          isShowCountryCodeList:
          json[NameX.isShowCountryCodeList].toBoolDefaultX(false),
          isActiveDonationSearch:
          json[NameX.isActiveProjectSearch].toBoolDefaultX(false),
          isActiveDeductionSearch:
          json[NameX.isActiveDeductionSearch].toBoolDefaultX(false),
          isActiveCampaignSearch:
          json[NameX.isActiveCampaignSearch].toBoolDefaultX(false),
          isActiveComments:
          json[NameX.isActiveComments].toBoolDefaultX(false),
          minimumDonationAmount: json[NameX.minimumDonationAmount].toIntX,
          minimumDeductionAmount: json[NameX.minimumDeductionAmount].toIntX,
          productShippingAmount: json[NameX.productShippingAmount].toIntX,
          browserApplePayMessage: json[NameX.browserApplePayMessage].toStrNullableX,
          projectCompletionImageUrl: imageJson[NameX.url].toStrNullableX,
          defaultCountryCode: json[NameX.defaultCountryCode].toIntDefaultX(966),
          defaultQuickDonation: DonationX.fromJson(defaultQuickDonationJson),
          defaultZakat: DonationX.fromJson(defaultZakatJson),
          campaignTargetAmounts: List<num>.from((json[NameX.campaignTargetAmounts]??[]) as List),
          campaignApprovalStatus: json[NameX.campaignApprovalStatus].toStrNullableX,
        ),
        requiredDataKeys: [
          NameX.isShowRegisterEmail,
          NameX.isRequiredRegisterName,
          NameX.isActiveQuickDonation,
          NameX.minimumDonationAmount,
          NameX.minimumDeductionAmount,
          NameX.productShippingAmount,
        ]);
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.isShowRegisterEmail: isShowRegisterEmail,
      NameX.isRequiredRegisterName: isRequiredRegisterName,
      NameX.isShowTechnicalSupportIcon: isShowTechnicalSupportIcon,
      NameX.isActiveQuickDonation: isActiveQuickDonation,
      NameX.isShowBrowserApplePayMessage:isShowBrowserApplePayMessage,
      NameX.isShowCountryCodeList: isShowCountryCodeList,
      NameX.isActiveProjectSearch: isActiveDonationSearch,
      NameX.isActiveDeductionSearch: isActiveDeductionSearch,
      NameX.isActiveCampaignSearch: isActiveCampaignSearch,
      NameX.isActiveComments: isActiveComments,
      NameX.minimumDonationAmount: minimumDonationAmount,
      NameX.minimumDeductionAmount: minimumDeductionAmount,
      NameX.productShippingAmount: productShippingAmount,
      NameX.browserApplePayMessage: browserApplePayMessage,
      NameX.defaultCountryCode: defaultCountryCode,
      NameX.campaignTargetAmounts: campaignTargetAmounts,
      NameX.campaignApprovalStatus: campaignApprovalStatus,
      NameX.defaultQuickDonation: defaultQuickDonation?.toJson(),
      NameX.defaultZakat: defaultZakat?.toJson(),
      NameX.projectCompletionImage:{
        NameX.url:projectCompletionImageUrl,
      }
    };
  }
}
