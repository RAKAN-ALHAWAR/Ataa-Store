import 'package:ataa/Data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Helper/html.dart';
import '../../../../../UI/Animation/animation.dart';
import '../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class AllOrganizationsView extends GetView<AllOrganizationsController> {
  const AllOrganizationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Our Programs",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: ScrollRefreshLoadMoreX<OrganizationX>(
          fetchData: controller.getData,
          isEmptyCenter: false,
          padding: const EdgeInsets.symmetric(
            horizontal: StyleX.hPaddingApp,
            vertical: StyleX.vPaddingApp,
          ),
          initLoading: Column(
            children: [
              for (int i = 0; i < 8; i++)
                const ShimmerAnimationX(
                  height: 110,
                  margin: EdgeInsets.only(bottom: 10),
                )
            ],
          ),
          emptyMessage: "There are no association programs.",
          itemBuilder: (data, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => controller.onTap(data),
                child: ContainerX(
                  isBorder: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            /// Image
                            ImageNetworkX(
                              imageUrl: data.imageUrl,
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 20),

                            /// Name & Description
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextX(
                                    data.name,
                                    style: TextStyleX.titleLarge,
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 3),
                                  TextX(
                                    HtmlX.convertToPlainText(data.description),
                                    style: TextStyleX.supTitleMedium,
      color: Theme.of(context).colorScheme.secondary,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),

                      /// Icon
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: context.isDarkMode
                            ? Colors.white
                            : ColorX.grey.shade400,
                      )
                    ],
                  ),
                ),
              ),
            ).fadeAnimation300;
          },
        ),
      ),
    );
  }
}
