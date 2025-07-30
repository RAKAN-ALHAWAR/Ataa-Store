part of '../../widget.dart';

class AdsCardsX extends StatefulWidget {
  const AdsCardsX({super.key, required this.ads, required this.onTap, required this.onTapButton});
  final List<AdsX> ads;
  final Function(AdsX) onTap;
  final Function(AdsX) onTapButton;

  @override
  State<AdsCardsX> createState() => _AdsCardsXState();
}

class _AdsCardsXState extends State<AdsCardsX> {
  final PageController adsController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentIndex < widget.ads.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      try {
        if (adsController.hasClients) {
          adsController.animateToPage(
            currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeIn,
          );
        }
      } catch (_) {}
    });
  }

  @override
  void dispose() {
    adsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: StyleX.adsCardHeight,
          width: double.maxFinite,
          child: PageView(
            controller: adsController,
            children: [
              for (int index = 0; index < widget.ads.length; index++)
                AdCardX(
                  onTap: widget.onTap,
                  onTapButton: widget.onTapButton,
                  ad: widget.ads[index],
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        SmoothPageIndicator(
          controller: adsController,
          count: widget.ads.length,
          onDotClicked: (index) {
            adsController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          effect: ExpandingDotsEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: ColorX.primary,
            dotColor: ColorX.primary.shade300,
            expansionFactor: 4,
          ),
        ),
      ],
    );
  }
}