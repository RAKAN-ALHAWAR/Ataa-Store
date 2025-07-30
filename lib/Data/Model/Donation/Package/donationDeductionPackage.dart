import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/recurring_status.dart';
import '../../../../Core/Helper/model/model.dart';
import '../../../data.dart';

class DonationDeductionPackageX{
  DonationDeductionPackageX({
    required this.id,
    required this.name,
    required this.recurring,
    required this.price,
    this.endDate,
  });

  final String id;
  final String name;
  final RecurringStatusX recurring;
  final double price;
  final DateTime? endDate;

  factory DonationDeductionPackageX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => DonationDeductionPackageX(
            id: json[NameX.id].toStrX,
            name: json[NameX.name].toStrX,
            recurring: RecurringStatusX.values.firstWhere((x) => x.name==json[NameX.recurring].toStrX),
            price: json[NameX.price].toDoubleX,
            endDate: json[NameX.endDate].toDateTimeNullableX,
          ),
      requiredDataKeys: [
        NameX.id,
        NameX.name,
        NameX.recurring,
        NameX.price,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.recurring: recurring.name,
      NameX.price: price,
    };
  }
}