part of '../widget.dart';

class NeonShapeX extends StatelessWidget {
  const NeonShapeX(
      {this.opacity = 0.4,
      this.size = 120.0,
      this.top,
      this.end,
      this.start,
      this.bottom,
      this.color,
      super.key});

  final double opacity;
  final double size;
  final double? top;
  final double? end;
  final double? start;
  final double? bottom;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: top,
      end: end,
      start: start,
      bottom: bottom,
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: (color ?? ColorX.primary).withValues(alpha: opacity),
      ),
    );
  }
}
