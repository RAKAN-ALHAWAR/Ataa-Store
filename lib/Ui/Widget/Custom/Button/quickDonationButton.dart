part of "../../widget.dart";

class QuickDonationButton extends StatelessWidget {
  const QuickDonationButton({super.key, required this.onTap});
   final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: CircleAvatar(
        radius: 48,
        backgroundColor: Theme.of(context)
            .bottomNavigationBarTheme
            .backgroundColor,
        child: CircleAvatar(
          radius: 36,
          backgroundColor: Theme.of(context)
              .bottomNavigationBarTheme
              .selectedItemColor,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: TextX(
                'Quick Donation',
                color: Colors.white,
                style: TextStyleX.titleSmall,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
