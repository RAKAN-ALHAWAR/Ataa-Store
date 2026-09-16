import 'package:ataa/Core/Extension/convert/convert.dart';

import '../../data.dart';

class PaymentCardFormX {
  PaymentCardFormX({
    required this.name,
    required this.cardNum,
    required this.month,
    required this.year,
    required this.cvv,
    required this.isDefault,
  });

  final String name;
  final String cardNum;
  final int month;
  final int year;

  /// Kept as a String (never int): a CVV can legitimately start with a zero
  /// (e.g. "012"), and int parsing would drop it, so the backend then rejects
  /// it as fewer than 3 digits.
  final String cvv;
  final bool isDefault;

  Map<String, dynamic> toJson() {
    return {
      NameX.name: name,
      NameX.cardNum: cardNum,
      NameX.month: month,
      NameX.year: year,
      NameX.cvv: cvv,
      NameX.isDefault: isDefault.toIntX,
    };
  }
}
