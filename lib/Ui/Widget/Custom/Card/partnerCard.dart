part of "../../widget.dart";

class PartnerCardX extends StatelessWidget {
  const PartnerCardX({super.key, required this.partner, required this.onTap});
  final PartnerX partner;
  final Function(PartnerX) onTap;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      height: StyleX.partnerCardHeight,
      width: StyleX.partnerCardWidth,
      margin: const EdgeInsetsDirectional.only(end: 12),
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
      child: GestureDetector(
        onTap: () => onTap(partner),
        child: ImageNetworkX(
          width: StyleX.partnerCardWidth - 32,
          radius: StyleX.radiusSm,
          imageUrl: partner.imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
