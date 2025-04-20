import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Data/data.dart';
import '../../../../../Section/Partners/view/View.dart';
import '../../../../../Section/StatisticsAndFigures/view/View.dart';
import '../../../../../Section/Testimonials/view/View.dart';
import '../../../../../Widget/Basic/Utils/future_builder.dart';
import '../../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: 'About Us',
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(
            vertical: StyleX.vPaddingApp,
          ),
          child: Column(
            children: [
              ContainerX(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  children: [
                    /// Logo
                    const LogoX(height: 50.0).marginSymmetric(vertical: 40),

                    /// Content
                    FutureBuilderX(
                      future: controller.getData,
                      loading: SingleChildScrollView(
                        child: Column(
                          children: [
                            /// Text
                            for (int i = 0; i < 3; i++)
                              ShimmerAnimationX(
                                height: 34,
                                margin: EdgeInsets.only(bottom: i < 3 ? 10 : 0),
                              )
                          ],
                        ),
                      ),
                      child: (_) => HtmlWidget(
                        Get.isDarkMode
                            ? controller.about.contentHTML
                                .replaceAllMapped(
                                    RegExp(
                                        r'color:\s*(rgb\((\d+),\s*(\d+),\s*(\d+)\)|#([0-9a-fA-F]{6})|black|white)',
                                        caseSensitive: false), (match) {
                                if (match.group(1)?.startsWith('rgb(') ??
                                    false) {
                                  final r = int.parse(match.group(2)!);
                                  final g = int.parse(match.group(3)!);
                                  final b = int.parse(match.group(4)!);
                                  if (r == g && g == b) {
                                    return 'color: rgb(255, 255, 255)';
                                  }
                                  return 'color: rgb(0, 0, 0)';
                                }
                                if (match.group(1)?.startsWith('#') ?? false) {
                                  final hex = match.group(5)!;
                                  if (hex[0] == hex[1] &&
                                      hex[2] == hex[3] &&
                                      hex[4] == hex[5]) {
                                    return 'color: #ffffff';
                                  }
                                  return 'color: #000000';
                                }
                                const colorMap = {
                                  'black': 'white',
                                  'white': 'black'
                                };
                                return 'color: ${colorMap[match.group(1)?.toLowerCase()] ?? match.group(1)}';
                              })
                            : controller.about.contentHTML,
                        customWidgetBuilder: (element) {
                          if (element.localName == 'img') {
                            return ImageNetworkX(
                                imageUrl:
                                    element.attributes[NameX.src].toString(),
                                width: double.maxFinite);
                          }
                          return null;
                        },
                        textStyle: TextStyleX.titleMedium,
                      ).fadeAnimation200,
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: StyleX.hPaddingApp),
              const SizedBox(height: 26),
              StatisticsAndFiguresSectionX(
                padding: const EdgeInsets.only(bottom: 14),
                parentScrollController: controller.scrollController,
                header: TextX(
                  'Statistics and Figures',
                  color: Get.theme.primaryColor,
                  style: TextStyleX.titleLarge,
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 6),
              ).paddingSymmetric(horizontal: StyleX.hPaddingApp),
              TestimonialsSectionX(
                padding: const EdgeInsets.only(bottom: 26,
                right: StyleX.hPaddingApp,
                  left: StyleX.hPaddingApp,
                ),
                header: TextX(
                  'Testimonials',
                  color: Get.theme.primaryColor,
                  style: TextStyleX.titleLarge,
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 6),
              ),
              PartnersSectionX(
                padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp),
                header: TextX(
                  'Our Partners',
                  color: Get.theme.primaryColor,
                  style: TextStyleX.titleLarge,
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
