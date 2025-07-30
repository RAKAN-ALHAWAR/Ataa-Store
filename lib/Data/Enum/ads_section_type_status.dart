enum AdsSectionTypeStatusX {
  donation('donation_opportunities'),
  org('donation_category'),
  deduction('deductions'),
  zakat('zakat_expenditures'),
  gift('gifts');

  final String name;
  const AdsSectionTypeStatusX(this.name);
}