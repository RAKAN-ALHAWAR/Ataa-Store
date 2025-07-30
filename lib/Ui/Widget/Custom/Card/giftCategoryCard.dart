import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Data/Model/Gift/Subclass/giftCategory.dart';
import '../../widget.dart';

class GiftCategoryCardX extends StatelessWidget {
  const GiftCategoryCardX({
    super.key,
    required this.giftCategory,
    required this.onTap,
    required this.isSelected,
  });
  final GiftCategoryX giftCategory;
  final Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerX(
        margin: const EdgeInsetsDirectional.only(end: 8),
        width: 110,
        height: 140,
        padding: const EdgeInsets.all(10),
        borderColor: isSelected
            ? context.isDarkMode
                ? Theme.of(context).primaryColor
                : ColorX.primary.shade500
            : null,
        borderWidth: 1,
        color: isSelected
            ? context.isDarkMode
                ? ColorX.primary.shade900.withValues(alpha: 0.3)
                : Theme.of(context).colorScheme.onPrimary
            : null,
        isBorder: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(StyleX.radius),
              child: ImageNetworkX(
                height: 90,
                width: 100,
                imageUrl: giftCategory.imageUrl,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: AutoSizeText(
                giftCategory.name,
                style: TextStyleX.supTitleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : context.isDarkMode
                          ? null
                          : ColorX.grey.shade900,
                ),
                overflow: TextOverflow.ellipsis,
                minFontSize: 10,
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
