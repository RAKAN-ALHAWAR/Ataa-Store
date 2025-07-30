enum PaymentStatusStatusX {
  initiated('initiated'),
  paid('paid'),
  failed('failed'),
  // authorized('authorized'),
  // captured('captured'),
  refunded('refunded'),
  voided('voided'),
  verified('verified'),
  unknown('unknown');

  final String name;
  const PaymentStatusStatusX(this.name);
}