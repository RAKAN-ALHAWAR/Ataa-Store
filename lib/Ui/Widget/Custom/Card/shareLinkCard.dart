part of '../../widget.dart';

class ShareLinkCardX extends StatelessWidget {
  const ShareLinkCardX({
    super.key,
    required this.shareLink,
  });
  final ShareLinkX shareLink;

  @override
  Widget build(BuildContext context) {
    return AccordionX(
      title: shareLink.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActivityDataRowX(
            title: "Share link",
            dataWidget: InkWell(
              onTap: ()=>ClipboardX.copy(shareLink.affiliateLink),
              child: Row(
                children: [
                  TextX(
                    "Copy link",
                    fontWeight: FontWeight.w600,
                    style: TextStyleX.titleSmall,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    IconX.copy,
                    size: 22,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
          ).fadeAnimation100,
          ActivityDataRowX(
            title: "Number of visits",
            data: FunctionX.formatLargeNumber(shareLink.visits),
          ).fadeAnimation200,
          ActivityDataRowX(
            title: "New registrants",
            data:FunctionX.formatLargeNumber(shareLink.registrations),
          ).fadeAnimation300,
          ActivityDataRowX(
            title: "Number of donors",
            data: FunctionX.formatLargeNumber(shareLink.donorsCount),
          ).fadeAnimation300,
          ActivityDataRowX(
            title: "Total donations",
            dataWidget: Row(children: [
              TextX(
                FunctionX.formatLargeNumber(shareLink.donationsSum),
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              const SizedBox(width: 6),
              const Icon(IconX.sar,size: 15),
            ],),
          ).fadeAnimation300,
        ],
      ),
    );
  }
}
