import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class GiftStatisticsX {
  GiftStatisticsX({
    required this.countGifts,
    required this.totalAmountGifts,
  });

  int countGifts;
  double totalAmountGifts;


  factory GiftStatisticsX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
        json,
            (json) => GiftStatisticsX(
              countGifts: json[NameX.countGifts].toIntX,
              totalAmountGifts: json[NameX.totalAmountGifts].toDoubleX,
        ),
        requiredAnyDataOfKeys: [
          [
            NameX.countGifts,
            NameX.totalAmountGifts,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.countGifts: countGifts,
      NameX.totalAmountGifts: totalAmountGifts,
    };
  }
}
