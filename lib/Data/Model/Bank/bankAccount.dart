part of '../../data.dart';

class BankAccountX {
  BankAccountX({
    required this.id,
    required this.name,
    required this.iban,
    required this.status,
    this.bankId,
    this.organizationId,
    this.bank,
  });

  String id;
  String name;
  String iban;
  bool status;
  String? bankId;
  String? organizationId;
  BankX? bank;

  factory BankAccountX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> bankJson = Map<String, Object?>.from(json[NameX.bank] ?? {});
    return ModelUtilX.checkFromJson(
      json,
      (json) => BankAccountX(
        id: json[NameX.id].toStrDefaultX(''),
        name: json[NameX.accountNumber].toStrX,
        iban: json[NameX.iban].toStrX,
        status: json[NameX.status].toBoolDefaultX(true),
        bankId: json[NameX.bankId].toStrNullableX,
        organizationId: json[NameX.orgId].toStrNullableX,
        bank: bankJson.toFromJsonNullableX(BankX.fromJson),
      ),
      requiredAnyDataOfKeys: [
        [
          NameX.accountNumber,
          NameX.iban,
        ]
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.name: name,
      NameX.iban: iban,
      NameX.status: status,
      if(bankId!=null) NameX.bankId: bankId,
      if(organizationId!=null) NameX.orgId: organizationId,
      if(bank!=null) NameX.bank: bank?.toJson(),
    };
  }
}
