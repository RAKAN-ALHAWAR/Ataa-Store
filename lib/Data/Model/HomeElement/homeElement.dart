import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class HomeElementX {
  String? id;
  String name;
  String? nameLocalized;
  int order;
  bool isActive;

  HomeElementX({
    this.id,
    required this.name,
    this.nameLocalized,
    required this.order,
    this.isActive = false,
  });

  factory HomeElementX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => HomeElementX(
        id: json[NameX.id].toStrNullableX,
        name: json[NameX.name].toStrX,
        nameLocalized: json[NameX.nameLocalized].toStrNullableX,
        order: json[NameX.order].toIntX,
        isActive: json[NameX.isActive].toBoolDefaultX(true),
      ),
      requiredDataKeys: [
        NameX.name,
        NameX.order,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.nameLocalized: nameLocalized,
      NameX.order: order,
      NameX.isActive: isActive,
    };
  }
}
