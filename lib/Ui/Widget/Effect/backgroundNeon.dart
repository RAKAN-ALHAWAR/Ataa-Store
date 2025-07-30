part of '../widget.dart';

class BackgroundNeonX extends StatelessWidget {
  const BackgroundNeonX(
      {super.key,
        this.blur= 80.0,
        this.radius,
        required this.child,
        required this.neonShapes,
      });

  final double blur;
  final Widget child;
  final List<NeonShapeX> neonShapes;
  final BorderRadiusGeometry? radius;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ...neonShapes,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: const SizedBox(),
          ),
        ),
        child
      ],
    );
  }
}