import 'package:ataa/UI/Animation/animation.dart';
import 'package:ataa/Ui/Widget/Basic/Other/scrollRefreshLoadMore.dart';
import 'package:ataa/Ui/Widget/Custom/Card/giftCategoryCard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class GiftCategoriesSectionX extends GetView<CreateGiftController> {
  const GiftCategoriesSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX(
      fetchData: controller.getGiftCategories,
      firstFixedData: controller.giftCategories,
      initPage: 2,
      isShowFixedDataAsInitLoading: true,
      scrollDirection: Axis.horizontal,
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
      ),
      spaceBetweenHeaderAndContent: 14,
      header: Row(
        children: [
          const TextX(
            "Type of gift",
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.start,
          ).fadeAnimation200,
        ],
      ),
      itemBuilder: (data, index) => Obx(
            () => GiftCategoryCardX(
              giftCategory: data,
              onTap: () => controller.onChangeCategory(index),
              isSelected: controller.giftCategorySelected.value?.id == data.id,
            ).fadeAnimation200,
      )
    );
  }
}
