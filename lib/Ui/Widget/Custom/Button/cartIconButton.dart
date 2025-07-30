part of "../../widget.dart";

class CartIconButtonsX extends StatelessWidget {
  CartIconButtonsX({
    super.key,
    this.color = Colors.white,
    this.colorBadge = const Color(0xffF59700),
    this.isAnimation = true,
  });
  final Color colorBadge;
  final Color color;
  final bool isAnimation;
  final CartGeneralControllerX controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
        child: Obx(
           () => badges.Badge(
            showBadge: (controller.countItem.value) > 0,
            position: badges.BadgePosition.topEnd(top: -4, end: -2),
            badgeStyle: badges.BadgeStyle(
              badgeColor: colorBadge,
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1,
              ),
            ),
            badgeContent: TextX(
              (controller.countItem.value).toString(),
              color: Colors.white,
              style: TextStyleX.supTitleSmall.copyWith(fontSize: 11),
              fontWeight: FontWeight.w600,
            ),
            child: InkResponse(
              onTap: controller.openCart,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.shopping_cart, color: color, size: 28),
              ),
            ),
          ),
        ),
      ).fadeAnimationX(100, isDisable: !isAnimation),
    );
  }
}
