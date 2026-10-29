import 'package:ataa/Ui/Animation/animation.dart';
import 'package:ataa/Ui/Widget/Basic/Other/scrollRefreshLoadMore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';

class MyDonationsView extends GetView<MyDonationsController> {
  const MyDonationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Register My Donations",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: GetBuilder<MyDonationsController>(
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
            emptyMessage: 'You have not made any donations yet.',
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
                return MyDonationCardX(
                  myDonation: data,
                ).fadeAnimationX(60 * (index>6?6:index + 1));
              }
            },
          ),
        ),
      ),
    );
  }
}
