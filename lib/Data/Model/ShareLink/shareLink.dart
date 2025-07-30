import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class ShareLinkX {
  final String id;
  final String affiliateCode;
  final String? ownerId;
  final String? ownerType;
  final String linkableId;
  final String linkableType;
  final String title;
  final int visits;
  final int registrations;
  final int logins;
  final int donationsCount;
  final int donorsCount;
  final int donationsSum;
  final String status;
  final String createdAt;
  final String affiliateLink;

  ShareLinkX({
    required this.id,
    required this.affiliateCode,
    required this.ownerId,
    required this.ownerType,
    required this.linkableId,
    required this.linkableType,
    required this.title,
    required this.visits,
    required this.registrations,
    required this.logins,
    required this.donationsCount,
    required this.donorsCount,
    required this.donationsSum,
    required this.status,
    required this.createdAt,
    required this.affiliateLink,
  });

  factory ShareLinkX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => ShareLinkX(
        id: json[NameX.id].toStrX,
        affiliateCode: json[NameX.affiliateCode].toStrX,
        ownerId: json[NameX.ownerId].toStrNullableX,
        ownerType: json[NameX.ownerType].toStrNullableX,
        linkableId: json[NameX.linkableId].toStrX,
        linkableType: json[NameX.linkableType].toStrX,
        title: json[NameX.title].toStrX,
        visits: json[NameX.visits].toIntX,
        registrations: json[NameX.registrations].toIntX,
        logins: json[NameX.logins].toIntX,
        donationsCount: json[NameX.donationsCount].toIntX,
        donorsCount: json[NameX.donorsCount].toIntX,
        donationsSum: json[NameX.donationsSum].toIntX,
        status: json[NameX.status].toStrX,
        createdAt: json[NameX.createdAt].toStrX,
        affiliateLink: json[NameX.affiliateLink].toStrX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.affiliateCode,
        NameX.linkableId,
        NameX.linkableType,
        // NameX.linkable,
        NameX.title,
        NameX.visits,
        NameX.registrations,
        NameX.logins,
        NameX.donationsCount,
        NameX.donorsCount,
        NameX.donationsSum,
        NameX.status,
        NameX.createdAt,
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
      // NameX.linkable:linkable.toJson(),
      NameX.title: title,
      NameX.visits: visits,
      NameX.registrations: registrations,
      NameX.logins: logins,
      NameX.donationsCount: donationsCount,
      NameX.donorsCount: donorsCount,
      NameX.donationsSum: donationsSum,
      NameX.status: status,
      NameX.createdAt: createdAt,
      NameX.affiliateLink: affiliateLink,
    };
  }
}