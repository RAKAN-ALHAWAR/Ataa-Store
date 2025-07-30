import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class SharingLinksSectionX extends GetView<StatisticsController> {
  const SharingLinksSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return StatisticGroupCardX(
      linkTo: RouteNameX.myShareLinks,
      linkTitle: "Go to Sharing Links",
      title: "Sharing Links",
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.share_rounded,
                  statistic: controller.shareLinkStatistics.value!.countLinks,
                  subtitle: "Number of links",
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.visibility_rounded,
                  statistic: controller.shareLinkStatistics.value!.countLinkVisits,
                  subtitle: "Number of visits",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  icon: Icons.person_add_alt_rounded,
                  statistic: controller.shareLinkStatistics.value!.countNewRegistrationsViaLinks,
                  subtitle: "New registrants",
                ),
              ),

              const SizedBox(width: 8),
              Flexible(
                child: StatisticCardX(
                  icon: Icons.favorite_rounded,
                  statistic: controller.shareLinkStatistics.value!.countDonationsViaLinks,
                  subtitle: "Number of donations",
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: StatisticCardX(
                  isMoney: true,
                  icon: Icons.payments_rounded,
                  statistic: controller.shareLinkStatistics.value!.totalAmountDonationsViaLinks,
                  subtitle: "Total donation amounts via links",
                ),
              ),
            ],
          ),
        ],
      ),
    ).fadeAnimation200;
  }
}
