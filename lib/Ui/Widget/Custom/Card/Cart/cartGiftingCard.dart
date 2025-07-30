part of '../../../widget.dart';

class CartGiftCardX extends StatefulWidget {
  const CartGiftCardX({
    super.key,
    required this.onDelete,
    required this.cartItem,
    required this.onUpdate,
    required this.minimumDonationAmount,
  });
  final CartItemX cartItem;
  final Function(CartItemX item) onDelete;
  final int minimumDonationAmount;
  final Function(
      CartItemX item, {
      String? price,
      }) onUpdate;

  @override
  State<CartGiftCardX> createState() => _CartGiftCardXState();
}

class _CartGiftCardXState extends State<CartGiftCardX> {
  bool isLoadingUpdate = false;
  bool isLoadingDelete = false;
  late CartItemX cartItem;
  TextEditingController priceController = TextEditingController();
  Timer? _debounceTimer;
  final Duration _debounceTimerDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    cartItem = widget.cartItem;
    priceController.text = cartItem.price.toString();
  }

  @override
  void didUpdateWidget(covariant CartGiftCardX oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cartItem != widget.cartItem) {
      setState(() {
        cartItem = widget.cartItem;
        priceController = TextEditingController(text: cartItem.price.toString());
      });
    }
  }
  String? validateAmount(String? val) {
    String? message;
    message = ValidateX.giftMoney(val);

    /// Verify the lowest possible donation value in Free Donation
    if (message == null &&
        num.parse(priceController.text) < widget.minimumDonationAmount) {
      message =
      "${"The minimum donation amount is".tr} ${widget.minimumDonationAmount} ${"SAR".tr}";
    }
    return message;
  }
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoadingUpdate || isLoadingDelete,
      child: ContainerX(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 18),
        isBorder: true,
        child: Column(
          children: [
            Row(
              children: [
                /// Image
                ImageNetworkX(
                  imageUrl: cartItem.imageUrl ?? '',
                  height: 50,
                  width: 50,
                  radius: StyleX.radiusSm,
                ).marginSymmetric(horizontal: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextX(
                        'Gift - '.tr+cartItem.name,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 9),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 250),
                        child: Column(
                          children: [
                              SizedBox(
                                width: 180,
                                child: TextFieldX(
                                  controller: priceController,
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  hint: "0",
                                  borderColor: context.isDarkMode
                                      ? null
                                      : ColorX.grey.shade300,
                                  color: Theme.of(context).cardColor,
                                  validate: validateAmount,
                                  onChanged: (val) {
                                    if(validateAmount(val) == null){
                                      if (_debounceTimer?.isActive ?? false) {
                                        _debounceTimer!.cancel();
                                      }
                                      _debounceTimer = Timer(_debounceTimerDuration, () async {
                                        setState(() {
                                          isLoadingUpdate = true;
                                        });
                                        try {
                                          await widget.onUpdate(
                                            cartItem,
                                            price: val,
                                          );
                                        } catch (_) {}
                                        setState(() {
                                          isLoadingUpdate = false;
                                        });
                                      });
                                    }
                                  },
                                  suffixWidget: Icon(
                                    IconX.sar,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    setState(() {
                      isLoadingDelete = true;
                    });
                    try {
                      await widget.onDelete(cartItem);
                    } catch (_) {}
                    setState(() {
                      isLoadingDelete = false;
                    });
                  },
                  icon: const Icon(
                    Icons.delete_rounded,
                  ),
                ).marginSymmetric(horizontal: 6),
              ],
            ),
            if (isLoadingUpdate || isLoadingDelete)
              Row(
                children: [
                  TextX(
                    isLoadingUpdate?'Updating now':'Deleting now',
                    color: isLoadingDelete?Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: isLoadingDelete?Theme.of(context).colorScheme.error:Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ).paddingOnly(top: 10).marginSymmetric(horizontal: 18).sizeAnimation200,
          ],
        ),
      ),
    );
  }
}
