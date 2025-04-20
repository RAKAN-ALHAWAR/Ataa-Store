part of '../../widget.dart';

class MyGiftCardX extends StatelessWidget {
  const MyGiftCardX({
    super.key,
    required this.gift,
  });
  final PaymentTransactionItemX<GiftOrderX> gift;

  @override
  Widget build(BuildContext context) {
    return AccordionX(
      title: gift.name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActivityDataRowX(
            title: "Mahdi Name",
            data: gift.orderModel!.giftBasic.recipientName,
          ).fadeAnimation100,
          ActivityDataRowX(
            title: "Gift amount",
            dataWidget: Row(
              children: [
                TextX(
                  FunctionX.formatLargeNumber(gift.price),
                  fontWeight: FontWeight.w700,
                  maxLines: 1,
                ),
                const SizedBox(width: 6),
                const Icon(IconX.sar, size: 15),
              ],
            ),
          ).fadeAnimation100,
          ActivityDataRowX(
            title: "Payment method",
            data: gift.paymentTransaction.paymentMethodLocalized ??
                gift.paymentTransaction.paymentMethod.name,
          ).fadeAnimation200,
          if (gift.paymentTransaction.createdAt != null)
            ActivityDataRowX(
              title: "Gift date",
              data: intl.DateFormat('dd/MM/yyyy')
                  .format(gift.paymentTransaction.createdAt!),
            ).fadeAnimation200,
          InkWell(
            onTap: () =>
                Get.toNamed(RouteNameX.previewGift, arguments: gift.orderModel),
            child: ActivityDataRowX(
              title: "Gift",
              dataWidget: Row(
                children: [
                  TextX(
                    "Preview gift",
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.open_in_new_rounded,
                    size: 22,
                    color: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ).fadeAnimation300,
          ),
          // if (gift.orderModel.giftUrl != null)
          //   InkWell(
          //     onTap: () async {
          //       try {
          //         await launchUrl(Uri.parse(gift.orderModel.giftUrl!));
          //       } catch (_) {}
          //     },
          //     child: ActivityDataRowX(
          //       title: "gift",
          //       dataWidget: Row(
          //         children: [
          //           TextX(
          //             "gift Link",
          //             fontWeight: FontWeight.w600,
          //             color: Theme.of(context).primaryColor,
          //           ),
          //           const SizedBox(width: 8),
          //           Icon(
          //             Icons.open_in_new_rounded,
          //             size: 22,
          //             color: Theme.of(context).primaryColor,
          //           )
          //         ],
          //       ),
          //     ).fadeAnimation300,
          //   ),
        ],
      ),
    );
  }
}
