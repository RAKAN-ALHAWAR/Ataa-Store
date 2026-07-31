import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../UI/Widget/widget.dart';
import '../controller/Controller.dart';

class VerificationUrlView extends GetView<VerificationUrlController> {
  const VerificationUrlView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Verification process'),
      body: SafeArea(
        child: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}
