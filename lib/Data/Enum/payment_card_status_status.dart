enum PaymentCardStatusStatusX {
  initiated('initiated'),
  active('active'),
  inactive('inactive'),
  saveOnly('save_only');

  final String name;
  const PaymentCardStatusStatusX(this.name);
}