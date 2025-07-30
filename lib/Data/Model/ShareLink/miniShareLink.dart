import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class MiniShareLinkX {
  final String id;
  final String affiliateCode;
  final String? ownerId;
  final String? ownerType;
  final String linkableId;
  final String linkableType;
  final String title;
  final String status;
  final String affiliateLink;

  MiniShareLinkX({
    required this.id,
    required this.affiliateCode,
    required this.ownerId,
    required this.ownerType,
    required this.linkableId,
    required this.linkableType,
    required this.title,
    required this.status,
    required this.affiliateLink,
  });

  factory MiniShareLinkX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => MiniShareLinkX(
        id: json[NameX.id].toStrDefaultX(''),
        affiliateCode: json[NameX.affiliateCode].toStrX,
        ownerId: json[NameX.ownerId].toStrNullableX,
        ownerType: json[NameX.ownerType].toStrNullableX,
        linkableId: json[NameX.linkableId].toStrX,
        linkableType: json[NameX.linkableType].toStrX,
        title: json[NameX.title].toStrX,
        status: json[NameX.status].toStrX,
        affiliateLink: json[NameX.affiliateLink].toStrX,
      ),
      requiredDataKeys: [
        NameX.affiliateCode,
        NameX.linkableId,
        NameX.linkableType,
        // NameX.linkable,
        NameX.title,
        NameX.status,
        NameX.affiliateLink,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.affiliateCode: affiliateCode,
      NameX.ownerId: ownerId,
      NameX.ownerType: ownerType,
      NameX.linkableId: linkableId,
      NameX.linkableType: linkableType,
      NameX.title: title,
      NameX.status: status,
      NameX.affiliateLink: affiliateLink,
    };
  }
}