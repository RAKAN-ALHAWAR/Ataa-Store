part of '../../data.dart';

class TestimonialX {
  TestimonialX({
    required this.id,
    required this.name,
    required this.content,
    required this.isActive,
    this.imageUrl,
    this.country,
  });

  String id;
  String name;
  String content;
  bool isActive;
  String? imageUrl;
  CountryX? country;

  factory TestimonialX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});
    try{

      return ModelUtilX.checkFromJson(
        json,
            (json) => TestimonialX(
          id: json[NameX.id].toStrDefaultX(''),
          name: json[NameX.name].toStrX,
          content: json[NameX.content].toStrDefaultX(''),
          isActive: json[NameX.status].toBoolDefaultX(true),
          imageUrl: imageJson[NameX.url].toStrNullableX,
          country: json[NameX.country].toFromJsonNullableX(CountryX.fromJson),
        ),
        requiredDataKeys: [
          NameX.name,
          NameX.content,
        ],
      );
    }catch(e){
      e.toErrorX.log();
      rethrow;
    }
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.content: content,
      NameX.isActive: isActive,
      NameX.image: {NameX.url: imageUrl},
    };
  }
}