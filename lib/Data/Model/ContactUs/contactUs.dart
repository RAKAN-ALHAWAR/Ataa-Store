import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../data.dart';

class ContactUsX {
  final String? id;
  final String? countryCode;
  final int? mobile;
  final String? email;
  final String? whatsappCountryCode;
  final int? whatsappNumber;
  final OrganizationX? org;

  ContactUsX({
    this.id,
    this.countryCode,
    this.mobile,
    this.email,
    this.whatsappCountryCode,
    this.whatsappNumber,
    this.org,
  });

  factory ContactUsX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> orgJson = Map<String, dynamic>.from(json[NameX.organization]);

    return ModelUtilX.checkFromJson(
      json,
      (json) => ContactUsX(
        id: json[NameX.id].toStrNullableX,
        countryCode: json[NameX.countryCode]?.toStrNullableX,
        mobile: json[NameX.mobile]?.toIntNullableX,
        email: json[NameX.email].toStrNullableX,
        whatsappCountryCode: json[NameX.whatsappCountryCode].toStrNullableX,
        whatsappNumber: json[NameX.whatsappNumber]?.toIntNullableX,
        org: orgJson.toFromJsonNullableX(OrganizationX.fromJson),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.countryCode: countryCode,
      NameX.mobile: mobile,
      NameX.email: email,
      NameX.whatsappCountryCode: whatsappCountryCode,
      NameX.whatsappNumber: whatsappNumber,
      NameX.organization: org?.toJson(),
    };
  }
}
