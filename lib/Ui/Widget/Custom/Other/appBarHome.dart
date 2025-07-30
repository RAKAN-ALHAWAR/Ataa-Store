part of '../../widget.dart';

class AppBarHomeX extends StatelessWidget {
  const AppBarHomeX({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -27,
          right: 0,
          left: 0,
          child: Container(
            height: 140,
            decoration: BoxDecoration(
              color: ColorX.primary,
              borderRadius:
              const BorderRadiusDirectional.all(
                Radius.circular(StyleX.radiusAppBar),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30,bottom: 3),
          child: child
        )
      ],
    ).marginOnly(bottom: 10);
  }
}
