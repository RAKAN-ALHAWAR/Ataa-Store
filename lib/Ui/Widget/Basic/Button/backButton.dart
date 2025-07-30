part of '../../widget.dart';

class BackButtonX extends StatelessWidget {
  const BackButtonX({ this.onTap,this.color, super.key});
  final Function()? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: StyleX.hPaddingApp),
          child: InkWell(
            onTap: onTap??Get.back,
            borderRadius: BorderRadius.circular(StyleX.radius),
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(StyleX.radius),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
