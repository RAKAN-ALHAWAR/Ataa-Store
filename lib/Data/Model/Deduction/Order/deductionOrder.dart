import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../Enum/model_type_status.dart';
import '../../../data.dart';
import '../../PaymentTransaction/paymentTransactionCard.dart';
import '../deduction.dart';

class DeductionOrderX extends OrderX {
  final int code;
  final String? typeValue;
  final double price;
  final double totalPayment;
  final DateTime nextSubscriptionDiscountDate;
  final bool status;
  final String? recurringDonationId;
  final PaymentTransactionCardX? paymentTransactionCard;
  final DeductionX deduction;

  DeductionOrderX({
    required super.modelId,
    required super.modelType,
    required super.createdAt,
    required this.code,
    required this.typeValue,
    required this.price,
    required this.totalPayment,
    required this.nextSubscriptionDiscountDate,
    required this.status,
    this.recurringDonationId,
    this.paymentTransactionCard,
    required this.deduction,
  });

  factory DeductionOrderX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> deductionJson =
        Map<String, Object?>.from(json[NameX.recurringDonation]);
    Map<String, Object?> paymentTransactionCardJson =
        Map<String, Object?>.from(json[NameX.paymentCard] ?? {});

    return ModelUtilX.checkFromJson(
      json,
      (json) => DeductionOrderX(
        modelId: json[NameX.id].toStrX,
        modelType: ModelTypeStatusX.deduction,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        code: json[NameX.code].toIntX,
        typeValue: json[NameX.typeValue].toStrNullableX,
        price: json[NameX.price].toDoubleX,
        totalPayment: json[NameX.totalPayment].toDoubleX,
        paymentTransactionCard: paymentTransactionCardJson
            .toFromJsonNullableX(PaymentTransactionCardX.fromJson),
        nextSubscriptionDiscountDate:
            json[NameX.nextSubscriptionDiscountDate].toDateTimeX,
        status: json[NameX.status].toBoolX,
        recurringDonationId: json[NameX.recurringDonationId].toStrNullableX,
        deduction: DeductionX.fromJson(deductionJson),
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.createdAt,
        NameX.code,
        NameX.price,
        NameX.totalPayment,
        NameX.nextSubscriptionDiscountDate,
        NameX.status,
        NameX.recurringDonation,
      ],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      NameX.id: modelId,
      NameX.modelType: modelType.name,
      NameX.createdAt: createdAt,
      NameX.code: code,
      NameX.typeValue: typeValue,
      NameX.price: price,
      NameX.totalPayment: totalPayment,
      NameX.nextSubscriptionDiscountDate: nextSubscriptionDiscountDate,
      NameX.status: status,
      NameX.recurringDonationId: recurringDonationId,
      NameX.recurringDonation: deduction.toJson(),
    };
  }
}
