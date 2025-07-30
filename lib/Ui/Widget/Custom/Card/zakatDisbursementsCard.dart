part of "../../widget.dart";

class ZakatDisbursementsCardX extends StatelessWidget {
  const ZakatDisbursementsCardX({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: context.isDarkMode?ColorX.primary.shade100:ColorX.primary.shade50,
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 5,
      ),
      child: Row(
        children: [
          Icon(
            Icons.verified_rounded,
            size: 20,
            color: ColorX.primary,
          ),
          const SizedBox(width: 4),
          TextX(
            "Zakat expenditures",
            color: ColorX.primary,
            style: TextStyleX.supTitleMedium,
          ),
        ],
      ),
    );
  }
}
