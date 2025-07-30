import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../Enum/recurring_status.dart';
import '../../data.dart';

class DeductionX{
  String id;
  int code;
  String name;
  RecurringStatusX recurring;
  String? recurringLocalized;

  int? order; // don't know
  bool status; // don't know

  double achievedAmount;
  int subscribersCount;

  String description;

  String? day;
  String? dayLocalized;

  DateTime? startDate;
  DateTime? endDate;

  String imageUrl;
  String videoUrl;

  OrganizationX? org;

  double? initialPrice;
  bool isOpenPrice;
  bool isSubscribed;
  
  DeductionX({
    required this.id,
    required this.name,
    required this.code,
    required this.recurring,
    required this.recurringLocalized,

    this.order,
    required this.status,

    required this.achievedAmount,
    required this.subscribersCount,

    required this.description,

    required this.imageUrl,
    required this.videoUrl,

    this.org,

    this.day,
    this.dayLocalized,

    this.startDate,
    this.endDate,

    this.initialPrice,
    required this.isOpenPrice,
    required this.isSubscribed,
  });


  factory DeductionX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});
    Map<String, Object?> donationCategoryJson = Map<String, dynamic>.from(json[NameX.donationCategory]??{});

    return ModelUtilX.checkFromJson(
        json,
            (json) => DeductionX(
              id: json[NameX.id].toStrX,
              code: json[NameX.code].toIntX,
              name: json[NameX.name].toStrX,
              recurring: RecurringStatusX.values.firstWhere((x) => x.name==json[NameX.recurring].toStrX),
              recurringLocalized: json[NameX.recurringLocalized].toStrNullableX,

              order: json[NameX.order].toIntNullableX,
              status: json[NameX.status].toBoolDefaultX(true),

              achievedAmount: json[NameX.achievedAmount].toDoubleDefaultX(0.0),
              subscribersCount: json[NameX.subscribersCount].toIntDefaultX(0),

              description: json[NameX.description].toStrDefaultX(''),

              imageUrl: imageJson[NameX.url].toStrDefaultX(''),
              videoUrl: json[NameX.videoUrl].toStrDefaultX(''),

              org: donationCategoryJson.toFromJsonNullableX(OrganizationX.fromJson),

              day: json[NameX.day].toStrNullableX,
              dayLocalized: json[NameX.dayLocalized].toStrNullableX,

              startDate: json[NameX.startDate].toDateTimeNullableX,
              endDate: json[NameX.endDate].toDateTimeNullableX,

              initialPrice: json[NameX.initialPrice].toDoubleNullableX,
              isOpenPrice: json[NameX.isOpenPrice].toBoolDefaultX(false),
              isSubscribed: json[NameX.isSubscribed].toBoolDefaultX(false),
            ),
        requiredDataKeys: [
          NameX.id,
          NameX.code,
          NameX.name,
          NameX.recurring,
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id:id,
      NameX.code:code,
      NameX.name:name,
      NameX.recurring:recurring.name,
      NameX.recurringLocalized:recurringLocalized,
      NameX.order:order,
      NameX.status:status,
      NameX.achievedAmount:achievedAmount,
      NameX.subscribersCount:subscribersCount,
      NameX.description:description,
      NameX.image: {NameX.url:imageUrl},
      NameX.videoUrl:videoUrl,
      NameX.donationCategory:org?.toJson(),
      NameX.day:day,
      NameX.dayLocalized:dayLocalized,
      NameX.startDate:startDate,
      NameX.endDate:endDate,
      NameX.initialPrice:initialPrice,
      NameX.isOpenPrice:isOpenPrice,
      NameX.isSubscribed:isSubscribed,
    };
  }
}
