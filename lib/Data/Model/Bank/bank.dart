part of '../../data.dart';

class BankX {
  BankX({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.bankAccounts,
  });

  String id;
  String name;
  String imageUrl;
  List<BankAccountX> bankAccounts;

  factory BankX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> imageJson = Map<String, Object?>.from(json[NameX.image] ?? {});
    return ModelUtilX.checkFromJson(
        json,
            (json) => BankX(
          id: json[NameX.id].toStrDefaultX(''),
          name: json[NameX.name].toStrX,
          imageUrl: imageJson[NameX.url].toStrDefaultX(''),
          bankAccounts: ModelUtilX.generateItems(json[NameX.bankAccounts] as List, BankAccountX.fromJson),
        ),
        requiredDataKeys: [],
        requiredAnyDataOfKeys: [
          [
            NameX.name,
            NameX.bankAccounts,
          ]
        ]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.image: {NameX.url: imageUrl},
      NameX.bankAccounts: [bankAccounts.map((e) => e.toJson())],
    };
  }
}
