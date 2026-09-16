import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../GeneralState/error.dart';
import '../../../../UI/Widget/widget.dart';
import '../controller/Controller.dart';

class VerificationUrlView extends GetView<VerificationUrlController> {
  const VerificationUrlView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarX(title: 'Verification process'),
      body: SafeArea(
        child: Obx(
          () {
            /// A load failure shows an explicit error with a retry, never a
            /// blank WebView.
            if (controller.loadError.value != null) {
              return ErrorView(
                error: controller.loadError.value,
                onTapButton: controller.reload,
              );
            }

            return Stack(
              children: [
                WebViewWidget(controller: controller.webViewController),

                /// Spinner while the 3DS page loads.
                if (controller.isLoading.value)
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
