import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationTypeX{
  DonationTypeX({
    required this.id,
    required this.name,
    required this.nameLocalized,
  });

  final String id;
  final String name;
  final String? nameLocalized;

  factory DonationTypeX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationTypeX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        nameLocalized: json[NameX.nameLocalized].toStrNullableX,
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
      NameX.type: nameLocalized,
    };
  }
}