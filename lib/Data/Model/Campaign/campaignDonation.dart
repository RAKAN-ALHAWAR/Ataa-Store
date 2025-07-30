import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class CampaignDonationX {
  final String id;
  final int code;
  final String status;
  final double price;
  final int quantity;
  final DateTime createdAt;

  CampaignDonationX({
    required this.id,
    required this.code,
    required this.status,
    required this.price,
    required this.quantity,
    required this.createdAt,
  });

  factory CampaignDonationX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> paymentTransactionItemJson =
    Map<String, Object?>.from(json[NameX.paymentTransactionItem] ?? {});
    return ModelUtilX.checkFromJson(
      json,
      (json) => CampaignDonationX(
        id: json[NameX.id].toStrX,
        code: json[NameX.code].toIntX,
        status: json[NameX.status].toStrX,
        price: paymentTransactionItemJson[NameX.price].toDoubleX,
        quantity: paymentTransactionItemJson[NameX.quantity].toIntDefaultX(1),
        createdAt: paymentTransactionItemJson[NameX.createdAt].toDateTimeX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.code,
        NameX.status,
        NameX.paymentTransactionItem,
      ],
    );
  }
}
