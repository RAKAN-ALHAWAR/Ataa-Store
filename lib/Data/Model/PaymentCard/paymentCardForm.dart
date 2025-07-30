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
  final int cvv;
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
