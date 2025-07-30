part of "../../widget.dart";

class AddToCartButtonX extends StatelessWidget {
  const AddToCartButtonX(
      {super.key,
        required this.onAddToCart,
      required this.addToCartButtonState,
      });
  final ButtonStateEX addToCartButtonState;
  final Function() onAddToCart;
  @override
  Widget build(BuildContext context) {
    return ButtonStateX(
      state: addToCartButtonState,
      onTap: onAddToCart,
      iconData: Icons.shopping_cart_rounded,
      text: "Add to cart",
    );
  }
}
