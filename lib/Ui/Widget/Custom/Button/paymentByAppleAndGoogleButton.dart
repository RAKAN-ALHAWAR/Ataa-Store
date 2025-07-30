part of "../../widget.dart";

class PaymentByAppleAndGoogleButtonX extends StatelessWidget {
  const PaymentByAppleAndGoogleButtonX(
      {super.key, required this.isApple, required this.onTap, required this.state});
  final bool isApple;
  final Function() onTap;
  final ButtonStateEX state;
  @override
  Widget build(BuildContext context) {
    return ButtonStateX(
      state: state,
      colorButton: ColorX.grey.shade900,
      colorText: Colors.white,
      borderColor: context.isDarkMode?Theme.of(context).dividerColor:Colors.transparent,
      text: isApple?"Pay with Apple Pay".tr:"Pay with Google Pay",
      onTap: onTap,
      icon: Image.asset(
        isApple ? ImageX.apple : ImageX.google,
        height: 20,
      ),
    );
  }
}
