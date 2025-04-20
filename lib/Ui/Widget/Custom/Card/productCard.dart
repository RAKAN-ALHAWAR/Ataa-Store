part of '../../widget.dart';

class ProductCardX extends StatelessWidget {
  const ProductCardX({
    super.key,
    required this.onAddToCart,
    required this.product,
    required this.onTap,
    this.margin = const EdgeInsetsDirectional.only(end: 14),
    this.width,
  });
  final Function(String id) onTap;
  final Function(ProductX product) onAddToCart;
  final EdgeInsetsGeometry margin;
  final ProductX product;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      radius: StyleX.radius,
      margin: margin,
      padding: EdgeInsets.zero,
      width: width ?? StyleX.productCardWidth,
      height: StyleX.productCardHeight,
      child: GestureDetector(
        onTap: () async => await onTap(product.id),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              /// Product Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    StyleX.radius,
                  ),
                ),
                child: ImageNetworkX(
                  height: 150,
                  width: double.maxFinite,
                  imageUrl: product.imageUrl[0],
                ),
              ),
              const SizedBox(height: 4),

              /// Product Details
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Product Name
                      Expanded(
                        child: Center(
                          child: Row(
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  product.name.tr,
                                  style: TextStyleX.titleMedium
                                      .copyWith(fontWeight: FontWeight.w600),
                                  minFontSize: TextStyleX.titleSmall.fontSize!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              /// Price
                              TextX(
                                FunctionX.formatLargeNumber(product.price),
                                style: TextStyleX.titleMedium,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(width: 5),

                              /// Price Currency
                              const Icon(
                                IconX.sar,
                                size: 14,
                              ),
                              const Spacer(),

                              /// Rating Number
                              TextX(
                                product.rating.toString(),
                                style: TextStyleX.titleSmall,
                                color: Theme.of(context).primaryColor,
                              ),
                              const SizedBox(width: 4),

                              /// Stars
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          /// Button
                          AddToCartButtonX(
                            onAddToCart: () async => await onAddToCart(product),
                            addToCartButtonState: ButtonStateEX.normal,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
