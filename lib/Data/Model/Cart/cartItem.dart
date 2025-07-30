import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Model/Donation/Order/donationOrder.dart';
import '../../../Core/Helper/model/model.dart';
import '../../Enum/model_type_status.dart';
import '../../data.dart';
import '../Deduction/Order/deductionOrder.dart';
import '../Gift/Order/giftOrder.dart';

class CartItemX {
  CartItemX({
    required this.id,
    required this.price,
    required this.quantity,
    required this.type,
    required this.name,
    required this.order,
    this.imageUrl,
  });

  String id;
  int price;
  int quantity;
  ModelTypeStatusX type;
  String name;
  OrderX order;
  String? imageUrl;

  factory CartItemX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});
    Map<String, Object?> orderJson = Map<String, Object?>.from(json[NameX.modelData] ?? {});

    late OrderX order;
    ModelTypeStatusX type = ModelTypeStatusX.values.firstWhere((x) => x.name==json[NameX.type].toString());
    if(type == ModelTypeStatusX.donation || type == ModelTypeStatusX.campaign){
      order = DonationOrderX.fromJson(orderJson);
    }else if(type == ModelTypeStatusX.gift){
      order = GiftOrderX.fromJson(orderJson);
    } else if (type == ModelTypeStatusX.deduction) {
      order = DeductionOrderX.fromJson(orderJson);
    }

    return ModelUtilX.checkFromJson(
      json,
          (json) => CartItemX(
        id: json[NameX.id].toStrX,
        price: json[NameX.price].toIntDefaultX(0),
        quantity: json[NameX.quantity].toIntDefaultX(1),
        type: type,
        name: json[NameX.name].toStrX,
        order: order,
        imageUrl: imageJson[NameX.url].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.price,
        NameX.type,
        NameX.name,
      ],
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.price: price,
      NameX.quantity: quantity,
      NameX.type: type.name,
      NameX.name: name,
      NameX.order: order.toJson(),
      NameX.image: {NameX.url: imageUrl},
    };
  }
}