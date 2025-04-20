part of "../../widget.dart";

class FreeDonationOptionsX extends StatelessWidget {
  const FreeDonationOptionsX({
    super.key,
    required this.onSelected,
    this.isMarginTop = true,
    required this.selected,
    this.title = "Donation Amount",
  });
  final Function(int val) onSelected;
  final String title;
  final bool isMarginTop;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInputX(
          title,
          marginTop: isMarginTop ? 20 : 0,
        ),
        Row(
          children: [
            for (int x in [20, 50, 100])
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: x != 100 ? 10 : 0),
                  child: selected == x
                      ? ButtonX(
                          onTap: () => onSelected(x),
                          text: x.toString(),
                          iconFirst: TranslationX.getLanguageCode == 'ar'
                              ? false
                              : true,
                          icon: Icon(
                            IconX.sar,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 14,
                          ),
                        )
                      : ButtonX.gray(
                          onTap: () => onSelected(x),
                          text: x.toString(),
                          iconFirst: TranslationX.getLanguageCode == 'ar'
                              ? false
                              : true,
                          icon: Icon(
                            IconX.sar,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 16,
                          ),
                          colorText: Theme.of(context).iconTheme.color,
                        ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
