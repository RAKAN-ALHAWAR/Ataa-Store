import 'package:ataa/Core/Service/deep_link_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DeepLinkServiceX.setAppReady', () {
    test('reports no deep link when none is pending', () {
      DeepLinkServiceX.setPendingDeepLinkForTest(null);
      expect(DeepLinkServiceX.setAppReady(), isFalse);
    });

    test('a link without a path is dropped so the normal start-up routing runs', () {
      DeepLinkServiceX.setPendingDeepLinkForTest(Uri.parse('https://store.edialoguec.org.sa/'));
      expect(DeepLinkServiceX.setAppReady(), isFalse);
      expect(DeepLinkServiceX.hasPendingDeepLink(), isFalse);
    });
  });
}
