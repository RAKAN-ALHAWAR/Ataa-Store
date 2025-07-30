import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/gift_color_status.dart';

import '../../../../Core/Helper/model/model.dart';
import '../../../Enum/gender_status.dart';
import '../../../data.dart';

class GiftBasicX {
  final String donorName;
  final int? donorMobile;
  final String recipientName;
  final int recipientMobile;
  final GenderStatusX recipientGender;
  final int price;
  final GiftColorStatusX color;

  GiftBasicX({
    required this.donorName,
    required this.donorMobile,
    required this.recipientName,
    required this.recipientMobile,
    required this.recipientGender,
    required this.price,
    required this.color,
  });

  factory GiftBasicX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => GiftBasicX(
        donorName: json[NameX.donorName].toStrX,
        donorMobile: json[NameX.donorMobile].toIntNullableX,
        recipientName: json[NameX.recipientName].toStrX,
        recipientMobile: json[NameX.recipientMobile].toIntX,
        recipientGender: GenderStatusX.values.firstWhere((x) => x.name==json[NameX.recipientGender].toStrX.toLowerCase(),),
        price: json[NameX.price].toIntX,
        color: GiftColorStatusX.values.firstWhere((x) => x.code==json[NameX.color].toStrX,orElse: () => GiftColorStatusX.teal,),
      ),
      requiredDataKeys: [
        NameX.donorName,
        NameX.recipientName,
        NameX.recipientMobile,
        NameX.recipientGender,
        NameX.price,
        NameX.color,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.donorName:donorName,
      NameX.donorMobile:donorMobile,
      NameX.recipientName:recipientName,
      NameX.recipientMobile:recipientMobile,
      NameX.recipientGender:recipientGender.name,
      NameX.price:price,
      NameX.color:color.code,
    };
  }
}