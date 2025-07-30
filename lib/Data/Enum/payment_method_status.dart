enum PaymentMethodStatusX {
  creditCard('credit_card'),
  bankTransfer("bank_transfer"),
  applePay("applepay"),
  googlePay("googlepay");

  final String name;
  const PaymentMethodStatusX(this.name);
}