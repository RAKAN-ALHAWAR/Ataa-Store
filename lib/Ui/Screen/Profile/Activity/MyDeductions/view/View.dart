import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';
import 'Sections/header.dart';

class MyDeductionsView extends GetView<MyDeductionsController> {
  const MyDeductionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "My Deductions",
        actions: [CartIconButtonsX()],
      ),
      body:SafeArea(
        child: Obx( () => AbsorbPointer(
          absorbing: controller.isLoading.value,
          child: ScrollRefreshLoadMoreX(
              key: controller.scrollRefreshLoadMoreKey,
              fetchData: controller.getData,
              isGetMoreEnabled: false,
              padding: const EdgeInsets.symmetric(
                vertical: StyleX.vPaddingApp,
                horizontal: StyleX.hPaddingApp,
              ),
              header: const HeaderSectionX(),
              isScrollingHeader: true,
              isHideHeaderIfLoading: false,
              spaceBetweenHeaderAndContent: 24,
              initLoading: const LoadingSectionX(),
              pageSize: 20,
              isShowLoadMoreLoading: controller.isShowMore.value,
              isShowNoMoreData: controller.isShowMore.value,
              emptyMessage: 'You have not made any deductions yet.',
              itemBuilder: (data, index) {
                if (index > 6 && !controller.isShowMore.value) {
                  return const SizedBox();
                } else if (index == 6 && !controller.isShowMore.value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonX.second(
                        width: 140,
                        text: 'Show More',
                        iconData: IconX.ourBanks,
                        onTap: controller.onShowMore,
                      ).fadeAnimationX(60 * (index>6?6:index + 1)),
                    ],
                  );
                } else {
                  return MyDeductionCardX(
                    myDeduction: data,
                    buttonState: controller.buttonsState[index],
                    onTransactionHistory: ()async=> await controller.onTransactionHistory(data),
                    onUnsubscribe: () async {
                      /// Bottom sheet to confirm cancellation of subscription to deduction
                      await bottomSheetDangerousX(
                        icon: Icons.warning_rounded,
                        onOk: () async =>
                        await controller.onUnsubscribe(data,index),
                        okText: "Unsubscribe",
                        title: "Cancel participation in deduction",
                        message:
                        "You are about to opt out of the deduction. Are you sure you want to cancel?",
                      );
                    },
                  ).fadeAnimationX(60 * (index>6?6:index + 1));
                }
              },
            ),
        ),
        ),
      ),
    );
  }
}
