import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/payment_method_status.dart';
import 'package:ataa/Data/Model/PaymentTransaction/paymentDataBankTransfer.dart';
import '../../../Core/Helper/model/model.dart';
import '../../Enum/payment_status_status.dart';
import '../../data.dart';
import 'paymentDataCreditCard.dart';
import 'paymentTransactionCard.dart';

class PaymentTransactionX {
  final String id;
  final int code;
  final double? price;
  final PaymentDataCreditCardX? paymentDataCreditCard;
  final PaymentDataBankTransferX? paymentDataBankTransfer;
  final PaymentTransactionCardX? paymentTransactionCard;
  final PaymentMethodStatusX paymentMethod;
  final String? paymentMethodLocalized;
  final String currency;
  final String? receiptUrl;
  final String? receiptUrlShort;
  final String? applePayToken;
  PaymentStatusStatusX status;
  final String? statusLocalized;
  final String? callbackUrl;
  final String? verificationUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PaymentTransactionX({
    required this.id,
    required this.code,
    this.price,
    this.paymentDataCreditCard,
    this.paymentDataBankTransfer,
    this.paymentTransactionCard,
    required this.paymentMethod,
    required this.paymentMethodLocalized,
    required this.currency,
    this.receiptUrl,
    this.receiptUrlShort,
    this.applePayToken,
    required this.status,
    required this.statusLocalized,
    this.callbackUrl,
    this.verificationUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory PaymentTransactionX.fromJson(Map<String, dynamic> json) {
     Map<String, Object?> paymentDataJson = Map<String, Object?>.from(json[NameX.paymentData] ?? {});
     Map<String, Object?> paymentTransactionCardJson = Map<String, Object?>.from(json[NameX.paymentTransactionCard] ?? {});
     return ModelUtilX.checkFromJson(
       json,
           (json) => PaymentTransactionX(
         id: json[NameX.id].toStrX,
         code: json[NameX.code].toIntX,
         price: json[NameX.price].toDoubleNullableX,
         paymentDataCreditCard: paymentDataJson.toFromJsonNullableX(PaymentDataCreditCardX.fromJson),
         paymentDataBankTransfer: paymentDataJson.toFromJsonNullableX(PaymentDataBankTransferX.fromJson),
         paymentTransactionCard: paymentTransactionCardJson.toFromJsonNullableX(PaymentTransactionCardX.fromJson),
         paymentMethod: PaymentMethodStatusX.values.firstWhere((e) => e.name==json[NameX.paymentMethod].toStrX),
         paymentMethodLocalized: json[NameX.paymentMethodLocalized].toStrNullableX,
         currency: json[NameX.currency].toStrDefaultX('SAR'),
         receiptUrl: json[NameX.receiptUrl].toStrNullableX,
         receiptUrlShort: json[NameX.receiptUrlShort].toStrNullableX,
         applePayToken: json[NameX.applePayToken].toStrNullableX,
         status: PaymentStatusStatusX.values.firstWhere((e) => e.name==json[NameX.status].toStrX,orElse: () => PaymentStatusStatusX.unknown),
         statusLocalized: json[NameX.statusLocalized].toStrNullableX,
         callbackUrl: json[NameX.callbackUrl].toStrNullableX,
         verificationUrl: json[NameX.verificationUrl].toStrNullableX,
         createdAt: json[NameX.createdAt].toDateTimeNullableX,
         updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
       ),
       requiredDataKeys: [
         NameX.id,
         NameX.code,
         NameX.paymentMethod,
         NameX.status,
       ],
     );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.code: code,
      NameX.paymentData: paymentDataCreditCard!=null?paymentDataCreditCard?.toJson():paymentDataBankTransfer?.toJson(),
      NameX.paymentTransactionCard: paymentTransactionCard?.toJson(),
      NameX.paymentMethod: paymentMethod,
      NameX.paymentMethodLocalized: paymentMethodLocalized,
      NameX.currency: currency,
      NameX.receiptUrl: receiptUrl,
      NameX.receiptUrlShort: receiptUrlShort,
      NameX.applePayToken: applePayToken,
      NameX.status: status.name,
      NameX.statusLocalized: statusLocalized,
      NameX.callbackUrl: callbackUrl,
      NameX.verificationUrl: verificationUrl,
      NameX.createdAt: createdAt,
    };
  }
}
