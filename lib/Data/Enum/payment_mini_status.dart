enum PaymentMiniStatusX {
  initiated('initiated'),
  paid('paid'),
  failed('failed');

  final String name;
  const PaymentMiniStatusX(this.name);
}