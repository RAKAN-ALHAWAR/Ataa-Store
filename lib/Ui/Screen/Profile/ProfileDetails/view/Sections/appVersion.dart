import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../controller/Controller.dart';

/// Small gray line at the end of the account screen: app version and build number.
class AppVersionSectionX extends GetView<ProfileDetailsController> {
  const AppVersionSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.appVersion.value.isEmpty) return const SizedBox.shrink();
      final style = TextStyleX.supTitleMedium.copyWith(color: ColorX.grey.shade400);
      return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Version'.tr, style: style),
              const SizedBox(width: 4),
              // The version is Latin text inside an Arabic line: keep it in its own LTR run.
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(controller.appVersion.value, style: style),
              ),
            ],
          ),
        ),
      );
    });
  }
}
