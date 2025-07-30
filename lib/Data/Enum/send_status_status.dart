enum SendStatusStatusX {
  pending('pending'),
  sent('sent'),
  failed('failed');

  final String name;
  const SendStatusStatusX(this.name);
}