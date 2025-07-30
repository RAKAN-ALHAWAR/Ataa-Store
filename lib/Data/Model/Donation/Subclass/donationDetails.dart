import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationDetailsX{
  DonationDetailsX({
    required this.description,
    required this.briefDescription,
    required this.imageUrl,
    required this.videoUrl,
  });

  final String description;
  final String? briefDescription;
  final String? imageUrl;
  final String? videoUrl;

  factory DonationDetailsX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});

    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationDetailsX(
            description: json[NameX.description].toStrDefaultX(''),
            briefDescription: json[NameX.briefDescription].toStrNullableX,
            imageUrl: imageJson[NameX.url].toStrNullableX,
            videoUrl: json[NameX.videoUrl].toStrNullableX,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.description: description,
      NameX.briefDescription: briefDescription,
      NameX.image: {NameX.url:imageUrl},
      NameX.videoUrl: videoUrl,
    };
  }
}