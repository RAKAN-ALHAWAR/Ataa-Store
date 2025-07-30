enum ModelTypeStatusX {
  donation('project'),
  gift('gift'),
  quickDonation('quick_donation'),
  campaign('campaign'),
  deduction('recurring_donation_subscription');

  final String name;
  const ModelTypeStatusX(this.name);
}