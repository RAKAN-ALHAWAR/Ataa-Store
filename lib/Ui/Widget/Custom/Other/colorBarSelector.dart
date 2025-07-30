part of "../../widget.dart";

class ColorBarSelectorX extends StatelessWidget {
  const ColorBarSelectorX(
      {super.key,
      required this.colors,
      required this.colorSelectedIndex,
      required this.onChangeColor,
        this.isPadding=true,
      });
  final List<String> colors;
  final int colorSelectedIndex;
  final bool isPadding;
  final Function(int) onChangeColor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: isPadding?const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
      ):null,
      child: Row(
        children: [
          for (int index = 0; index < colors.length; index++)
            GestureDetector(
              onTap: () => onChangeColor(index),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 6),
                child: ContainerX(
                  padding: EdgeInsets.zero,
                  borderColor: colorSelectedIndex == index
                      ? ColorHelperX.toMaterial(Color(
                    int.parse("0xff${colors[index]}"),
                  )).shade200
                      : null,
                  borderWidth: 4,
                  radius: 100,
                  color: Color(
                    int.parse("0xff${colors[index]}"),
                  ),
                  isBorder: true,
                  width: 45,
                  height: 45,
                  child: colorSelectedIndex == index
                      ? const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                    ),
                  )
                      : const SizedBox(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
