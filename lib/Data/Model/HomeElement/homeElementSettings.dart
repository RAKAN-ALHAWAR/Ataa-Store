import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

import 'homeElement.dart';

class HomeElementSettingsX {
  final HomeElementX donation;
  final HomeElementX org;
  final HomeElementX deduction;
  final HomeElementX zakat;
  final HomeElementX testimonial;
  final HomeElementX statistic;
  final HomeElementX partner;

  HomeElementSettingsX({
    required this.donation,
    required this.org,
    required this.deduction,
    required this.zakat,
    required this.testimonial,
    required this.statistic,
    required this.partner,
  });

  factory HomeElementSettingsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => HomeElementSettingsX(
        donation: json[NameX.donationOpportunities].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.donationOpportunities, order: -1),
        org: json[NameX.donationCategory].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.donationCategory, order: -1),
        deduction: json[NameX.deductions].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.deductions, order: -1),
        zakat: json[NameX.zakatExpenditures].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.zakatExpenditures, order: -1),
        testimonial: json[NameX.testimonials].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.testimonials, order: -1),
        statistic: json[NameX.statistic].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.statistic, order: -1),
        partner: json[NameX.partner].toFromJsonNullableX(HomeElementX.fromJson)??HomeElementX(name: NameX.partner, order: -1),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.donationOpportunities: donation.toJson(),
      NameX.donationCategory: org.toJson(),
      NameX.deductions: deduction.toJson(),
      NameX.zakatExpenditures: zakat.toJson(),
      NameX.testimonials: testimonial.toJson(),
      NameX.statistic: statistic.toJson(),
      NameX.partner: partner.toJson(),
    };
  }
}
