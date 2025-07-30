part of "../../widget.dart";

class HomeAppBarLeadingX extends StatelessWidget {
  const HomeAppBarLeadingX({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
      child: Row(
        children: [
          SvgPicture.asset(ImageX.homeLogo,height: 54),
        ],
      ),
    );
  }
}
