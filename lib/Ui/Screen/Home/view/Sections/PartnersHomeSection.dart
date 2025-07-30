import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../Section/Partners/view/View.dart';

class PartnersHomeSectionX extends StatelessWidget {
  const PartnersHomeSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return PartnersSectionX(
      padding: const EdgeInsets.only(
        left: StyleX.hPaddingApp,
        right: StyleX.hPaddingApp,
        bottom: 20,
      ),
      header: const SectionTitleX(
        title: "Our Partners",
        icon: IconX.sparkles,
      ),
    );
  }
}
