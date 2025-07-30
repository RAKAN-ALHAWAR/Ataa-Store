import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';


class DonationSharesPackageX{
  DonationSharesPackageX({
    required this.id,
    required this.name,
    required this.sharesCount,
  });

  final String id;
  final String name;
  final int sharesCount;

  factory DonationSharesPackageX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationSharesPackageX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        sharesCount: json[NameX.sharesCount].toIntX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.name,
        NameX.sharesCount,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.sharesCount: sharesCount,
    };
  }
}