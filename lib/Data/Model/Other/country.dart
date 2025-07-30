part of '../../data.dart';

class CountryX {
  CountryX({
    required this.id,
    required this.name,
    required this.codePhone,
    this.isoCode,
    this.flagUrl,
  });

  String id;
  Map<String,String> name;
  int codePhone;
  String? isoCode;
  String? flagUrl;

  factory CountryX.fromJson(Map<String, dynamic> json) {

    return ModelUtilX.checkFromJson(
      json,
          (json) => CountryX(
        id: json[NameX.id].toStrDefaultX(''),
        name: json[NameX.name].toMapX<String,String>(),
        codePhone: json[NameX.codePhone].toIntX,
        isoCode: json[NameX.isoCode].toStrNullableX,
        flagUrl: json[NameX.flagUrl].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.name,
        NameX.codePhone,
      ],
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.codePhone: codePhone,
      NameX.isoCode: isoCode,
      NameX.flagUrl: flagUrl,
    };
  }
}