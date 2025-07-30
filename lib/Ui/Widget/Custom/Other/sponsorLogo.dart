part of '../../widget.dart';

class SponsorLogoX extends StatelessWidget {
  final double height;
  const SponsorLogoX({this.height=50,super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      context.isDarkMode?ImageX.sponsorLogoWhite:ImageX.sponsorLogo,
      height: height,
    );
  }
}
