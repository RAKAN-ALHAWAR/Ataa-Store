import 'package:ataa/Core/Extension/convert/convert.dart';

import '../../../Core/Helper/model/model.dart';
import '../../Enum/payment_status_status.dart';
import '../../data.dart';
import 'paymentSource.dart';

class PaymentDataCreditCardX {
  final String id;
  final PaymentStatusStatusX status;
  final double amount;
  final double fee;
  final String currency;
  final double refunded;
  final String? refundedAt;
  final double captured;
  final String? capturedAt;
  final String? voidedAt;
  final String? description;
  final String amountFormat;
  final String? feeFormat;
  final String? refundedFormat;
  final String? capturedFormat;
  final String? invoiceId;
  final String? callbackUrl;
  final String? createdAt;
  final PaymentSourceX paymentSource;

  PaymentDataCreditCardX({
    required this.id,
    required this.status,
    required this.amount,
    required this.fee,
    required this.currency,
    required this.refunded,
    this.refundedAt,
    required this.captured,
    this.capturedAt,
    this.voidedAt,
    this.description,
    required this.amountFormat,
    this.feeFormat,
    this.refundedFormat,
    this.capturedFormat,
    this.invoiceId,
    this.callbackUrl,
    this.createdAt,
    required this.paymentSource,
  });

  factory PaymentDataCreditCardX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> paymentSourceJson = Map<String, Object?>.from(json[NameX.source] ?? {});

    return ModelUtilX.checkFromJson(
      json,
          (json) => PaymentDataCreditCardX(
            id: json[NameX.id].toStrX,
            status: PaymentStatusStatusX.values.firstWhere((e) => e.name==json[NameX.status].toStrX,orElse: () => PaymentStatusStatusX.unknown),
            amount: json[NameX.amount].toDoubleX,
            fee: json[NameX.fee].toDoubleDefaultX(0),
            currency: json[NameX.currency].toStrDefaultX('SAR'),
            refunded: json[NameX.refunded].toDoubleDefaultX(0),
            refundedAt: json[NameX.refundedAt].toStrNullableX,
            captured: json[NameX.captured].toDoubleDefaultX(0),
            capturedAt: json[NameX.capturedAt].toStrNullableX,
            voidedAt: json[NameX.voidedAt].toStrNullableX,
            description: json[NameX.description].toStrNullableX,
            amountFormat: json[NameX.amountFormat].toStrX,
            feeFormat: json[NameX.feeFormat].toStrNullableX,
            refundedFormat: json[NameX.refundedFormat].toStrNullableX,
            capturedFormat: json[NameX.capturedFormat].toStrNullableX,
            invoiceId: json[NameX.invoiceId].toStrNullableX,
            callbackUrl: json[NameX.callbackUrl].toStrNullableX,
            createdAt: json[NameX.createdAt].toStrNullableX,
            paymentSource: PaymentSourceX.fromJson(paymentSourceJson),
          ),
      requiredDataKeys: [
        NameX.id,
        NameX.status,
        NameX.amountFormat,
        NameX.source,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.status: status.name,
      NameX.amount: amount,
      NameX.fee: fee,
      NameX.currency: currency,
      NameX.refunded: refunded,
      NameX.refundedAt: refundedAt,
      NameX.captured: captured,
      NameX.capturedAt: capturedAt,
      NameX.voidedAt: voidedAt,
      NameX.description: description,
      NameX.amountFormat: amountFormat,
      NameX.feeFormat: feeFormat,
      NameX.refundedFormat: refundedFormat,
      NameX.capturedFormat: capturedFormat,
      NameX.invoiceId: invoiceId,
      NameX.callbackUrl: callbackUrl,
      NameX.createdAt: createdAt,
      NameX.source: paymentSource.toJson(),
    };
  }
}