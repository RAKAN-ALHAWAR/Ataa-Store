import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';


class DonationSharesX{
  DonationSharesX({
    required this.id,
    required this.price,
  });

  final String id;
  final double price;

  factory DonationSharesX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationSharesX(
        id: json[NameX.id].toStrX,
        price: json[NameX.price].toDoubleX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.price,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.price: price,
    };
  }
}