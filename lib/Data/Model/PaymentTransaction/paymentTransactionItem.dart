import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../Enum/model_type_status.dart';
import '../../data.dart';
import '../PaymentTransaction/paymentTransaction.dart';

class PaymentTransactionItemX<T extends OrderX>{
  final String id;
  final PaymentTransactionX paymentTransaction;
  final double price;
  final int quantity;
  final String name;
  final ModelTypeStatusX type;
  final String? typeLocalized;
  T? orderModel;

  PaymentTransactionItemX({
    required this.id,
    required this.paymentTransaction,
    required this.price,
    required this.quantity,
    required this.name,
    required this.type,
    this.typeLocalized,
    this.orderModel,
  });

  factory PaymentTransactionItemX.fromJson(Map<String, dynamic> json,[T Function(Map<String, dynamic>)? orderModelFromJson]) {
    Map<String, Object?> paymentTransactionJson = Map<String, Object?>.from(json[NameX.paymentTransaction] ?? {});
    Map<String, Object?> orderModelJson = Map<String, Object?>.from(json[NameX.modelData] ?? {});
    return ModelUtilX.checkFromJson(
      json,
          (json) => PaymentTransactionItemX(
        id: json[NameX.id].toStrX,
        paymentTransaction: PaymentTransactionX.fromJson(paymentTransactionJson),
        price: json[NameX.price].toDoubleX,
        quantity: json[NameX.quantity].toIntDefaultX(1),
        name: json[NameX.name].toStrDefaultX(''),
        type: ModelTypeStatusX.values.firstWhere((x) => x.name==json[NameX.type].toString(),orElse: () => ModelTypeStatusX.donation,),
        typeLocalized: json[NameX.typeLocalized].toStrNullableX,
        orderModel: orderModelFromJson?.call(orderModelJson),
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.paymentTransaction,
        NameX.price,
        NameX.quantity,
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
      NameX.modelData: orderModel?.toJson(),
    };
  }
}
