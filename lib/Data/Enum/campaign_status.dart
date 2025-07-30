enum CampaignStatusX{
  accepted('accepted'),
  rejected('rejected'),
  disabled('disabled'),
  pending('pending');

  final String name;
  const CampaignStatusX(this.name);
}