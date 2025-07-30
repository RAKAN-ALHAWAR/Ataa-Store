import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class GeneralPaymentMethodsSettingsX {
  String? id;
  bool isCreditCards;
  bool isBankTransfers;
  bool isGooglePay;
  bool isApplePay;

  GeneralPaymentMethodsSettingsX({
    this.id,
    required this.isCreditCards,
    required this.isBankTransfers,
    required this.isGooglePay,
    required this.isApplePay,
  });

  factory GeneralPaymentMethodsSettingsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => GeneralPaymentMethodsSettingsX(
        id: json[NameX.id].toStrNullableX,
        isCreditCards: json[NameX.isCreditCards].toBoolX,
        isBankTransfers: json[NameX.isBankTransfers].toBoolX,
        isGooglePay: json[NameX.isGooglePay].toBoolX,
        isApplePay: json[NameX.isApplePay].toBoolX,
      ),
      requiredDataKeys: [
        NameX.isCreditCards,
        NameX.isBankTransfers,
        NameX.isGooglePay,
        NameX.isApplePay,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.isCreditCards: isCreditCards,
      NameX.isBankTransfers: isBankTransfers,
      NameX.isGooglePay: isGooglePay,
      NameX.isApplePay: isApplePay,
    };
  }
}
