part of '../../data.dart';

class PageX {
  PageX({
    required this.id,
    required this.title,
    required this.tag,
    required this.contentHTML,
    required this.isActive,
    this.order,
  });

  String id;
  String title;
  String tag;
  String contentHTML;
  bool isActive;
  int? order;

  factory PageX.fromJson(Map<String, dynamic> json) {
    return ModelUtilX.checkFromJson(
      json,
          (json) => PageX(
        id: json[NameX.id].toStrDefaultX(''),
        title: json[NameX.title].toStrX,
        tag: json[NameX.tag].toStrDefaultX(''),
        contentHTML: json[NameX.content].toStrX,
        isActive: json[NameX.isActive].toBoolDefaultX(true),
        order: json[NameX.order].toIntNullableX,
      ),
      requiredDataKeys: [
        NameX.title,
        NameX.content,
      ],
    );
  }

  /// Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.title: title,
      NameX.tag: tag,
      NameX.content: contentHTML,
      NameX.isActive: isActive,
      NameX.order: order,
    };
  }
}