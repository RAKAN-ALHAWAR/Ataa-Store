import 'package:ataa/Data/Model/ZakatCalculation/Subclass/zakatCalculationGold.dart';
import 'package:ataa/Data/Model/ZakatCalculation/Subclass/zakatCalculationShares.dart';
import 'package:ataa/Data/data.dart';

import '../../Enum/zakat_calculation_type_status.dart';

class ZakatCalculationFormX {
  final ZakatCalculationTypeStatusX type;
  final int? weight;
  final double? money;
  final List<ZakatCalculationGoldX> golds;
  final List<ZakatCalculationSharesX> shares;

  ZakatCalculationFormX({
    required this.type,
    this.weight,
    this.money,
    this.golds = const [],
    this.shares = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      NameX.type: type.name,
      NameX.weight: weight,
      NameX.money: money,
      NameX.golds: golds.map((e) => e.toJson(),).toList(),
      NameX.shares: shares,
    };
  }
}
