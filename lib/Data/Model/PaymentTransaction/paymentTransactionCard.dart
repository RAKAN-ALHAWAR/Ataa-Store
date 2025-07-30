import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class PaymentTransactionCardX {
  final String paymentCardCompany;
  final String lastFourDigits;
  final bool? isSave;
  final String? iconUrl;

  PaymentTransactionCardX({
    required this.paymentCardCompany,
    required this.lastFourDigits,
    required this.isSave,
    this.iconUrl,
  });

  factory PaymentTransactionCardX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => PaymentTransactionCardX(
        paymentCardCompany: json[NameX.brand].toStrX,
        lastFourDigits: json[NameX.last4Digits].toStrX,
        isSave: json[NameX.isSave].toBoolNullableX,
        iconUrl: json[NameX.iconUrl].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.brand,
        NameX.last4Digits,
      ],
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      NameX.brand: paymentCardCompany,
      NameX.last4Digits: lastFourDigits,
      NameX.isSave: isSave,
      NameX.iconUrl: iconUrl,
    };
  }
}