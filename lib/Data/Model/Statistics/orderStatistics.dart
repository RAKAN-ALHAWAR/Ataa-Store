import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class OrderStatisticsX {
  OrderStatisticsX({
    required this.countOrders,
    required this.countCompletedOrders,
    required this.totalAmountOrders,
  });

  int countOrders;
  int countCompletedOrders;
  double totalAmountOrders;


  factory OrderStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => OrderStatisticsX(
              countOrders: json[NameX.countOrders].toIntX,
              countCompletedOrders: json[NameX.countCompletedOrders].toIntX,
              totalAmountOrders: json[NameX.totalAmountOrders].toDoubleX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.countOrders,
            NameX.countCompletedOrders,
            NameX.totalAmountOrders,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.countOrders: countOrders,
      NameX.countCompletedOrders: countCompletedOrders,
      NameX.totalAmountOrders: totalAmountOrders,
    };
  }
}
