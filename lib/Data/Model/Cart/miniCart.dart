import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class MiniCartX {
  String id;
  int countItem;
  String message;

  MiniCartX({
    required this.id,
    required this.countItem,
    required this.message,
  });

  factory MiniCartX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
      (json) => MiniCartX(
        id: json[NameX.id].toStrDefaultX(''),
        countItem: json[NameX.cartItemsCount].toIntDefaultX(0),
        message: json[NameX.message].toStrDefaultX(''),
      ),
      requiredDataKeys: [
        // NameX.id,
        // NameX.cartItemsCount,
      ],
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.countItem: countItem,
      NameX.message: message,
    };
  }
}
