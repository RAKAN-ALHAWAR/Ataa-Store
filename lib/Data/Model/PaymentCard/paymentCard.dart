part of '../../data.dart';

class PaymentCardX {
  final String id;
  final String? paymentGatewayCardId;
  final String name;
  final String last4Digits;
  final int month;
  final int year;
  final PaymentCardStatusStatusX status;
  late  bool isDefault;
  final String? iconUrl;
  final String? verificationUrl;

  PaymentCardX({
    required this.id,
    required this.paymentGatewayCardId,
    required this.name,
    required this.last4Digits,
    required this.month,
    required this.year,
    required this.status,
    required this.isDefault,
    required this.iconUrl,
    this.verificationUrl,
  });

  String get expiryDate=>'$month/$year';

  factory PaymentCardX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => PaymentCardX(
        id: json[NameX.id].toStrX,
        paymentGatewayCardId: json[NameX.paymentGatewayCardId].toStrNullableX,
        name: json[NameX.brand].toStrX,
        last4Digits: json[NameX.last4Digits].toStrX,
        month: json[NameX.month].toIntX,
        year: json[NameX.year].toIntX,
        status: PaymentCardStatusStatusX.values.firstWhere((x) => x.name==json[NameX.status].toStrX),
        isDefault: json[NameX.isDefault].toBoolX,
        iconUrl: json[NameX.iconUrl].toStrNullableX,
        verificationUrl: json[NameX.verificationUrl].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.brand,
        NameX.last4Digits,
        NameX.month,
        NameX.year,
        NameX.status,
        NameX.isDefault,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.paymentGatewayCardId: paymentGatewayCardId,
      NameX.name: name,
      NameX.last4Digits: last4Digits,
      NameX.month: month,
      NameX.year: year,
      NameX.status: status.name,
      NameX.isDefault: isDefault,
      NameX.iconUrl: iconUrl,
      NameX.verificationUrl: verificationUrl,
    };
  }
}
