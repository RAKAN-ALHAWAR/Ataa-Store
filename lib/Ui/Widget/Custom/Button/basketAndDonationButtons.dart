part of "../../widget.dart";

class AddToCartAndDonationButtonsX extends StatelessWidget {
  const AddToCartAndDonationButtonsX({
    super.key,
    required this.onDonation,
    this.onAddToCart,
    this.sameSize = true,
    required this.payDonationButtonState,
    this.addToCartButtonState = ButtonStateEX.normal,
    this.disabled = false,
  });
  final bool sameSize;
  final bool disabled;
  final ButtonStateEX payDonationButtonState;
  final ButtonStateEX addToCartButtonState;
  final Function()? onDonation;
  final Function()? onAddToCart;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (onDonation != null)
          Flexible(
            flex: sameSize ? 2 : 7,
            child: ButtonStateX(
              colorDisabledButton: context.isDarkMode
                  ? ColorX.primary.shade300.withValues(alpha: 0.2)
                  : ColorX.primary.withValues(alpha: 0.4),
              colorDisabledBorder: Colors.transparent,
              colorDisabledText:
                  context.isDarkMode ? Colors.white38 : Colors.white,
              disabled: disabled,
              state: payDonationButtonState,
              onTap: onDonation!,
              text: "Donate Now",
              iconData: Icons.payments_rounded,
            ),
          ),
        if (onAddToCart != null && onDonation != null)
          const SizedBox(
            width: 8,
          ),
        if (onAddToCart != null)
          Flexible(
            flex: 2,
            child: ButtonStateX.second(
              colorDisabledButton: Colors.transparent,
              colorDisabledBorder: context.isDarkMode
                  ? ColorX.primary.shade300.withValues(alpha: 0.4)
                  : ColorX.primary.withValues(alpha: 0.4),
              colorDisabledText: context.isDarkMode
                  ? ColorX.primary.shade300.withValues(alpha: 0.4)
                  : ColorX.primary.withValues(alpha: 0.4),
              disabled: disabled,
              state: addToCartButtonState,
              onTap: onAddToCart!,
              iconData: Icons.shopping_cart_rounded,
              text: sameSize ? "Add to cart" : null,
            ),
          ),
      ],
    );
  }
}
