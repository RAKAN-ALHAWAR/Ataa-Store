import 'dart:math';

import 'package:ataa/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Data/Model/Gift/Subclass/giftCardFormByGender.dart';
import '../../widget.dart';

class GiftCardForGiftX extends StatelessWidget {
  const GiftCardForGiftX({
    super.key,
    this.radius = StyleX.radius,
    this.borderWidth = 3,
    this.isPreview = false,
    required this.nameTo,
    required this.nameFrom,
    required this.amount,
    required this.color,
    required this.isShowAmount,
    required this.orgName,
    required this.giftCardFormByGender,
  });
  final double radius;
  final double borderWidth;
  final bool isPreview;
  final String? nameTo;
  final String? nameFrom;
  final String? amount;
  final Color color;
  final bool isShowAmount;
  final String? orgName;
  final GiftCardFormByGenderX? giftCardFormByGender;

  @override
  Widget build(BuildContext context) {
    // النسبة بين الطول والعرض الأصلية
    double aspectRatio = 473.8 / 310;
    return LayoutBuilder(
      builder: (context, constraints) {
        // عرض الشاشة المتاح
        double maxWidth = constraints.maxWidth;

        // عرض البطاقة، بحيث لا يتجاوز 500
        double cardWidth = maxWidth;
        if (cardWidth > 500) {
          cardWidth = 500;
        }

        // الطول بناءً على النسبة بين العرض والطول، وبشرط أن لا يزيد عن 700
        double cardHeight = cardWidth * aspectRatio;
        if (cardHeight > 765) {
          cardHeight = 765;
          cardWidth = cardHeight / aspectRatio;
        }

        // نسبة التحجيم بناءً على الحجم الأصلي (310 عرضًا)
        double scaleFactor = cardWidth / 310;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500, // الحد الأقصى لعرض البطاقة
              maxHeight: 765, // الحد الأقصى لطول البطاقة
            ),
            child: Container(
              width: cardWidth,
              height: cardHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  color: Theme.of(context).dividerColor,
                  width: borderWidth,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius - 4),
                      child: Column(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 22.4 * scaleFactor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 22.4 * scaleFactor),
                                  Center(
                                    child: Image.asset(
                                      ImageX.giftCardLogo,
                                      height: 35 * scaleFactor,
                                    ),
                                  ),
                                  SizedBox(height: 30 * scaleFactor),

                                  /// Name From
                                  ContainerX(
                                    height: 26 * scaleFactor,
                                    width: double.infinity,
                                    color: color,
                                    radius: 100,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 17 * scaleFactor,
                                    ),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: TextX(
                                        '${'To'.tr} / $nameTo',
                                        style: TextStyleX.titleSmall.copyWith(
                                          fontSize: 10 * scaleFactor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16 * scaleFactor),

                                  /// Image in gift card form by gender
                                  Center(
                                    child: ImageNetworkX(
                                      imageUrl:
                                          giftCardFormByGender?.imageUrl ?? '',
                                      height: 60 * scaleFactor,
                                      width: 60 * scaleFactor,
                                    ),
                                  ),
                                  SizedBox(height: 14 * scaleFactor),

                                  /// Title in gift card form by gender
                                  Center(
                                    child: TextX(
                                      giftCardFormByGender?.title ?? '',
                                      style: TextStyleX.titleSmall.copyWith(
                                        fontSize: 21 * scaleFactor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      color: color,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(height: 14 * scaleFactor),

                                  /// Description in gift card form by gender
                                  TextX(
                                    giftCardFormByGender?.description ?? '',
                                    style: TextStyleX.titleSmall.copyWith(
                                      fontSize: 10.6 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    color: ColorX.grey.shade700,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),

                                  /// Amount
                                  if (isShowAmount)
                                    TextX(
                                      '${'Donation amount'.tr} : $amount',
                                      style: TextStyleX.titleSmall.copyWith(
                                        fontSize: 10.6 * scaleFactor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      color: ColorX.grey.shade700,
                                      overflow: TextOverflow.ellipsis,
                                    ).paddingOnly(
                                        top: (isShowAmount ? 10 : 14) *
                                            scaleFactor),

                                  SizedBox(height: 14 * scaleFactor),

                                  /// Org Name
                                  ContainerX(
                                    height: 26 * scaleFactor,
                                    width: double.infinity,
                                    color: color.withValues(alpha: 0.1),
                                    radius: 100,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 17 * scaleFactor,
                                    ),
                                    child: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: TextX(
                                        orgName ?? '',
                                        style: TextStyleX.titleSmall.copyWith(
                                          fontSize: 10 * scaleFactor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        color: color,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 14 * scaleFactor),

                                  /// Name From
                                  TextX(
                                    '${'From'.tr} : $nameFrom',
                                    style: TextStyleX.titleSmall.copyWith(
                                      fontSize: 10.6 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    color: ColorX.grey.shade700,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 4 * scaleFactor),
                          const Spacer(flex: 1),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 22.4 * scaleFactor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ContainerX(
                                  width: 19.5 * scaleFactor,
                                  height: 3.5 * scaleFactor,
                                  color: color,
                                  radius: 30,
                                  child: const SizedBox(),
                                ),
                                SizedBox(width: 17 * scaleFactor),

                                /// Conclusion in gift card form by gender
                                Flexible(
                                  child: TextX(
                                    giftCardFormByGender?.conclusion ?? '',
                                    style: TextStyleX.titleSmall.copyWith(
                                      fontSize: 10.6 * scaleFactor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    color: ColorX.grey.shade700,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(width: 17 * scaleFactor),
                                ContainerX(
                                  width: 19.5 * scaleFactor,
                                  height: 3.5 * scaleFactor,
                                  color: color,
                                  radius: 30,
                                  child: const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4 * scaleFactor),
                          const Spacer(flex: 1),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              ImageX.giftCardBackground1,
                              fit: BoxFit.contain,
                              width: 112 * scaleFactor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isPreview)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.3,
                        child: ClipRect(
                          child: OverflowBox(
                            alignment: Alignment.center,
                            minWidth: 0.0,
                            minHeight: 0.0,
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                            child: Transform.rotate(
                              angle: (35.4 * pi / 180) *
                                  -1, // تدوير العنصر بزاوية 35.4 درجة
                              child: Row(
                                children: [
                                  ContainerX(
                                    width: 124 * scaleFactor,
                                    height: 3.5 * scaleFactor,
                                    color: ColorX.grey.shade300,
                                    radius: 30,
                                    child: const SizedBox(),
                                  ),
                                  SizedBox(width: 17 * scaleFactor),
                                  TextX(
                                    'PREVIEW',
                                    style: TextStyleX.titleSmall.copyWith(
                                      fontSize: 53 * scaleFactor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    color: ColorX.grey.shade300,
                                  ),
                                  SizedBox(width: 17 * scaleFactor),
                                  ContainerX(
                                    width: 124 * scaleFactor,
                                    height: 3.5 * scaleFactor,
                                    color: ColorX.grey.shade300,
                                    radius: 30,
                                    child: const SizedBox(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
