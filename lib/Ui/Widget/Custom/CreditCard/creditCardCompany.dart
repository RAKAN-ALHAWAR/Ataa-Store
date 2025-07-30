part of '../../widget.dart';

class CreditCardCompanyX extends StatelessWidget {
  const CreditCardCompanyX({super.key, required this.cardType,this.height,this.width, this.margin});
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final CreditCardTypeEX cardType;
  @override
  Widget build(BuildContext context) {
    String img = "";
    Icon? icon;
    switch (cardType) {
      case CreditCardTypeEX.master:
        img = ImageX.masterCreditCard;
        break;
      case CreditCardTypeEX.visa:
        img = ImageX.visaCreditCard;
        break;
      case CreditCardTypeEX.verve:
        img = ImageX.verveCreditCard;
        break;
      case CreditCardTypeEX.americanExpress:
        img = ImageX.americanExpressCreditCard;
        break;
      case CreditCardTypeEX.discover:
        img = ImageX.discoverCreditCard;
        break;
      case CreditCardTypeEX.dinersClub:
        img = ImageX.dinersClubCreditCard;
        break;
      case CreditCardTypeEX.jcb:
        img = ImageX.jcbCreditCard;
        break;
      case CreditCardTypeEX.mada:
        img = ImageX.madaCreditCard;
        break;
      case CreditCardTypeEX.others:
        icon =  Icon(
          Icons.credit_card,
          size: width??40.0,
          color: ColorX.grey,
        );
        break;
      default:
        icon =  Icon(
          Icons.warning,
          size: width??40.0,
          color: ColorX.grey,
        );
        break;
    }
    late Widget widget;
    if (img.isNotEmpty) {
      widget = Image.asset(
        img,
        width: width??40,
      );
    } else {
      widget = icon!;
    }

    return Padding(
      padding: margin??EdgeInsets.zero,
      child: widget,
    );
  }
}
