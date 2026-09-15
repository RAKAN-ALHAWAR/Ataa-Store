import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../GeneralState/empty.dart';
import '../../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../../Widget/widget.dart';
import 'Sections/loading.dart';
import '../controller/Controller.dart';

class MyShariLinksView extends GetView<MyShareLinksController> {
  const MyShariLinksView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Sharing links",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: GetBuilder<MyShareLinksController>(
          builder: (controller) => AbsorbPointer(
            absorbing: controller.isLoading,
            child: ScrollRefreshLoadMoreX(
              key: controller.scrollRefreshLoadMoreKey,
              fetchData: controller.getData,
              padding: const EdgeInsets.symmetric(
                vertical: StyleX.vPaddingApp,
                horizontal: StyleX.hPaddingApp,
              ),
              initLoading: const LoadingSectionX(),
              pageSize: 20,
              isShowLoadMoreLoading: controller.isShowMore,
              isShowNoMoreData: controller.isShowMore,
              empty: EmptyView(
                isMargin: false,
                message: 'You do not have sharing links yet.',
                onTap: controller.onAddShareLink,
                buttonText: 'Create a share link',
              ),
              header: ButtonX(text: 'Create a new link',onTap: controller.onAddShareLink,marginVertical: 0,).fadeAnimation100,
              isHideHeaderIfEmpty: true,
              // Keep false: when true the widget renders an empty SizedBox on
              // error, leaving the whole page blank instead of a message.
              isHideHeaderIfError: false,
              spaceBetweenHeaderAndContent: 16,
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
                  return ShareLinkCardX(
                    shareLink: data,
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
