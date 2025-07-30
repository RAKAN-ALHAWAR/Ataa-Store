import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../data.dart';

class ContactUsSocialMediaX {
  final String? id;
  final String? siteUrl;
  final String? donationsSiteUrl;
  final String? facebookUrl;
  final String? twitterUrl;
  final String? youtubeUrl;
  final String? instagramUrl;
  final String? snapchatUrl;

  ContactUsSocialMediaX({
    required this.id,
    required this.siteUrl,
    required this.donationsSiteUrl,
    required this.facebookUrl,
    required this.twitterUrl,
    required this.youtubeUrl,
    required this.instagramUrl,
    required this.snapchatUrl,
  });

  factory ContactUsSocialMediaX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => ContactUsSocialMediaX(
        id: json[NameX.id].toStrNullableX,
        siteUrl: json[NameX.siteUrl].toStrNullableX,
        donationsSiteUrl: json[NameX.donationsSiteUrl].toStrNullableX,
        facebookUrl: json[NameX.facebookUrl].toStrNullableX,
        twitterUrl: json[NameX.twitterUrl].toStrNullableX,
        youtubeUrl: json[NameX.youtubeUrl].toStrNullableX,
        instagramUrl: json[NameX.instagramUrl].toStrNullableX,
        snapchatUrl: json[NameX.snapchatUrl].toStrNullableX,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.siteUrl: siteUrl,
      NameX.donationsSiteUrl: donationsSiteUrl,
      NameX.facebookUrl: facebookUrl,
      NameX.twitterUrl: twitterUrl,
      NameX.youtubeUrl: youtubeUrl,
      NameX.instagramUrl: instagramUrl,
      NameX.snapchatUrl: snapchatUrl,
    };
  }
}
