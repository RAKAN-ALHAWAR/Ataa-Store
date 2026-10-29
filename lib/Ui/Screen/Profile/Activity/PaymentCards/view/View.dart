import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../GeneralState/empty.dart';
import '../../../../../GeneralState/error.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';

class PaymentCardsView extends GetView<PaymentCardsController> {
  const PaymentCardsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Payment cards",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getData(),
          builder: (context, snapshot) {
            /// Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingSectionX();
            }

            /// Error State
            if (snapshot.hasError) {
              return ErrorView(
                error: snapshot.error,
              );
            }

            return Obx(
              () {
                /// Empty State
                if (controller.paymentCards.isEmpty) {
                  return EmptyView(
                    message: "You do not have payment cards registered",
                    buttonText: "Add a new card",
                    mainAxisAlignment: MainAxisAlignment.start,
                    onTap: controller.onAddPaymentCard,
                  );
                }

                /// Main Content
                return AbsorbPointer(
                  absorbing: controller.isLoading.value,
                  child: Scaffold(
                    body: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: StyleX.hPaddingApp,
                        vertical: StyleX.vPaddingApp,
                      ),
                      itemCount: controller.paymentCards.length + 1,

                      /// Cards
                      itemBuilder: (context, index) {
                        if (controller.paymentCards.length == index) {
                          return ButtonX(
                            key: const Key('Add card button'),
                            onTap: controller.onAddPaymentCard,
                            text: 'Add a new card',
                          ).fadeAnimationX(60 * index + 1);
                        }
                        return CreditCardCardX(
                          key: Key(controller.paymentCards[index].id),
                          paymentCard: controller.paymentCards[index],
                          isLoadingDelete: controller.isLoadingDelete[index],
                          isLoadingSetDefault:
                              controller.isLoadingSetDefault[index],

                          /// Bottom sheet to confirm deletion
                          onDelete: () async {
                            await bottomSheetDangerousX(
                              icon: Icons.delete_rounded,
                              title: "Delete the card",
                              okText: "Delete the card",
                              message:
                                  "Do you want to delete this card?\nThe card will be deleted from your card list",
                              onOk: () async => await controller.onDeleteCard(
                                  controller.paymentCards[index].id, index),
                            );
                          },

                          /// Bottom sheet to confirm set as default
                          onSetDefault: () async {
                            await bottomSheetSuccessX(
                              icon: IconX.creditCard,
                              title: "The card is default",
                              okText: "Set as default",
                              message:
                                  "You are about to set this card as default, do you still want to set it?",
                              onOk: () async => await controller.onSetDefault(
                                  controller.paymentCards[index].id, index),
                            );
                          },
                        ).fadeAnimationX(60 * index + 1);
                      },
                    ),

                    /// Create a new payment card button
                    // floatingActionButton: FloatingActionButtonX(
                    //   onTap: controller.onAddPaymentCard,
                    //   icon: Icons.add,
                    // ).fadeAnimation300,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
