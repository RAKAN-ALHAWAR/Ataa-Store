import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationOpenPackageX{
  DonationOpenPackageX({
    required this.id,
    required this.name,
    required this.price,
  });

  final String id;
  final String name;
  final double price;
  
  factory DonationOpenPackageX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationOpenPackageX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        price: json[NameX.price].toDoubleX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.name,
        NameX.price,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.price: price,
    };
  }
}