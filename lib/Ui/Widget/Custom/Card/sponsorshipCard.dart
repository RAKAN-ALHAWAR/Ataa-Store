part of '../../widget.dart';

class SponsorshipCardX extends StatelessWidget {
  const SponsorshipCardX({
    super.key,
    required this.sponsorship,
    required this.onAddToCart,
    required this.onDonation,
    this.payDonationButtonState = ButtonStateEX.normal,
    this.addToCartButtonState = ButtonStateEX.normal,
  });
  final SponsorshipX sponsorship;
  final Function(SponsorshipX sponsorship) onDonation;
  final Function(SponsorshipX sponsorship) onAddToCart;
  final ButtonStateEX payDonationButtonState;
  final ButtonStateEX addToCartButtonState;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      radius: StyleX.radius,
      margin: const EdgeInsetsDirectional.only(bottom: 14),
      width: double.maxFinite,
      // height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Cover
          ContainerX(
            color: Theme.of(context).colorScheme.onPrimary,
            height: 75,
            width: double.maxFinite,
            child: Center(
              child: Icon(
                sponsorship.gender=="male"?IconX.male:IconX.female,
                size: 40,
                color: ColorX.primary,
              ),
            ),
          ),
          const SizedBox(height: 22),

          /// Muslim Num & Country
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (sponsorship.muslimNum != null)
                TextX(
                  "${"Muslim".tr} ${sponsorship.muslimNum!}",
                  style: TextStyleX.titleLarge,
                  fontWeight: FontWeight.w700,
                ),
              if (sponsorship.muslimNum == null)
                TextX(
                  "Prayers for Islam",
                  style: TextStyleX.titleLarge,
                  fontWeight: FontWeight.w700,
                ),
              Row(
                children: [
                  TextX(
                    sponsorship.country,
                    style: TextStyleX.titleSmall,
                  ),
                  const SizedBox(width: 8),
                  if(sponsorship.countryFlagCode.toUpperCase()=='SY')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.asset('assets/images/flags/sy.png',width: 30,height: 22.5,),
                  ),
                  if(sponsorship.countryFlagCode.toUpperCase()!='SY')
                  CountryFlag.fromCountryCode(
                    sponsorship.countryFlagCode.toUpperCase(),
                    width: 30,
                    height: 22.5,
                    borderRadius: 3,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Course Name
          if (sponsorship.courseName != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextX("Course name", style: TextStyleX.supTitleMedium,
      color: Theme.of(context).colorScheme.secondary,),
                const SizedBox(height: 6),
                TextX(
                  sponsorship.courseName!,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                ),
              ],
            ),
          const SizedBox(height: 12),

          /// Previous Religion & Gender & Language
          Row(
            children: [
              if (sponsorship.previousReligion != null)
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextX("Previous religion",
                          style: TextStyleX.supTitleMedium,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(height: 6),
                      TextX(
                        sponsorship.previousReligion!,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextX("Gender", style: TextStyleX.supTitleMedium,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 6),
                    TextX(
                      sponsorship.gender,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextX("Language", style: TextStyleX.supTitleMedium,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(height: 6),
                    TextX(
                      sponsorship.language,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          /// Donation Amount & Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  children: [
                    TextX(
                      FunctionX.formatLargeNumber(sponsorship.donationAmount),
                      style: TextStyleX.titleLarge,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      IconX.sar,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  ButtonStateX(
                    maxWidth: 150,
                    text: "Donate Now",
                    state: payDonationButtonState,
                    iconData: Icons.payments_rounded,
                    onTap: () async => await onDonation(sponsorship),
                  ),
                  const SizedBox(width: 8),
                  ButtonStateX.second(
                    maxWidth: 55,
                    state: addToCartButtonState,
                    iconData: Icons.shopping_cart_rounded,
                    onTap: () async => await onAddToCart(sponsorship),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
