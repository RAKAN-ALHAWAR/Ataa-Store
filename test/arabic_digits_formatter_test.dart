import 'package:ataa/Core/Util/arabicDigitsFormatter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const formatter = ArabicDigitsInputFormatter();
  const empty = TextEditingValue.empty;

  TextEditingValue format(String text, {int? offset}) => formatter.formatEditUpdate(
        empty,
        TextEditingValue(
          text: text,
          selection: TextSelection.collapsed(offset: offset ?? text.length),
        ),
      );

  test('converts Arabic-Indic digits to Latin and keeps the caret', () {
    final result = format('١٢٣٤٥٦٧٨٩٠', offset: 4);
    expect(result.text, '1234567890');
    expect(result.selection.baseOffset, 4);
  });

  test('digitsOnly after the formatter keeps converted Arabic digits', () {
    final converted = format('٥٤٢٨');
    final filtered = FilteringTextInputFormatter.digitsOnly.formatEditUpdate(empty, converted);
    expect(filtered.text, '5428');
  });

  test('leaves Latin digits and other text untouched', () {
    expect(format('4242 abc').text, '4242 abc');
  });
}
