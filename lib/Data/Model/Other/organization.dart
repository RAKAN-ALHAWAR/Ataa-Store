part of '../../data.dart';

class OrganizationX {
  OrganizationX({
    required this.id,
    required this.name,
    this.description='',
    this.status = true,
    this.order,
    this.isShowHome = false,
    this.isShowQuickDonation = false,
    this.externalUrl = '',
    this.imageUrl = '',
    this.bannerUrl = '',
  });

  String id;
  String name;
  String description;

  bool status;
  int? order;

  bool isShowHome;
  bool isShowQuickDonation;

  String externalUrl;
  String imageUrl;
  String? bannerUrl;

  factory OrganizationX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson =
        Map<String, Object?>.from(json[NameX.image] ?? {});
    Map<String, Object?> bannerJson =
        Map<String, Object?>.from(json[NameX.banner] ?? {});

    return ModelUtilX.checkFromJson(
      json,
      (json) => OrganizationX(
        id: json[NameX.id].toStrX,
        name: json[NameX.name].toStrX,
        description: json[NameX.description].toStrDefaultX(''),
        status: json[NameX.status].toBoolDefaultX(true),
        order: json[NameX.order].toIntNullableX,
        isShowHome: json[NameX.isShowHome].toBoolX,
        isShowQuickDonation: json[NameX.isShowQuickDonation].toBoolX,
        externalUrl: imageJson[NameX.externalUrl].toStrDefaultX(''),
        imageUrl: imageJson[NameX.url].toStrDefaultX(''),
        bannerUrl: bannerJson[NameX.url].toStrNullableX,
      ),
      requiredAnyDataOfKeys: [
        [
          NameX.id,
          NameX.name,
          NameX.isShowHome,
          NameX.isShowQuickDonation,
        ]
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.description: description,
      NameX.status: status,
      NameX.order: order,
      NameX.isShowHome: isShowHome,
      NameX.isShowQuickDonation: isShowQuickDonation,
      NameX.externalUrl: externalUrl,
      NameX.image: {NameX.url: imageUrl},
      NameX.banner: {NameX.url: bannerUrl},
    };
  }
}
