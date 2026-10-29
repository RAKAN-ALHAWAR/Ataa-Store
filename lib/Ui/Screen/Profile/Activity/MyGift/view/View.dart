import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';

class MyGiftingView extends GetView<MyGiftingController> {
  const MyGiftingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "My Gifting",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: GetBuilder<MyGiftingController>(
          builder: (controller) => ScrollRefreshLoadMoreX(
            fetchData: controller.getData,
            padding: const EdgeInsets.symmetric(
              vertical: StyleX.vPaddingApp,
              horizontal: StyleX.hPaddingApp,
            ),
            initLoading: const LoadingSectionX(),
            pageSize: 20,
            isShowLoadMoreLoading: controller.isShowMore,
            isShowNoMoreData: controller.isShowMore,
            emptyMessage: 'You have not made any dedications yet.',
            itemBuilder: (data, index) {
              if (index > 6 && !controller.isShowMore) {
                return const SizedBox();
              } else if (index == 6 && !controller.isShowMore) {
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
                return MyGiftCardX(
                  gift: data,
                ).fadeAnimationX(60 * (index>6?6:index + 1));
              }
            },
          ),
        ),
      ),
    );
  }
}
