part of '../core.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this Util }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Generic functions that can be used across the entire project
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class FunctionX {
  /// Convert ounces to grams with all karats
  static Map<int, double> goldOunceToKarats(double ounce) {
    double gram = ounce / ConstantX.ounceWeight;
    Map<int, double> karats = {};
    for (int karat in ConstantX.goldKarats) {
      karats[karat] = (gram * karat) / 24;
    }
    return karats;
  }

  ///Convert ounces to grams
  static double silverOunceToGram(double ounce) {
    return ounce / ConstantX.ounceWeight;
  }

  /// Separating connected words like: SakerDakak -> Saker Dakak
  static String addSpaceBeforeUpperCase(String val) {
    return val[0] +
        val.substring(1).replaceAllMapped(RegExp(r'([A-Z])'), (match) {
          return ' ${match.group(1)}';
        });
  }

  /// Time format like: 80 -> 1:20
  static String formatTime(int val) {
    return '${(val ~/ 60).toString().padLeft(2, '0')}:${(val % 60).toString().padLeft(2, '0')}';
  }

  /// Large number format like: 1000 -> 1,000
  static String formatLargeNumber(num val, {int decimal = 0}) {
    intl.NumberFormat formatter = intl.NumberFormat.decimalPatternDigits(
      locale: 'en_us',
      decimalDigits: decimal,
    );
    return formatter.format(val);
  }

  /// Extract the country code and phone number
  /// like: +963994343927 -> [ 963 , 994343927 ]
  static (String, int?) extractCountryCodeAndPhoneNumber(String number) {
    // Remove all non-digit characters except +
    number = number.replaceAll(RegExp(r'[^\d+]'), '');

    // Remove any leading '+' or '00'
    number = number.replaceAll(RegExp(r'^(\+|00)'), '');

    // Check if the number contains a country code
    if (number.length > 10) {
      int? countryCode;
      int cut = number.length > 12 ? number.length - 3 : 9;
      String x = number.substring(0, number.length - cut);
      String phoneNumber = number.substring(number.length - cut);
      if (x.length == 3) {
        countryCode = int.tryParse(x);
      } else {
        phoneNumber = number;
      }

      return (phoneNumber, countryCode);
    } else {
      return (number, null);
    }
  }
}
