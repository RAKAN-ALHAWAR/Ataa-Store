part of '../../widget.dart';

class MyDeductionCardX extends StatelessWidget {
  const MyDeductionCardX({
    super.key,
    required this.myDeduction,
    required this.onUnsubscribe,
    required this.onTransactionHistory,
    required this.buttonState,
  });
  final DeductionOrderX myDeduction;
  final ButtonStateEX buttonState;
  final Function() onUnsubscribe;
  final Function() onTransactionHistory;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextX(
                  myDeduction.deduction.name,
                  style: TextStyleX.titleLarge,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 16),
              ContainerX(
                radius: StyleX.radiusSm,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                color: myDeduction.deduction.status
                    ? myDeduction.status
                        ? (context.isDarkMode?ColorX.green.shade200:ColorX.green.shade100)
                        : (context.isDarkMode?ColorX.red.shade200:ColorX.red.shade100)
                    : Theme.of(context).dividerColor,
                child: TextX(
                  myDeduction.deduction.status
                      ? myDeduction.status
                          ? 'Active'
                          : 'Disabled'
                      : 'Expired',
                  color: myDeduction.deduction.status
                      ? myDeduction.status
                          ? ColorX.green.shade800
                          : ColorX.red.shade800
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              TextX(
                FunctionX.formatLargeNumber(myDeduction.price),
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(width: 6),
              const Icon(IconX.sar,size: 14),
              TextX(
                " / ${myDeduction.deduction.recurring.name.tr}",
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextX(
            '${'Next discount in'.tr} ${intl.DateFormat('yyyy/MM/dd').format(myDeduction.nextSubscriptionDiscountDate)}',
            style: TextStyleX.supTitleLarge,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ImageNetworkX(
                imageUrl: myDeduction.paymentTransactionCard?.iconUrl ??
                    '',
                height: 26,
                width: 26,
              ),
              TextX(
                myDeduction.paymentTransactionCard
                        ?.paymentCardCompany ??
                    '',
              ).marginSymmetric(horizontal: 8),
              Directionality(
                textDirection: TextDirection.ltr,
                child: TextX(
                  "****${myDeduction.paymentTransactionCard?.lastFourDigits}",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: ButtonX(
                  text: "Transaction history",
                  colorText: Theme.of(context).textTheme.titleLarge?.color,
                  colorButton: Theme.of(context).dividerColor,
                  onTap: onTransactionHistory,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: AbsorbPointer(
                  absorbing: !(myDeduction.deduction.status && myDeduction.status),
                  child: Opacity(
                    opacity: myDeduction.deduction.status && myDeduction.status?1: context.isDarkMode?0.55:0.4,
                    child: myDeduction.deduction.status?ButtonStateX.dangerous(
                      state: buttonState,
                      text: "Unsubscribe",
                      onTap: onUnsubscribe,
                    ):ButtonX.gray(
                      text: 'Subscription expired',
                      onTap: (){},
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
