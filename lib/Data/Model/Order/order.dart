part of '../../data.dart';

abstract class OrderX {
  final String modelId;
  final ModelTypeStatusX modelType;
  final DateTime? createdAt;
  OrderX({
    required this.modelId,
    required this.modelType,
    required this.createdAt,
  });
  Map<String, dynamic> toJson();
}
