part of '../../widget.dart';

class LogoX extends StatelessWidget {
  final double height;
  const LogoX({this.height=50,super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      context.isDarkMode?ImageX.logoWhite:ImageX.logo,
      height: height,
    );
  }
}
