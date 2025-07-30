import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import '../../../../../../../Config/config.dart';
import '../../../../../../../UI/Widget/widget.dart';

class HeaderSectionX extends StatelessWidget {
  const HeaderSectionX({this.isPadding=true,super.key});
  final bool isPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: isPadding?StyleX.hPaddingApp:0,
        left: isPadding?StyleX.hPaddingApp:0,
        top: isPadding?StyleX.vPaddingApp:0,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          TextX(
            "Donation campaigns",
            style: TextStyleX.headerSmall,
            color: Theme.of(context).primaryColor,
          ).fadeAnimation200,
          const SizedBox(height: 6),

          /// Description
          TextX(
            "All donation campaigns created by you",
            style: TextStyleX.supTitleLarge,
            color: Theme.of(context).colorScheme.secondary,
            size: 14,
            maxLines: 4,
          ).fadeAnimation200,
        ],
      ),
    );
  }
}
