import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class GiftCardFormByGenderX {
  String id;
  String title;
  String description;
  String conclusion;
  String gender;
  String imageUrl;
  List<OrganizationX> donationCategories;

  GiftCardFormByGenderX({
    required this.id,
    required this.title,
    required this.conclusion,
    required this.description,
    required this.gender,
    required this.imageUrl,
    this.donationCategories = const [],
  });

  factory GiftCardFormByGenderX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});
    return ModelUtilX.checkFromJson(
      json,
      (json) => GiftCardFormByGenderX(
        id: json[NameX.id].toStrX,
        title: json[NameX.title].toStrX,
        description: json[NameX.description].toStrX,
        conclusion: json[NameX.conclusion].toStrX,
        gender: json[NameX.genderType].toStrX,
        imageUrl: imageJson[NameX.url].toStrX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.title,
        NameX.description,
        NameX.conclusion,
        NameX.genderType,
        NameX.image,
        NameX.url,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.title: title,
      NameX.description: description,
      NameX.conclusion: conclusion,
      NameX.genderType: gender,
      NameX.image: {NameX.url: imageUrl},
    };
  }
}
