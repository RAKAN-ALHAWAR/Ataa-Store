part of '../../data.dart';

class ProductX{
  ProductX({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.numOfStore,
    required this.rating,
    required this.reviews,
    required this.colors,
    required this.sizes,
    required this.imageUrl,
    required this.numSales,
  });

  late String id;
  late String name;
  late String description;
  late int price;
  late int numOfStore;
  late double rating;
  late int reviews;
  late int numSales;
  late List<String> colors;
  late List<String> sizes;
  late List<String> imageUrl;

}