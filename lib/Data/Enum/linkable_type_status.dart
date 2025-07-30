enum LinkableTypeStatusX {
  donation('Project'),
  org('DonationCategory'),
  campaign('Campaign'),
  deduction('RecurringDonation');

  final String name;
  const LinkableTypeStatusX(this.name);
}