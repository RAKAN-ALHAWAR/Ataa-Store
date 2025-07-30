part of '../../data.dart';

class DeliveryLocationX{
  DeliveryLocationX({
    required this.id,
    required this.country,
    required this.city,
    required this.street,
    required this.district,
    required this.latitude,
    required this.longitude,
    this.address,
  });
  DeliveryLocationX.empty(){
    id='';
    country='';
    city='';
    street='';
    district='';
    address='';
    latitude=0;
    longitude=0;
  }
  late String id;
  late String country;
  late String city;
  late String street;
  late String district;
  late String? address;
  late double latitude;
  late double longitude;

  factory DeliveryLocationX.fromJson(Map<String, dynamic> json) {
    return DeliveryLocationX(
      id: json[NameX.id].toString(),
      country: json[NameX.country].toString(),
      city: json[NameX.city].toString(),
      street: json[NameX.street].toString(),
      district: json[NameX.district].toString(),
      address: json[NameX.address],
      latitude: (json[NameX.latitude]??0)+0.0,
      longitude: (json[NameX.longitude]??0)+0.0,
    );
  }

  Map<String,dynamic> toJson(){
    return {};
  }
}