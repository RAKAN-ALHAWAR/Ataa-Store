part of '../../../widget.dart';

class CartSponsorshipCardX extends StatelessWidget {
  const CartSponsorshipCardX({
    super.key,
    required this.sponsorship,
    required this.onDelete,
  });
  final SponsorshipX sponsorship;
  final Function(SponsorshipX basketItem) onDelete;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 10),
      isBorder: true,
      child: Row(
        children: [
          ContainerX(
            color: Theme.of(context).colorScheme.onPrimary,
            radius: StyleX.radiusSm,
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 55,
            width: 55,
            child: Center(
              child: Icon(
                Icons.person_rounded,
                size: 30,
                color: ColorX.primary,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (sponsorship.muslimNum != null)
                  TextX(
                    "${"Muslim".tr} ${sponsorship.muslimNum!}",
                    style: TextStyleX.titleSmall,
                    fontWeight: FontWeight.w700,
                  ),
                if (sponsorship.muslimNum == null)
                  TextX(
                    "Prayers for Islam",
                    style: TextStyleX.titleSmall,
                    fontWeight: FontWeight.w700,
                  ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Row(
                    children: [
                      TextX(
                        FunctionX.formatLargeNumber(sponsorship.donationAmount),
                        style: TextStyleX.titleSmall,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 5),
                      Icon(
                        IconX.sar,
                        size: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20
          ),
          IconButton(
            onPressed: () async => onDelete(sponsorship),
            icon: Icon(
              Icons.delete_rounded,
              color: ColorX.danger.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
