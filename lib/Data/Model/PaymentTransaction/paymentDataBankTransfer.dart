import 'package:ataa/Core/Extension/convert/convert.dart';
import '../../../Core/Helper/model/model.dart';
import '../../data.dart';

class PaymentDataBankTransferX {
  final String transferImageUrl;
  final BankAccountX bankAccount;

  PaymentDataBankTransferX({
    required this.transferImageUrl,
    required this.bankAccount,
  });

  factory PaymentDataBankTransferX.fromJson(Map<String, dynamic> json) {
    Map<String, Object?> bankAccountJson = Map<String, Object?>.from(json[NameX.bankAccount] ?? {});

    return ModelUtilX.checkFromJson(
      json,
      (json) => PaymentDataBankTransferX(
        transferImageUrl: json[NameX.transferImageUrl].toStrX,
        bankAccount: BankAccountX.fromJson(bankAccountJson),
      ),
      requiredDataKeys: [
        NameX.transferImageUrl,
        NameX.bankAccount,
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      NameX.transferImageUrl: transferImageUrl,
      NameX.bankAccount: bankAccount.toJson(),
    };
  }
}
