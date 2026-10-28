import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:flutter/services.dart';

/// Converts Arabic-Indic digits (٠-٩) to Latin digits (0-9) while typing or pasting.
///
/// Must be placed BEFORE `FilteringTextInputFormatter.digitsOnly` in the formatter
/// list: `digitsOnly` accepts only `[0-9]` and would otherwise drop the Arabic digits.
/// The mapping is one character to one character, so selection and composing range stay valid.
class ArabicDigitsInputFormatter extends TextInputFormatter {
  const ArabicDigitsInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final converted = newValue.text.arabicToEnglishNumbers;
    if (converted == newValue.text) return newValue;
    return newValue.copyWith(text: converted);
  }
}
