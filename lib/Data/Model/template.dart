import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class X {
  final String id;

  X({
    required this.id,
  });

  factory X.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => X(
        id: json[NameX.id].toStrX,
      ),
      requiredDataKeys: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
    };
  }
}
