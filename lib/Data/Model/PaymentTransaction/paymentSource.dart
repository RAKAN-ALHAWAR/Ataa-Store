import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class PaymentSourceX {
  final String type;
  final String paymentCardCompany;
  final String cardUserName;
  final String cardNumber;
  final String? gatewayId;
  final String? referenceNumber;
  final String? token;
  final String? message;
  final String? transactionUrl;

  PaymentSourceX({
    required this.type,
    required this.paymentCardCompany,
    required this.cardUserName,
    required this.cardNumber,
    this.gatewayId,
    this.referenceNumber,
    this.token,
    this.message,
    this.transactionUrl,
  });

  factory PaymentSourceX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => PaymentSourceX(
            type: json[NameX.type].toStrX,
            paymentCardCompany: json[NameX.company].toStrX,
            cardUserName: json[NameX.name].toStrX,
            cardNumber: json[NameX.number].toStrX,
            gatewayId: json[NameX.gatewayId].toStrNullableX,
            referenceNumber: json[NameX.referenceNumber].toStrNullableX,
            token: json[NameX.token].toStrNullableX,
            message: json[NameX.message].toStrNullableX,
            transactionUrl: json[NameX.transactionUrl].toStrNullableX,
          ),
      requiredDataKeys: [
        NameX.type,
        NameX.company,
        NameX.name,
        NameX.number,
        // NameX.gatewayId,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.type: type,
      NameX.company: paymentCardCompany,
      NameX.name: cardUserName,
      NameX.number: cardNumber,
      NameX.gatewayId: gatewayId,
      NameX.referenceNumber: referenceNumber,
      NameX.token: token,
      NameX.message: message,
      NameX.transactionUrl: transactionUrl,
    };
  }
}