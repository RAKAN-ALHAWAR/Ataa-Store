import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:intl/intl.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';
import 'Subclass/giftBasic.dart';

class GiftX {
  String giftCategoryId;
  String donationCategoryId;
  bool isShowAmount;
  bool isSendToMe;
  bool isSendLater;
  DateTime? sendLaterDate;
  GiftBasicX giftBasic;

  GiftX({
    required this.giftCategoryId,
    required this.donationCategoryId,
    required this.isShowAmount,
    required this.isSendToMe,
    required this.isSendLater,
    this.sendLaterDate,
    required this.giftBasic,
  });

  factory GiftX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => GiftX(
        giftCategoryId: json[NameX.giftCategoryId].toStrX,
        donationCategoryId: json[NameX.donationCategoryId].toStrX,
        isShowAmount: json[NameX.isShowAmount].toBoolX,
        isSendToMe: json[NameX.isSendToMe].toBoolX,
        isSendLater: json[NameX.isSendLater].toBoolX,
        sendLaterDate: json[NameX.sendLaterDate].toDateTimeNullableX,
        giftBasic: GiftBasicX.fromJson(json),
      ),
      requiredDataKeys: [
        NameX.giftCategoryId,
        NameX.donationCategoryId,
        NameX.isShowAmount,
        NameX.isSendToMe,
        NameX.isSendLater,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.giftCategoryId: giftCategoryId,
      NameX.donationCategoryId: donationCategoryId,
      NameX.isShowAmount: isShowAmount,
      NameX.isSendToMe: isSendToMe,
      NameX.isSendLater: isSendLater,
      if (isSendLater) NameX.sendLaterDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(sendLaterDate!),
      ...giftBasic.toJson(),
    };
  }
}
