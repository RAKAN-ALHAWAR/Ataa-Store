import 'package:ataa/Data/data.dart';
import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../Widget/widget.dart';
import '../controller/Controller.dart';

class DynamicPageView extends GetView<DynamicPageController> {
  const DynamicPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: controller.page.title,
        actions: [CartIconButtonsX()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleX.hPaddingApp,
          vertical: StyleX.vPaddingApp,
        ),
        child: ContainerX(
          padding: const EdgeInsets.all(16),
          child: HtmlWidget(
            buildAsync: true,
             Get.isDarkMode
                            ? controller.page.contentHTML
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
                            : controller.page.contentHTML,
            customWidgetBuilder: (element) {
              if(element.localName == 'img'){
                return ImageNetworkX(imageUrl: element.attributes[NameX.src].toString(),width: double.maxFinite);
              }
              return null;
            },
            textStyle: TextStyleX.titleMedium,
          ).fadeAnimation200,
        ),
      ),
    );
  }
}
