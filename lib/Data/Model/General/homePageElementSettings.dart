//
// class HomePageElementSettingsX{
//   HomePageElementSettingsX({
//     this.id,
//     required this.isShowRegisterEmail,
//     required this.isRequiredRegisterName,
//     this.isShowTechnicalSupportIcon = false,
//     required this.isActiveQuickDonation,
//     this.isShowBrowserApplePayMessage = false,
//     this.isShowCountryCodeList = false,
//     this.isActiveProjectSearch = false,
//     this.isActiveComments = false,
//     required this.minimumDonationAmount,
//     required this.productShippingAmount,
//     this.browserApplePayMessage,
//     this.projectCompletionImageUrl,
//   });
//
//   String? id;
//   bool isShowDonations;
//   order donationsOrder;
//   bool isRequiredRegisterName;
//
//   bool isShowTechnicalSupportIcon;
//   bool isActiveQuickDonation;
//   bool isShowBrowserApplePayMessage;
//
//   bool isShowCountryCodeList;
//
//   bool isActiveProjectSearch;
//   bool isActiveComments;
//
//   int minimumDonationAmount;
//   int productShippingAmount;
//
//   String? browserApplePayMessage;
//   String? projectCompletionImageUrl;
//
//   factory GeneralAppSettingsX.fromJson(Map<String, dynamic> json) {
//     Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.projectCompletionImage] ?? {});
//
//     return ModelUtilX.checkFromJson(
//         json,
//             (json) => GeneralAppSettingsX(
//           id: json[NameX.id].toStrNullableX,
//           isShowRegisterEmail: json[NameX.isShowRegisterEmail].toBoolX,
//           isRequiredRegisterName:
//           json[NameX.isRequiredRegisterName].toBoolX,
//           isShowTechnicalSupportIcon:
//           json[NameX.isShowTechnicalSupportIcon].toBoolDefaultX(false),
//           isActiveQuickDonation: json[NameX.isActiveQuickDonation].toBoolX,
//           isShowBrowserApplePayMessage:
//           json[NameX.isShowBrowserApplePayMessage].toBoolDefaultX(false),
//           isShowCountryCodeList:
//           json[NameX.isShowCountryCodeList].toBoolDefaultX(false),
//           isActiveProjectSearch:
//           json[NameX.isActiveProjectSearch].toBoolDefaultX(false),
//           isActiveComments:
//           json[NameX.isActiveComments].toBoolDefaultX(false),
//           minimumDonationAmount:
//           json[NameX.minimumDonationAmount].toIntX,
//           productShippingAmount:
//           json[NameX.productShippingAmount].toIntX,
//           browserApplePayMessage: json[NameX.browserApplePayMessage].toStrNullableX,
//           projectCompletionImageUrl: imageJson[NameX.url].toStrNullableX,
//         ),
//         requiredDataKeys: [
//           NameX.isShowRegisterEmail,
//           NameX.isRequiredRegisterName,
//           NameX.isActiveQuickDonation,
//           NameX.minimumDonationAmount,
//           NameX.productShippingAmount,
//         ]);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       NameX.id: id,
//       NameX.isShowRegisterEmail: isShowRegisterEmail,
//       NameX.isRequiredRegisterName: isRequiredRegisterName,
//       NameX.isShowTechnicalSupportIcon: isShowTechnicalSupportIcon,
//       NameX.isActiveQuickDonation: isActiveQuickDonation,
//       NameX.isShowBrowserApplePayMessage:isShowBrowserApplePayMessage,
//       NameX.isShowCountryCodeList: isShowCountryCodeList,
//       NameX.isActiveProjectSearch: isActiveProjectSearch,
//       NameX.isActiveComments: isActiveComments,
//       NameX.minimumDonationAmount: minimumDonationAmount,
//       NameX.productShippingAmount: productShippingAmount,
//       NameX.browserApplePayMessage: browserApplePayMessage,
//       NameX.projectCompletionImage:{
//         NameX.url:projectCompletionImageUrl,
//       }
//     };
//   }
// }
