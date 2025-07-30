import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Data/Enum/model_type_status.dart';
import '../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class MainContentSectionX extends GetView<CartController> {
  const MainContentSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: StyleX.vPaddingApp),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: StyleX.hPaddingApp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => ButtonStateX.dangerous(
                    state: controller.buttonStateDeleteAll.value,
                    text: 'Delete All',
                    iconData: Icons.delete_rounded,
                    maxWidth: 150,
                    onTap: () async {
                      await bottomSheetDangerousX(
                        icon: Icons.delete_rounded,
                        title: 'Delete All',
                        okText: 'Delete',
                        message:
                            'Are you sure you want to delete all items from your cart?',
                        onOk: controller.onDeleteAllItems,
                      );
                    },
                  ).fadeAnimation200,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: StyleX.hPaddingApp,
                right: StyleX.hPaddingApp,
                bottom: StyleX.vPaddingApp,
                top: 10,
              ),
              child: Form(
                key: controller.formKey,
                autovalidateMode: controller.autoValidate,
                child: GetBuilder<CartController>(
                  builder: (controller) => Obx(
                    () => Column(
                      children: [
                        /// Donation Items
                        ...controller.cartGeneral.cart.value.items
                            .where((e) =>
                        e.order.modelType == ModelTypeStatusX.donation)
                            .map(
                              (item) {
                            return CartDonationCardX(
                              cartItem: item,
                              onDelete: controller.onDeleteItem,
                              onUpdate: controller.onUpdate,
                              minimumDonationAmount: controller.app.generalSettings.minimumDonationAmount,
                            ).fadeAnimation300;
                          },
                        ),

                        /// Campaign Items
                        ...controller.cartGeneral.cart.value.items
                            .where((e) =>
                        e.order.modelType == ModelTypeStatusX.campaign)
                            .map(
                              (item) {
                            return CartDonationCardX(
                              cartItem: item,
                              isCampaign:true,
                              onDelete: controller.onDeleteItem,
                              onUpdate: controller.onUpdate,
                              minimumDonationAmount: controller.app.generalSettings.minimumDonationAmount,
                            ).fadeAnimation300;
                          },
                        ),

                        /// Gift Items
                        ...controller.cartGeneral.cart.value.items
                            .where((e) =>
                                e.order.modelType == ModelTypeStatusX.gift)
                            .map(
                          (item) {
                            return CartGiftCardX(
                              cartItem: item,
                              onDelete: controller.onDeleteItem,
                              onUpdate: controller.onUpdate,
                              minimumDonationAmount: controller.app.generalSettings.minimumDonationAmount,
                            ).fadeAnimation300;
                          },
                        ),

                        // /// Sponsorship Items
                        // ...controller.sponsorships.map(
                        //       (sponsorship) {
                        //     return CartSponsorshipCardX(
                        //       sponsorship: sponsorship,
                        //       onDelete: controller.onDeleteSponsorshipItem,
                        //     ).fadeAnimation400;
                        //   },
                        // ),
                        //
                        // /// Product Items
                        // ...controller.orderProducts.map(
                        //   (productItem) {
                        //     return CartProductCardX(
                        //       product: controller.getProductById(productItem.productID),
                        //       productItem: productItem,
                        //       onDelete: controller.onDeleteProductItem,
                        //       onChangedNum: controller.onChangeProductNum,
                        //     ).fadeAnimation400;
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
