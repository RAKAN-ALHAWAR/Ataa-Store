import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationCategoryX {
  final String id;
  final String name;

  DonationCategoryX({
    required this.id,
    required this.name,
  });

  factory DonationCategoryX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationCategoryX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
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
    };
  }
}
