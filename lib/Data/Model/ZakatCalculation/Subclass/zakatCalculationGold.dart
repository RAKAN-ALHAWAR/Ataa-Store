import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/Enum/metal_karat_status.dart';
import 'package:ataa/Data/data.dart';

class ZakatCalculationGoldX {
  final MetalKaratStatusX karat;
  final int gram;

  ZakatCalculationGoldX({
    required this.karat,
    required this.gram,
  });

  factory ZakatCalculationGoldX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => ZakatCalculationGoldX(
        karat: MetalKaratStatusX.values.firstWhere(
          (x) => x.karat == json[NameX.karat].toIntX,
        ),
        gram: json[NameX.gram].toIntX,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.karat: karat.karat,
      NameX.gram: gram,
    };
  }
}