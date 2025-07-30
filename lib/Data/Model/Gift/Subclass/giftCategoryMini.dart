import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class GiftCategoryMiniX {
  String id;
  String name;
  bool status;
  int? order;

  GiftCategoryMiniX({
    required this.id,
    required this.name,
    this.order,
    required this.status,
  });

  factory GiftCategoryMiniX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => GiftCategoryMiniX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        status: json[NameX.status].toBoolDefaultX(true),
        order: json[NameX.order].toIntNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.name,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.status: status,
      NameX.order: order,
    };
  }
}