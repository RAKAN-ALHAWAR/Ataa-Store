import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';

class IntroductionSectionX extends StatelessWidget {
  const IntroductionSectionX({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextX(
          "Donation campaigns",
          style: TextStyleX.headerSmall,
          color: Theme.of(context).primaryColor,
        ).fadeAnimation200,
        const SizedBox(height: 6),
        TextX(
          "Create your own campaign to support one of our projects, and share it with others to contribute to the advocacy.",
          style: TextStyleX.supTitleLarge,
          color: Theme.of(context).colorScheme.secondary,
          maxLines: 4,
        ).fadeAnimation200,
      ],
    );
  }
}
