part of '../../data.dart';

class SponsorshipX{
  SponsorshipX({
    required this.id,
    this.muslimNum,
    required this.country,
    required this.countryFlagCode,
    required this.gender,
    required this.language,
    this.previousReligion,
    this.courseName,
    required this.donationAmount,
  });

  late String id;
  late int? muslimNum;
  late String country;
  late String countryFlagCode;
  late String gender;
  late String language;
  late String? previousReligion;
  late String? courseName;
  late int donationAmount;

  // factory SponsorshipX.fromJson(Map<String, dynamic> json) {
  //   return SponsorshipX(
  //     id: json[NameX.id].toString(),
  //   );
  // }

}