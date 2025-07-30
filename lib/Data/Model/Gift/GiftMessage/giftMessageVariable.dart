import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class GiftMessageVariableX {
  String name;
  String nameLocalized;
  String example;

  GiftMessageVariableX({
    required this.name,
    required this.nameLocalized,
    required this.example,
  });

  factory GiftMessageVariableX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => GiftMessageVariableX(
          name: json[NameX.name].toStrX,
          nameLocalized: json[NameX.nameLocalized].toStrX,
          example: json[NameX.example].toStrX),
      requiredDataKeys: [
        NameX.name,
        NameX.nameLocalized,
        NameX.example,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.name: name,
      NameX.nameLocalized: nameLocalized,
      NameX.example: example,
    };
  }
}
