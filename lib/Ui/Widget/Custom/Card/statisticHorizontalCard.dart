part of "../../widget.dart";

class StatisticHorizontalCardX extends StatelessWidget {
  const StatisticHorizontalCardX({
    super.key,
    this.icon,
    required this.statistic,
    required this.subtitle,
    this.imageUrl,
    this.textAfterNumber = '',
    this.color,
  });
  final Color? color;
  final num statistic;
  final String subtitle;
  final String textAfterNumber;
  final String? imageUrl;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: double.maxFinite,
      color: color ?? Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ContainerX(
            width: 50,
            height: 50,
            color: Theme.of(context).colorScheme.onPrimary,
            padding: EdgeInsets.zero,
            child: Center(
              child: imageUrl != null
                  ? ImageNetworkX(
                      imageUrl: imageUrl!,
                      height: 33,
                      width: 33,
                      radius: StyleX.radiusSm,
                    )
                  : Icon(
                      icon ?? IconX.statisticsAndFigures,
                      color: ColorX.primary,
                      size: 20,
                    ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(
                "${FunctionX.formatLargeNumber(statistic)} $textAfterNumber",
                style: TextStyleX.headerSmall,
                maxLines: 1,
              ),
              AutoSizeText(
                subtitle.tr,
                style: TextStyleX.titleMedium
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
