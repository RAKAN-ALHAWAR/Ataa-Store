part of '../../widget.dart';

class NumberFieldX extends StatefulWidget {
  final EdgeInsets margin;
  final double min;
  final double max;
  final double step;
  final String? label;
  final num value;
  final int decimals;
  final bool disabled;
  final Color? color;
  final Function(double) onChanged;

  const NumberFieldX({
    super.key,
    this.margin = const EdgeInsets.symmetric(vertical: 5),
    required this.onChanged,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.decimals = 0,
    this.label,
    this.disabled = false,
    this.color,
    required this.value,
  });

  @override
  State<NumberFieldX> createState() => _NumberFieldXState();
}

class _NumberFieldXState extends State<NumberFieldX> {
  late double value;

  @override
  void initState() {
    super.initState();
    value = widget.value.toDouble();
  }

  @override
  void didUpdateWidget(covariant NumberFieldX oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      setState(() {
        value = widget.value.toDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.label != null) LabelInputX(widget.label!),
        ContainerX(
          color: widget.disabled
              ? Theme.of(context).disabledColor
              : widget.color ?? Theme.of(context).cardTheme.color,
          height: StyleX.inputHeight - 2,
          margin: widget.margin,
          padding: EdgeInsets.zero,
          isBorder: true,
          child: SpinBox(
            iconSize: 20,
            min: widget.min,
            max: widget.max,
            value: value,
            step: widget.step,
            decimals: widget.decimals,
            onChanged: (val) {
              if (val <= 0) {
                val = 1;
              }
              setState(() {
                value = val;
              });
              widget.onChanged(val);
            },
            decoration: InputDecoration(
              helperStyle: TextStyleX.supTitleMedium.copyWith(
      color: Theme.of(context).colorScheme.secondary,),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
