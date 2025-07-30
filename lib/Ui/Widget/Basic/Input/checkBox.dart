part of '../../widget.dart';

class CheckBoxX extends StatelessWidget {
  const CheckBoxX({super.key, required this.value, required this.onChanged});
  final bool value;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      side: WidgetStateBorderSide.resolveWith(
        (states) => BorderSide(width: 1.0, color: ColorX.grey.shade300),
      ),
    );
  }
}
