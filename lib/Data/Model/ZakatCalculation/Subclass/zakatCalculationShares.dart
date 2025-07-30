import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class ZakatCalculationSharesX {
  final int count;
  final double price;

  ZakatCalculationSharesX({
    required this.count,
    required this.price,
  });

  factory ZakatCalculationSharesX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => ZakatCalculationSharesX(
        count: json[NameX.count].toIntX,
        price: json[NameX.price].toDoubleX,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.count: count,
      NameX.price: price,
    };
  }
}
