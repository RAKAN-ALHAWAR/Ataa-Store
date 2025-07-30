part of '../../data.dart';

class GeneralStatisticX {
  GeneralStatisticX({
    required this.id,
    required this.title,
    required this.number,
    required this.textAfterNumber,
    required this.isActive,
    this.order,
    this.imageUrl,
  });

  String id;
  String title;
  double number;
  String textAfterNumber;
  bool isActive;
  int? order;
  String? imageUrl;

  factory GeneralStatisticX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});

    return ModelUtilX.checkFromJson(
      json,
          (json) => GeneralStatisticX(
        id: json[NameX.id].toStrDefaultX(''),
        title: json[NameX.title].toStrX,
        number: json[NameX.number].toDoubleX,
        textAfterNumber: json[NameX.textAfterNumber].toStrDefaultX(''),
        isActive: json[NameX.status].toBoolDefaultX(true),
        order: json[NameX.order].toIntNullableX,
        imageUrl: imageJson[NameX.url].toStrNullableX,
      ),
      requiredDataKeys: [
        NameX.title,
        NameX.number,
      ],
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.title: title,
      NameX.number: number,
      NameX.textAfterNumber: textAfterNumber,
      NameX.isActive: isActive,
      NameX.order: order,
      NameX.image: {NameX.url: imageUrl},
    };
  }
}