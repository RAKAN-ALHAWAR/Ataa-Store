import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Data/data.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../Widget/Basic/Utils/future_builder.dart';
import '../controller/Controller.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  const TermsConditionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Terms and Conditions'),
      body: SafeArea(
        child: FutureBuilderX(
          future: controller.getData,
          loading: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ContainerX(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  for (int i = 0; i < 20; i++)
                    const ShimmerAnimationX(
                      height: 34,
                      margin: EdgeInsets.only(bottom: 10),
                    )
                ],
              ),
            ),
          ),
          child: (_)=> SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ContainerX(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: HtmlWidget(
                 Get.isDarkMode
                            ? controller.termsConditions.contentHTML
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
                            : controller.termsConditions.contentHTML,
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
        ),
      ),
    );
  }
}
