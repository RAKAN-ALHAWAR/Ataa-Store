part of "../../widget.dart";

class FreeDonationOptionsX extends StatelessWidget {
  const FreeDonationOptionsX({
    super.key,
    required this.onSelected,
    this.isMarginTop = true,
    required this.selected,
    this.title = "Donation Amount",
    this.amounts = const [20, 50, 100],
  });
  final Function(int val) onSelected;
  final String title;
  final bool isMarginTop;
  final int selected;

  /// Amount options to show. When empty, falls back to the default amounts.
  final List<int> amounts;

  static const List<int> _fallbackAmounts = [20, 50, 100];

  /// Chunk of buttons per row: 3 per row, and the last (shorter) row still
  /// stretches its buttons to fill the whole line (no empty gap beside them).
  static const int _perRow = 3;

  @override
  Widget build(BuildContext context) {
    final List<int> list = amounts.isEmpty ? _fallbackAmounts : amounts;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInputX(
          title,
          marginTop: isMarginTop ? 20 : 0,
        ),
        for (int start = 0; start < list.length; start += _perRow)
          Padding(
            padding: EdgeInsets.only(top: start == 0 ? 0 : 10),
            child: Row(
              children: [
                for (int i = start;
                    i < start + _perRow && i < list.length;
                    i++) ...[
                  Expanded(child: _amountButton(context, list[i])),
                  if (i < start + _perRow - 1 && i < list.length - 1)
                    const SizedBox(width: 10),
                ],
              ],
            ),
          ),
      ],
    );
  }

  Widget _amountButton(BuildContext context, int amount) {
    final bool isSelected = selected == amount;
    final Widget icon = Icon(
      IconX.sar,
      color: isSelected ? Colors.white : Theme.of(context).colorScheme.secondary,
      size: isSelected ? 14 : 16,
    );
    final bool iconFirst = TranslationX.getLanguageCode != 'ar';

    if (isSelected) {
      return ButtonX(
        onTap: () => onSelected(amount),
        text: amount.toString(),
        iconFirst: iconFirst,
        icon: icon,
      );
    }
    return ButtonX.gray(
      onTap: () => onSelected(amount),
      text: amount.toString(),
      iconFirst: iconFirst,
      icon: icon,
      colorText: Theme.of(context).iconTheme.color,
    );
  }
}
