import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ataa/Data/Model/Gift/Order/giftOrder.dart';
import 'package:ataa/Data/Model/Gift/Subclass/giftCategory.dart';
import 'package:ataa/Data/data.dart';
import 'package:ataa/UI/Widget/widget.dart';
import 'package:downloadsfolder/downloadsfolder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PreviewGiftController extends GetxController {
  //============================================================================
  // Variables

  GiftOrderX giftOrder = Get.arguments;
  late GiftCategoryX giftCategory;
  late OrganizationX organization;
  GlobalKey globalKey = GlobalKey();

  //============================================================================
  // Functions

  Future<void> getData() async {
    giftCategory =
        await DatabaseX.getGiftCategoryDetails(id: giftOrder.giftCategory.id);
    if (giftCategory.donationCategories
            .firstWhereOrNull((x) => x.id == giftOrder.organizationId) !=
        null) {
      organization = giftCategory.donationCategories
          .firstWhere((x) => x.id == giftOrder.organizationId);
    } else if (giftOrder.organization != null) {
      organization = giftOrder.organization!;
    } else if (giftOrder.organizationId != null) {
      organization =
          await DatabaseX.getOrganizationDetails(id: giftOrder.organizationId!);
    } else {
      organization = OrganizationX(id: '', name: '');
    }
  }

  Future<void> onSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      double pixelRatio = 4.0;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      if (Platform.isAndroid) {
        var status = await Permission.storage.status;

        if (!status.isGranted) {
          await Permission.storage.request();
        }

        status = await Permission.storage.status;
        // التحقق إذا كانت الأذونات دائمة مرفوضة
        if (!status.isGranted) {
          if (await Permission.storage.isPermanentlyDenied) {
            // توجيه المستخدم إلى إعدادات التطبيق
            ToastX.error(
                message:
                    'Permission to access storage is permanently denied. Please enable it from settings.');
            await openAppSettings();
            return;
          }
        }
        Directory downloadDirectory = await getDownloadDirectory();
        // bool dirDownloadExists = true;
        // var directory = "/storage/emulated/0/Download/";
        //
        // dirDownloadExists = await Directory(directory).exists();
        // if(dirDownloadExists){
        //   directory = "/storage/emulated/0/Download/";
        // }else{
        //   directory = "/storage/emulated/0/Downloads/";
        // }

        String basePath =
            '${downloadDirectory.path}/${giftOrder.giftBasic.recipientName} - gift card';
        String path = '$basePath.png';

        int counter = 1;
        // التحقق إذا كان الملف موجودًا
        while (await File(path).exists()) {
          // تعديل الاسم في حالة وجود الملف
          path = '$basePath ($counter).png';
          counter++;
        }

        // حفظ الصورة
        File imgFile = File(path);
        await imgFile.writeAsBytes(pngBytes, flush: true);

        ToastX.success(
          message: 'The image has been successfully downloaded to your device.',
        );
      } else if (Platform.isIOS) {
        var status = await Permission.photos.status;

        if (!status.isGranted) {
          await Permission.photos.request();
        }

        // حفظ الصورة في مكتبة الصور
        final result = await ImageGallerySaverPlus.saveImage(
          pngBytes,
          quality: 100,
          name: '${giftOrder.giftBasic.recipientName}_gift_card',
        );

        if (result['isSuccess']) {
          ToastX.success(
            message:
                'The image has been successfully saved to the photo library.',
          );
        } else {
          throw 'Failed to save image.';
        }
      }
    } catch (e) {
      ToastX.error(message: e.toString());
    }
  }
}
