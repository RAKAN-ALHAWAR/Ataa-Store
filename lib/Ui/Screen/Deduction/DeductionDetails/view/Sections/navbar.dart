import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class NavBarSectionX extends GetView<DeductionDetailsController> {
  const NavBarSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,

      /// Card
      child: ContainerX(
        isShadow: true,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(StyleX.radiusMd),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: 20,
        ),

        /// Subscription Button
        child:  Obx(
              (){
                if(controller.isSubscribed.value){
                  return ButtonX.gray(
                    text: 'Subscribed',
                    onTap: () {},
                  );
                }else{
                  return ButtonStateX(
                    state: controller.subscriptionButtonState.value,
                    onTap: ()async=> await controller.onSubscriptionDonation(),
                    text: "Subscribe Now",
                    iconData: Icons.payments_rounded,
                  );
                }
              }
        ).fadeAnimation600,
      ),
    );
  }
}
