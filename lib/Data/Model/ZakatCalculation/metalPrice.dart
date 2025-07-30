import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class MetalPriceX {
  final double price;
  final int? karat;
  final DateTime? date;

  MetalPriceX({
    required this.price,
    required this.karat,
    this.date,
  });

  factory MetalPriceX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => MetalPriceX(
            price: json[NameX.price].toDoubleX,
            karat: json[NameX.karat].toIntNullableX,
            date: json[NameX.date].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.price,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.price: price,
      NameX.karat: karat,
      NameX.date: date,
    };
  }
}
