import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Model/Gift/Subclass/giftBasic.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../Enum/model_type_status.dart';
import '../../../Enum/send_status_status.dart';
import '../../../data.dart';
import '../../PaymentTransaction/paymentTransactionItem.dart';
import '../Subclass/giftCategoryMini.dart';

class GiftOrderX extends OrderX {
  final int? code;
  final String status;
  final String? statusLocalized;
  final GiftCategoryMiniX giftCategory;
  final GiftBasicX giftBasic;
  final String? organizationId;
  final OrganizationX? organization;
  final PaymentTransactionItemX? paymentTransactionItem;
  final SendStatusStatusX sendStatus;
  final String? sendStatusLocalized;
  final bool isShowPrice;
  final String? giftUrl;
  final String? giftUrlShort;

  GiftOrderX({
    required super.modelId,
    required super.modelType,
    required this.status,
    required this.statusLocalized,
    required super.createdAt,
    required this.code,
    required this.giftCategory,
    required this.giftBasic,
    this.organizationId,
    this.organization,
    this.paymentTransactionItem,
    required this.sendStatus,
    this.sendStatusLocalized,
    this.isShowPrice=false,
    this.giftUrl,
    this.giftUrlShort,
  });

  factory GiftOrderX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> giftCategoryJson = Map<String, Object?>.from(json[NameX.giftCategory] ?? {});
    Map<String, Object?> organizationJson = Map<String, Object?>.from(json[NameX.donationCategory] ?? {});
    Map<String, Object?> paymentTransactionItemJson = Map<String, Object?>.from(json[NameX.paymentTransactionItem] ?? {});

    return ModelUtilX.checkFromJson(
      json,
      (json) => GiftOrderX(
        modelId: json[NameX.id].toStrX,
        modelType: ModelTypeStatusX.gift,
        status: json[NameX.status].toStrX,
        statusLocalized: json[NameX.statusLocalized].toStrNullableX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        code: json[NameX.code].toIntNullableX,
        giftCategory: GiftCategoryMiniX.fromJson(giftCategoryJson),
        giftBasic: GiftBasicX.fromJson(json),
        organizationId: json[NameX.donationCategoryId].toStrNullableX,
        organization: organizationJson.toFromJsonNullableX(OrganizationX.fromJson),
        paymentTransactionItem: paymentTransactionItemJson.isNotEmpty?PaymentTransactionItemX.fromJson(paymentTransactionItemJson,GiftOrderX.fromJson):null,
        sendStatus: SendStatusStatusX.values.firstWhere((x) => x.name==json[NameX.sendStatus].toStrX,orElse: () => SendStatusStatusX.pending,),
        sendStatusLocalized: json[NameX.sendStatusLocalized].toStrNullableX,
        isShowPrice: json[NameX.isShowAmount].toBoolDefaultX(false),
        giftUrl: json[NameX.giftUrl].toStrNullableX,
        giftUrlShort: json[NameX.giftUrlShort].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.status,
        NameX.giftCategory,
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
      NameX.giftCategory:giftCategory,
      ...giftBasic.toJson(),
      NameX.donationCategoryId:organizationId,
      NameX.donationCategory:organization,
      NameX.paymentTransactionItem:paymentTransactionItem,
      NameX.sendStatus:sendStatus,
      NameX.sendStatusLocalized:sendStatusLocalized,
      NameX.isShowAmount:isShowPrice,
      NameX.giftUrl:giftUrl,
      NameX.giftUrlShort:giftUrlShort,
    };
  }
}
