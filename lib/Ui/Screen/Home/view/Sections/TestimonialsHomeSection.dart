import 'package:flutter/material.dart';
import '../../../../../Config/config.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../../Section/Testimonials/view/View.dart';

class TestimonialsHomeSectionX extends StatelessWidget {
  const TestimonialsHomeSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return TestimonialsSectionX(
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 20,
      ),
      header: const SectionTitleX(
        title: "Testimonials",
        icon: IconX.testimonials,
      ),
    );
  }
}
