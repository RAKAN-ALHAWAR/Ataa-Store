import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class AdSectionX {
  final String? id;
  final String? sectionId;
  final int? code;

  AdSectionX({
    this.id,
    this.sectionId,
    this.code,
  });

  factory AdSectionX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => AdSectionX(
        id: json[NameX.id].toStrNullableX,
        sectionId: json[NameX.sectionId].toStrNullableX,
        code: json[NameX.code].toIntNullableX,
      ),
    );
  }
}
