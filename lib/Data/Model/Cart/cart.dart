import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';
import 'cartItem.dart';

class CartX {
  CartX({
    required this.id,
    this.location,
    required this.totalPrice,
    required this.countItem,
    required this.currency,
    required this.isProduct,
    this.items = const [],
    this.createdAt,
  });

  String id;
  double totalPrice;
  int countItem;
  String currency;
  bool isProduct;
  DateTime? createdAt;
  List<CartItemX> items;
  DeliveryLocationX? location;


  factory CartX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => CartX(
        id: json[NameX.id].toStrX,
        totalPrice: json[NameX.totalPrice].toDoubleX,
        countItem: json[NameX.countItem].toIntX,
        currency: json[NameX.currency].toStrX,
        isProduct: json[NameX.isProduct].toBoolX,
        createdAt: json[NameX.createdAt].toDateTimeNullableX,
        items: ModelUtilX.generateItems(json[NameX.cartItems] as List, CartItemX.fromJson),
        location: json[NameX.location].toFromJsonNullableX(DeliveryLocationX.fromJson),
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.totalPrice,
        NameX.countItem,
        NameX.currency,
        NameX.isProduct,
      ],
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.totalPrice: totalPrice,
      NameX.countItem: countItem,
      NameX.currency: currency,
      NameX.isProduct: isProduct,
      NameX.cartItems: items.map((e) => e.toJson(),).toList(),
      NameX.location: location?.toJson(),
    };
  }

}