part of '../../data.dart';

class PartnerX{
  PartnerX({
    required this.id,
    required this.name,
    required this.isActive,
    this.order,
    required this.externalUrl,
    required this.imageUrl,
  });

  late String id;
  late String name;

  late bool isActive;
  late int? order;

  late String externalUrl;
  late String imageUrl;

  factory PartnerX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});
    return ModelUtilX.checkFromJson(
        json,
            (json) => PartnerX(
          id: json[NameX.id].toStrDefaultX(''),
          name: json[NameX.name].toStrDefaultX(''),
          order: json[NameX.order].toIntNullableX,
          externalUrl: json[NameX.externalUrl].toStrDefaultX(''),
          isActive: json[NameX.isActive].toBoolDefaultX(true),
          imageUrl: imageJson[NameX.url].toStrX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.image,
            NameX.url,
          ]
        ]
    );
  }
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.order: order,
      NameX.isActive: isActive,
      NameX.externalUrl: externalUrl,
      NameX.image: {NameX.url: imageUrl},
    };
  }
}