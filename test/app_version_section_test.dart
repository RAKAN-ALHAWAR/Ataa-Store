import 'dart:io';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Data/data.dart';
import 'package:ataa/Ui/Screen/Profile/ProfileDetails/controller/Controller.dart';
import 'package:ataa/Ui/Screen/Profile/ProfileDetails/view/Sections/appVersion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('shows the installed version and build number, read dynamically', (tester) async {
    PackageInfo.setMockInitialValues(
      appName: 'Ataa',
      packageName: 'com.ataa.rakanalhawar',
      version: '9.8.7',
      buildNumber: '321',
      buildSignature: '',
    );
    await tester.runAsync(() async {
      Hive.init(Directory.systemTemp.createTempSync('ataa_test_').path);
      HiveX.box = await Hive.openBox('app');
    });
    Get.put(AppControllerX());
    Get.put(ProfileDetailsController());

    await tester.pumpWidget(const GetMaterialApp(home: Scaffold(body: AppVersionSectionX())));
    await tester.pumpAndSettle();

    expect(find.text('9.8.7 (321)'), findsOneWidget);
  });
}
