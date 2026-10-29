import 'package:ataa/Ui/Widget/widget.dart';
import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/Controller.dart';

class ReceiptPreviewView extends GetView<ReceiptPreviewController> {
  const ReceiptPreviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: 'Receipt preview',
        actions: [
          CartIconButtonsX(),
        ],
      ),
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImageNetworkX(
              imageUrl: controller.receiptPreviewImageUrl,
              backgroundLoading: Colors.transparent,
            ).fadeAnimation100,
          ),
        ),
      ),
    );
  }
}
