import 'dart:io';

import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Data/Enum/payment_method_status.dart';
import 'package:ataa/Data/data.dart';
import '../PaymentCard/paymentCardForm.dart';

class PaymentTransactionFormX {
  final double? price;
  final PaymentMethodStatusX paymentMethod;
  final String? applePayToken;
  final String? googlePayToken;
  final String? paymentCardId;
  final PaymentCardFormX? paymentCard;
  final bool? isSavePaymentCard;
  final String? bankAccountId;
  final File? transferImageFile;

  PaymentTransactionFormX({
    this.price,
    required this.paymentMethod,
    this.paymentCardId,
    this.paymentCard,
    this.isSavePaymentCard,
    this.applePayToken,
    this.googlePayToken,
    this.bankAccountId,
    this.transferImageFile,
  });

  Map<String, dynamic> toJson() {
    return {
      if(price!=null)
      NameX.price: price,
      NameX.paymentMethod: paymentMethod.name,
      if(paymentCardId!=null||paymentCard!=null)
      NameX.paymentTransactionCard: {
        if(paymentCardId!=null)
        NameX.paymentCardId: paymentCardId,
        if(paymentCard!=null)
        NameX.newPaymentCard: paymentCard?.toJson(),
        if(isSavePaymentCard!=null)
        NameX.isSavePaymentCard: isSavePaymentCard.toIntNullableX,
      },
      if(applePayToken!=null)
      NameX.applepayToken: applePayToken,
      if(googlePayToken!=null)
      NameX.googlePayToken: googlePayToken,
      if(bankAccountId!=null)
      NameX.bankAccountId: bankAccountId,
      // if(transferImageFile!=null)
      // NameX.transferImageFile: transferImageFile,
    };
  }
}
