import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../Core/Error/error.dart';

class VerificationUrlController extends GetxController {
  final String verificationUrl = Get.arguments[0];
  final String callbackUrl = Get.arguments[1];

  /// UI state of the 3DS verification page. Without this the WebView shows a
  /// blank white screen whenever the page fails to load, with no message and
  /// no way to retry, which reads to the user as an "empty page".
  final RxBool isLoading = true.obs;
  final Rx<ErrorX?> loadError = Rx<ErrorX?>(null);

  /// Set once the callback URL is reached so a late cancelled-navigation error
  /// (fired by the WebView while we pop the route) can never flash an error.
  bool _completed = false;

  late final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          loadError.value = null;
          isLoading.value = true;
        },
        onPageFinished: (String url) {
          isLoading.value = false;
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint(
            '[Verification] resource error code=${error.errorCode} '
            'type=${error.errorType} mainFrame=${error.isForMainFrame} '
            'url=${error.url} desc=${error.description}',
          );

          /// Only a failure to load the MAIN document blanks the page. Sub
          /// resource errors (trackers, fonts, an intermediate bank redirect)
          /// must be ignored, otherwise a working 3DS challenge would be
          /// replaced by a false error screen and the payment would break.
          if (!_completed && error.isForMainFrame == true) {
            isLoading.value = false;
            loadError.value = ErrorX(
              errorType: ErrorTypeStatusX.network,
              title: "Verification process".tr,
              message:
                  "The verification page could not be loaded. Please check your connection and try again."
                      .tr,
              originalError: error.description,
            );
          }
        },
        onHttpError: (HttpResponseError error) {
          debugPrint(
            '[Verification] http error status=${error.response?.statusCode} '
            'url=${error.request?.uri}',
          );
        },
        onNavigationRequest: checkVerification,
      ),
    )
    ..loadRequest(Uri.parse(Get.arguments[0]));

  NavigationDecision checkVerification(NavigationRequest request) {
    // Check if the domain is the same as the original verification domain
    if (request.url.contains(callbackUrl)) {
      _completed = true;
      Uri uri = Uri.parse(request.url);
      String result = uri.queryParameters['status'] ?? '';
      Get.back(result: result);
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  /// Re-open the verification page after a load failure.
  void reload() {
    loadError.value = null;
    isLoading.value = true;
    webViewController.loadRequest(Uri.parse(verificationUrl));
  }
}
