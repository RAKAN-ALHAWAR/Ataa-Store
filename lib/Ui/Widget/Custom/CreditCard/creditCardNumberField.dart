part of '../../widget.dart';

class CreditCardNumberFieldX extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool disabled;
  final bool? onlyRead;
  final bool autofocus;
  final EdgeInsets margin;
  final Color? color;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  const CreditCardNumberFieldX({
    super.key,
    required this.controller,
    this.label,
    this.hint="Card number",
    this.autofocus = false,
    this.textInputAction,
    this.disabled = false,
    this.onlyRead,
    this.margin = const EdgeInsets.symmetric(vertical: 5),
    this.color,
    this.onChanged,
  });

  @override
  State<CreditCardNumberFieldX> createState() => _CreditCardNumberFieldXState();
}

class _CreditCardNumberFieldXState extends State<CreditCardNumberFieldX> {
  CreditCardTypeEX type = CreditCardTypeEX.others;
  @override
  void initState() {
    super.initState();
    type = CreditCardTypeEX.others;
    widget.controller.addListener(_getCardTypeFrmNumber);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) LabelInputX(widget.label!),
          TextFieldX(
            disabled: widget.disabled,
            autofocus: widget.autofocus,
            onChanged: widget.onChanged,
            validate: CreditCardUtilsX.validateCardNum,
            onlyRead: widget.onlyRead??widget.disabled,
            textInputType: TextInputType.number,
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(19),
              CardNumberInputFormatter(),
            ],
            hint: widget.hint,

            prefixWidget: CreditCardCompanyX(cardType: type,width: 20,margin: const EdgeInsets.all(10),),
          )
        ],
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    widget.controller.removeListener(_getCardTypeFrmNumber);
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CreditCardUtilsX.getCleanedNumber(widget.controller.text);
    setState(() {
      type = CreditCardUtilsX.getCardTypeFrmNumber(input);
    });
  }

}