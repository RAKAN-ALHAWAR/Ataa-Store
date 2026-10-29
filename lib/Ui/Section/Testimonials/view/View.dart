import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';
import '../controller/Controller.dart';

class TestimonialsSectionX extends StatelessWidget {
  TestimonialsSectionX({super.key, this.header, this.padding});
  final Widget? header;
  final EdgeInsets? padding;
  final TestimonialsController controller = Get.put(TestimonialsController());
  @override
  Widget build(BuildContext context) {
    return ScrollRefreshLoadMoreX(
      padding: padding,
      fetchData: controller.getData,
      scrollDirection: Axis.horizontal,
      isHideHeaderIfError: true,
      isHideHeaderIfEmpty: true,
      isHideHeaderIfLoading: false,
      isHeaderPadding: false,
      isHideEmpty: true,
      header: header,
      initLoading: Row(
        children: [
          for (int i = 0; i < 3; i++)
            const ShimmerAnimationX(
              width: 280,
              height: 250,
              margin: EdgeInsetsDirectional.only(end: 16),
            ).fadeAnimationX(100+40*i),
        ],
      ),
      itemBuilder: (data, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(end: 16),
          child: TestimonialCardX(
            testimonial: data,
          ).fadeAnimationX(100+40*index),
        );
      },
    );
  }
}
