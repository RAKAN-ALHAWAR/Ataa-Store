part of '../../widget.dart';

class ProfileAccountCardX extends StatelessWidget {
  const ProfileAccountCardX({super.key, required this.children,this.isButtonPadding=false});
  final List<Widget> children;
  final bool isButtonPadding;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -25,
          right: 0,
          left: 0,
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: ColorX.primary,
              // borderRadius: const BorderRadiusDirectional.only(
              //   bottomEnd: Radius.circular(StyleX.radiusAppBar),
              // ),
            ),
          ),
        ),
        ContainerX(
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
          ),
          padding:  EdgeInsets.symmetric(vertical: isButtonPadding?16:12,horizontal: isButtonPadding?16:12),
          child: Column(children: children),
        ).fadeAnimation200,
      ],
    );
  }
}
