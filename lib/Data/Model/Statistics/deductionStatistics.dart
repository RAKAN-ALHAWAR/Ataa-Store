import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class DeductionStatisticsX {
  DeductionStatisticsX({
    required this.countDeductions,
    required this.totalAmountDeductions,
  });

  int countDeductions;
  double totalAmountDeductions;


  factory DeductionStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => DeductionStatisticsX(
              countDeductions: json[NameX.countDeductions].toIntX,
              totalAmountDeductions: json[NameX.totalAmountDeductions].toDoubleX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.countDeductions,
            NameX.totalAmountDeductions,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.countDeductions: countDeductions,
      NameX.totalAmountDeductions: totalAmountDeductions,
    };
  }
}
