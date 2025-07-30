part of '../../widget.dart';

class MyCampaignCardX extends StatelessWidget {
  const MyCampaignCardX({
    super.key,
    required this.campaign,
    required this.onTap,
    required this.onEdit,
    required this.openShare,
  });

  final CampaignX campaign;
  final Function(CampaignX) onTap;
  final Function(CampaignX) onEdit;
  final Function(CampaignX) openShare;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      radius: StyleX.radius,
      margin: const EdgeInsetsDirectional.only(bottom: 14),
      padding: EdgeInsets.zero,
      width: double.maxFinite,
      child: GestureDetector(
        onTap: () async => await onTap(campaign),
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(StyleX.radius),
                    ),
                    child: ImageNetworkX(
                      height: 170,
                      width: double.maxFinite,
                      imageUrl:
                          campaign.donation.donationDetails.imageUrl ?? '',
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// Content
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Campaign Status
                        ContainerX(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                          radius: StyleX.radiusSm,
                          color: campaign.status==CampaignStatusX.pending?ColorX.yellow[Get.isDarkMode?800:100]:
                          campaign.status==CampaignStatusX.accepted?ColorX.green[Get.isDarkMode?800:100]:
                          campaign.status==CampaignStatusX.rejected?ColorX.red[Get.isDarkMode?800:100]:
                          ColorX.grey[Get.isDarkMode?800:100],
                          child: TextX(
                            campaign.status.name.tr,
                            style: TextStyleX.titleSmall,
                            fontWeight: FontWeight.w500,
                            color: campaign.status==CampaignStatusX.pending?ColorX.yellow[Get.isDarkMode?100:800]:
                            campaign.status==CampaignStatusX.accepted?ColorX.green[Get.isDarkMode?100:800]:
                            campaign.status==CampaignStatusX.rejected?ColorX.red[Get.isDarkMode?100:800]:
                            ColorX.grey[Get.isDarkMode?100:800],
                          ),
                        ),
                        const SizedBox(height: 13),
                        /// Title
                        TextX(
                          campaign.title,
                          size: 16,
                          fontWeight: FontWeight.w600,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),

                        Row(
                          children: [
                              Flexible(
                                child: ButtonX.second(
                                  onTap:  () async {
                                    await onTap(campaign);
                                  },
                                  text: "Campaign preview",
                                  iconData: Icons.remove_red_eye,
                                ),
                              ),
                              if(campaign.status==CampaignStatusX.pending || campaign.status==CampaignStatusX.accepted)
                              const SizedBox(width: 8),
                            if(campaign.status==CampaignStatusX.pending)
                              Flexible(
                                child: ButtonX.gray(
                                  onTap:() async {
                                    await onEdit(campaign);
                                  },
                                  text: 'Edit campaign',
                                  iconData: IconX.edit,
                                ),
                              ),
                            if(campaign.status==CampaignStatusX.accepted)
                              Flexible(
                                child: ButtonX(
                                  onTap:() async {
                                    await openShare(campaign);
                                  },
                                  text: 'Sharing',
                                  iconData: Icons.share_rounded,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
