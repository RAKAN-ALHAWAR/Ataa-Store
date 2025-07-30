import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Helper/model/model.dart';
import 'package:ataa/Data/data.dart';

class NotificationX {
  final String id;
  final String type;
  final String? titleDonor;
  final String? contentDonor;
  final String? titleUser;
  final String? contentUser;
  final bool isReadByDonor;
  final bool isReadByUser;
  final String donorId;
  final String relatableId;
  final String relatableType;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NotificationX({
    required this.id,
    required this.type,
    this.titleDonor,
    this.contentDonor,
    this.titleUser,
    this.contentUser,
    required this.isReadByDonor,
    required this.isReadByUser,
    required this.donorId,
    required this.relatableId,
    required this.relatableType,
    required this.createdAt,
    this.updatedAt,
  });

  factory NotificationX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => NotificationX(
        id: json[NameX.id].toStrX,
        type: json[NameX.type].toStrX,
        titleDonor: json[NameX.titleDonor].toStrNullableX,
        contentDonor: json[NameX.contentDonor].toStrNullableX,
        titleUser: json[NameX.titleUser].toStrNullableX,
        contentUser: json[NameX.contentUser].toStrNullableX,
        isReadByDonor: json[NameX.isReadByDonor].toBoolDefaultX(false),
        isReadByUser: json[NameX.isReadByUser].toBoolDefaultX(false),
        donorId: json[NameX.donorId].toStrX,
        relatableId: json[NameX.relatableId].toStrX,
        relatableType: json[NameX.relatableType].toStrX,
        createdAt: json[NameX.createdAt].toDateTimeX,
        updatedAt: json[NameX.updatedAt].toDateTimeNullableX,
      ),
      requiredDataKeys: [
        NameX.id,
        NameX.type,
        NameX.donorId,
        NameX.relatableId,
        NameX.relatableType,
        NameX.createdAt,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.type: type,
      NameX.titleDonor: titleDonor,
      NameX.contentDonor: contentDonor,
      NameX.titleUser: titleUser,
      NameX.contentUser: contentUser,
      NameX.isReadByDonor: isReadByDonor,
      NameX.isReadByUser: isReadByUser,
      NameX.donorId: donorId,
      NameX.relatableId: relatableId,
      NameX.relatableType: relatableType,
      NameX.createdAt: createdAt.toIso8601String(),
      NameX.updatedAt: updatedAt?.toIso8601String(),
    };
  }
}