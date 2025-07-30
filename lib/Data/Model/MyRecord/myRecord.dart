import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';
import '../PaymentTransaction/paymentTransaction.dart';

class MyRecordX<T extends OrderX>{
  final String id;
  final PaymentTransactionX paymentTransaction;
  final double price;
  final int quantity;
  final String name;
  final String type;
  final String? typeLocalized;
  final T orderModel;

  MyRecordX({
    required this.id,
    required this.paymentTransaction,
    required this.price,
    required this.quantity,
    required this.name,
    required this.type,
    this.typeLocalized,
    required this.orderModel,
  });

  factory MyRecordX.fromJson(Map<String, dynamic> json,T Function(Map<String, dynamic>) orderModelFromJson) {
    Map<String, Object?> paymentTransactionJson = Map<String, Object?>.from(json[NameX.paymentTransaction] ?? {});
    Map<String, Object?> orderModelJson = Map<String, Object?>.from(json[NameX.modelData] ?? {});
    return ModelUtilX.checkFromJson(
      json,
          (json) => MyRecordX(
        id: json[NameX.id].toStrX,
        paymentTransaction: PaymentTransactionX.fromJson(paymentTransactionJson),
        price: json[NameX.price].toDoubleX,
        quantity: json[NameX.quantity].toIntDefaultX(1),
        name: json[NameX.name].toStrX,
        type: json[NameX.type].toStrX,
        typeLocalized: json[NameX.typeLocalized].toStrNullableX,
        orderModel: orderModelFromJson(orderModelJson),
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.paymentTransaction,
        NameX.price,
        NameX.quantity,
        NameX.name,
        NameX.type,
        NameX.modelData,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.paymentTransaction: paymentTransaction.toJson(),
      NameX.price: price,
      NameX.quantity: quantity,
      NameX.name: name,
      NameX.type: type,
      NameX.typeLocalized: typeLocalized,
      NameX.modelData: orderModel.toJson(),
    };
  }
}
