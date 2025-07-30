import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class ImagesBarSection extends GetView<ProductDetailsController> {
  const ImagesBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
        ),
        child: Row(
          children: [
            for (int index = 0;
                index < controller.product.imageUrl.length;
                index++)
              GestureDetector(
                onTap: () => controller.onChangeImage(index),
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 10),
                  child: ContainerX(
                    padding: EdgeInsets.zero,
                    borderColor: controller.imageSelectedIndex.value==index?ColorX.primary.shade300:null,
                    borderWidth:2,
                    isBorder: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: ImageNetworkX(
                        height: 70,
                        width: 70,
                        imageUrl: controller.product.imageUrl[index],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
