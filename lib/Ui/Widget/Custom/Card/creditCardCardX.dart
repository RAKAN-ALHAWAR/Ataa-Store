part of '../../widget.dart';

class CreditCardCardX extends StatelessWidget {
  const CreditCardCardX({
    super.key,
    required this.paymentCard,
    required this.onSetDefault,
    required this.onDelete,
    required this.isLoadingSetDefault,
    required this.isLoadingDelete,
  });
  final PaymentCardX paymentCard;
  final bool isLoadingSetDefault;
  final bool isLoadingDelete;
  final Function() onSetDefault;
  final Function() onDelete;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.only(bottom: 10),
      height: 80,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: ImageNetworkX(
                    imageUrl: paymentCard.iconUrl ?? '',
                    width: 50,
                    height: 50,
                    failed: const Icon(
                      Icons.credit_card,
                      size: 50.0,
                      color: ColorX.grey,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: isLoadingSetDefault
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextX(
                     paymentCard.name,
                      style: TextStyleX.titleLarge,
                      fontWeight: FontWeight.w700,
                    ),
                    const SizedBox(height: 4),
                    if (paymentCard.isDefault)
                      TextX(
                        "Default",
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    if (!paymentCard.isDefault && !isLoadingSetDefault)
                      InkWell(
                        onTap: onSetDefault,
                        child: TextX(
                          "Select as default card",
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    if (isLoadingSetDefault)
                      const SizedBox(
                        height: 17,
                        width: 17,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: isLoadingDelete
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextX(
                    "****${paymentCard.last4Digits}",
                    fontWeight: FontWeight.w700,
                    style: TextStyleX.titleLarge,
                  ),
                ),
                const SizedBox(height: 4),
                if (!isLoadingDelete)
                  InkWell(
                    onTap: onDelete,
                    child: TextX(
                      "delete",
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                if (isLoadingDelete)
                  const SizedBox(
                    height: 17,
                    width: 17,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
