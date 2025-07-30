import 'package:ataa/Data/data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Config/config.dart';
import '../../widget.dart';

class GiftOrgCardX extends StatelessWidget {
  const GiftOrgCardX({
    super.key,
    required this.org,
    required this.onTap,
    required this.isSelected,
  });
  final OrganizationX org;
  final Function() onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ContainerX(
        margin: const EdgeInsetsDirectional.only(end: 8),
        width: 150,
        height: 130,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerX(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(StyleX.radius),
                child: ImageNetworkX(
                  width: 66,
                  height: 60,
                  imageUrl: org.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: AutoSizeText(
                org.name,
                style: TextStyleX.titleSmall.copyWith(
                  fontWeight: FontWeight.w500,
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
