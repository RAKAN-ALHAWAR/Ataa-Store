part of '../../widget.dart';

class DonationCardX extends StatelessWidget {
  const DonationCardX({
    super.key,
    required this.donation,
    this.campaign,
    this.isSmallCard = false,
    required this.onDonation,
    this.onTap,
    required this.onAddToCart,
    required this.doneImageUrl,
  });
  final bool isSmallCard;
  final DonationX donation;
  final CampaignX? campaign;
  final String? doneImageUrl;
  final Function()? onTap;
  final Function(DonationX donation) onDonation;
  final Function(DonationX id) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      radius: StyleX.radius,
      margin: isSmallCard
          ? const EdgeInsetsDirectional.only(end: 14)
          : const EdgeInsetsDirectional.only(bottom: 14),
      padding: EdgeInsets.zero,
      width: isSmallCard ? StyleX.donationCardWidthSM : double.maxFinite,
      height: isSmallCard ? StyleX.donationCardHeight : null,
      child: GestureDetector(
        onTap: onTap?.call??() {
          Get.toNamed(
            RouteNameX.donationDetails,
            arguments: donation.donationBasic.code,
          );
        },
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      /// Cover Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(StyleX.radius),
                        ),
                        child: ImageNetworkX(
                          height: 170,
                          width: double.maxFinite,
                          imageUrl: donation.donationDetails.imageUrl ?? '',
                        ),
                      ),

                      if (donation.donationBasic.isDone)
                        Positioned.fill(
                          child: ImageNetworkX(
                            imageUrl: doneImageUrl ?? ImageX.doneDonation,
                            isFile: doneImageUrl == null,
                            empty: const SizedBox(),
                            fit: BoxFit.contain,
                          ).paddingAll(5),
                        ),

                      /// Zakat Marker
                      if (donation.donationSettings.isZakat)
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          start: 10,
                          top: 12,
                          child: const ZakatDisbursementsCardX(),
                        ),

                      /// Value Share
                      if (donation.donationShares != null)
                        Positioned.directional(
                          textDirection: Directionality.of(context),
                          start: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorX.primary,
                              borderRadius: const BorderRadiusDirectional.only(
                                topEnd: Radius.circular(StyleX.radiusMd),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Row(
                              children: [
                                TextX(
                                  "${"Value share is".tr} ${donation.donationShares?.price}",
                                  color: Colors.white,
                                  style: TextStyleX.supTitleMedium,
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  IconX.sar,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),

                      /// Share Button
                      Positioned.directional(
                        end: 10,
                        top: 10,
                        textDirection: Directionality.of(context),
                        child: InkResponse(
                          onTap: () async {
                            await shareSheet(
                              id: campaign!=null?campaign!.id:donation.id,
                              code: campaign!=null?campaign!.code: donation.donationBasic.code,
                              type: campaign!=null?LinkableTypeStatusX.campaign: LinkableTypeStatusX.donation,
                            );
                          },
                          child: const ContainerX(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Icon(Icons.share_rounded),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  /// Content
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Donation Name
                        TextX(
                          campaign?.title??donation.donationBasic.name,
                          style: TextStyleX.titleMedium,
                          fontWeight: FontWeight.w700,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 10),

                        if (donation
                                .donationSettings.isShowCompletionIndicator &&
                            donation.donationSettings.isShowDonationsPercentage)
                          TextX(
                            "${"Collected".tr} ${campaign!=null?campaign!.completionRate.toStringAsFixed(2): (donation.donationBasic.completionRate % 1 == 0 ? donation.donationBasic.completionRate.toInt().toString() : donation.donationBasic.completionRate.toStringAsFixed(2))}%",
                            color: Theme.of(context).primaryColor,
                          ),
                        if (donation
                                .donationSettings.isShowCompletionIndicator &&
                            !donation
                                .donationSettings.isShowDonationsPercentage)
                          Row(
                            children: [
                              TextX(
                                "${"Collected".tr} ${FunctionX.formatLargeNumber(campaign?.currentDonations??donation.donationBasic.currentDonations)}",
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                IconX.sar,
                                color: Theme.of(context).primaryColor,
                                size: 14,
                              ),
                              const Spacer(),
                              TextX(
                                "${"Remaining".tr} ${FunctionX.formatLargeNumber(campaign?.remainingDonations??donation.donationBasic.remainingDonations)}",
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                IconX.sar,
                                color: Theme.of(context).colorScheme.secondary,
                                size: 14,
                              ),
                            ],
                          ),
                        if (donation.donationSettings.isShowCompletionIndicator)
                          const SizedBox(height: 8),

                        /// Completion Indicator Line
                        if (donation.donationSettings.isShowCompletionIndicator)
                          LinearProgressIndicator(
                            value: campaign!=null?(campaign!.completionRate/100):(donation.donationBasic.currentDonations /
                                donation.donationBasic.totalDonations),
                            borderRadius: BorderRadius.circular(50),
                            minHeight: 10,
                          ).marginOnly(top: 2, bottom: 8),

                        /// This space replaces the buttons and the extra 8 pixels are for their margin
                        const SizedBox(
                          height: StyleX.buttonHeight + 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),

              /// Buttons
              Positioned(
                bottom: 8,
                left: 16,
                right: 16,
                child: AddToCartAndDonationButtonsX(
                  disabled: donation.donationBasic.isDone || campaign?.donationStatus==false,
                  onDonation: () async => await onDonation(donation),
                  onAddToCart: () async => await onAddToCart(donation),
                  payDonationButtonState: ButtonStateEX.normal,
                  addToCartButtonState: ButtonStateEX.normal,
                  sameSize: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
