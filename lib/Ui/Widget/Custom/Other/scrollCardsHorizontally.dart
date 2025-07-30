part of '../../widget.dart';

class ScrollCardsHorizontallyX extends StatelessWidget {
  const ScrollCardsHorizontallyX({super.key, required this.title, required this.icon, required this.cards, this.onShowMore, this.height});
  final String title;
  final IconData icon;
  final List<Widget> cards;
  final Function()? onShowMore;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleX(
          icon: icon,
          title: title,
          showMore: onShowMore,
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            height: height,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: StyleX.hPaddingApp,
                right: StyleX.hPaddingApp,
                bottom: 16,
                top: 8,
              ),
              scrollDirection: Axis.horizontal,
              child: Row(children: cards),
            ),
          ),
        ),
      ],
    );
  }
}
