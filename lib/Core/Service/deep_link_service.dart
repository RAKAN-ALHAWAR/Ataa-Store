import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:get/get.dart';

import '../../Config/config.dart';

/// خدمة التعامل مع روابط الديب لينك
/// تدعم الروابط التالية:
/// - تفاصيل المشاريع: https://store.edialoguec.org.sa/donationsDetails/{code}
/// - تفاصيل الاستقطاعات: https://store.edialoguec.org.sa/DeductionsDetails/{code}
/// - تفاصيل الحمالات: https://store.edialoguec.org.sa/donation-campaigns/{code}
/// - تفاصيل السله: https://store.edialoguec.org.sa/Cart
/// - بروفيل المتبرع: استقطاعاتي: https://store.edialoguec.org.sa/profile/MySubscriptions
/// - تفاصيل الحملة تبع المتبرع: https://store.edialoguec.org.sa/UserCampaigns/{code}
/// - تفاصيل التقرير: https://store.edialoguec.org.sa/public/report/{code}
/// - تفاصيل الكفالة: https://store.edialoguec.org.sa/public/sponsorships/{id}
class DeepLinkServiceX {
  static final DeepLinkServiceX _instance = DeepLinkServiceX._internal();
  static final AppLinks _appLinks = AppLinks();
  static StreamSubscription? _sub;

  /// متغير لحفظ الرابط العميق حتى يتم الانتهاء من التحميل
  static Uri? _pendingDeepLink;

  /// متغير للتحقق من جاهزية التطبيق لمعالجة الروابط
  static bool _isAppReady = false;

  /// متغير لمنع المعالجة المزدوجة في Android
  static bool _isProcessing = false;

  DeepLinkServiceX._internal();

  /// Singleton instance to ensure only one instance of DeepLinkService is used.
  factory DeepLinkServiceX() {
    return _instance;
  }

  /// تهيئة خدمة الديب لينك وبدء الاستماع للروابط
  static Future<void> init() async {
    try {
      // التعامل مع الرابط الأولي عند فتح التطبيق عبر ديب لينك (cold start)
      final initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _pendingDeepLink = initialLink;
      }

      // الاستماع للروابط أثناء تشغيل التطبيق (app_links يبعث Uri غير قابل للـ null)
      _sub = _appLinks.uriLinkStream.listen((Uri uri) {
        if (_isAppReady) {
          _handleUri(uri);
        } else {
          _pendingDeepLink = uri;
        }
      }, onError: (err) {});
    } catch (_) {}
  }

  /// إلغاء اشتراك الـ stream (اختياري، عند التخلص)
  static Future<void> dispose() async {
    await _sub?.cancel();
  }

  /// تحديد أن التطبيق جاهز لمعالجة الروابط العميقة
  static bool setAppReady() {
    _isAppReady = true;
    // معالجة الرابط المعلق إن وجد
    if (_pendingDeepLink != null) {
      _handleUri(_pendingDeepLink!, fromSetAppReady: true);
      _pendingDeepLink = null;
      return true;
    } else {
      return false;
    }
  }

  /// التحقق من وجود رابط عميق معلق
  static bool hasPendingDeepLink() {
    return _pendingDeepLink != null;
  }

  /// معالجة الروابط الواردة
  static void _handleUri(Uri uri, {bool fromSetAppReady = false}) {
    final pathSegments = uri.pathSegments;

    // التحقق من أن الرابط ينتمي للنطاق المطلوب
    if (pathSegments.isNotEmpty) {
      // إذا لم يكن التطبيق جاهزاً، نحفظ الرابط ولا نعالجه
      if (!_isAppReady) {
        _pendingDeepLink = uri;
        return;
      }

      // منع المعالجة المزدوجة
      if (_isProcessing) return;

      _isProcessing = true;

      // نضيف تأخير صغير لمنع التنقل المزدوج
      Future.delayed(const Duration(milliseconds: 100), () {
        if (fromSetAppReady) {
          // من اجل تفعيل كونترولر الروت ومسح الشاشات الظاهرة الاخرى
          Get.offAllNamed(RouteNameX.root);
        }

        _processDeepLink(pathSegments);

        // السماح بمعالجة روابط جديدة بعد فترة
        Future.delayed(const Duration(seconds: 1), () {
          _isProcessing = false;
        });
      });
    }
  }

  /// معالجة الرابط العميق حسب المسار
  static void _processDeepLink(List<String> pathSegments) {
    // التعامل مع تفاصيل المشاريع - donationsDetails/{code}
    if (pathSegments.length == 2 &&
        pathSegments[0].toLowerCase() == 'donationsdetails' &&
        pathSegments[1].isNotEmpty) {
      final code = pathSegments[1];
      Get.toNamed(RouteNameX.donationDetails, arguments: code);
      return;
    }

    // التعامل مع تفاصيل الاستقطاعات - DeductionsDetails/{code}
    if (pathSegments.length == 2 &&
        pathSegments[0].toLowerCase() == 'deductionsdetails' &&
        pathSegments[1].isNotEmpty) {
      final code = pathSegments[1];
      Get.toNamed(RouteNameX.deductionDetails, arguments: code);
      return;
    }

    // التعامل مع تفاصيل الحمالات - donation-campaigns/{code}
    if (pathSegments.length == 2 &&
        pathSegments[0].toLowerCase() == 'donation-campaigns' &&
        pathSegments[1].isNotEmpty) {
      final code = pathSegments[1];
      Get.toNamed(RouteNameX.campaignDetails, arguments: code);
      return;
    }

    // التعامل مع تفاصيل السله - Cart
    if (pathSegments[0].toLowerCase() == 'cart') {
      Get.toNamed(RouteNameX.cart);
      return;
    }

    // التعامل مع بروفيل المتبرع: استقطاعاتي - profile/MySubscriptions
    if (pathSegments.length == 2 &&
        pathSegments[0].toLowerCase() == 'profile' &&
        pathSegments[1].toLowerCase() == 'mysubscriptions') {
      Get.toNamed(RouteNameX.myDeductions);
      return;
    }

    // التعامل مع تفاصيل الحملة تبع المتبرع - UserCampaigns/{code}
    if (pathSegments.length == 2 &&
        pathSegments[0].toLowerCase() == 'usercampaigns' &&
        pathSegments[1].isNotEmpty) {
      final code = pathSegments[1];
      Get.toNamed(RouteNameX.myCampaignDetails, arguments: code);
      return;
    }

    /// TODO: Add report details route
    // التعامل مع تفاصيل التقرير - public/report/{code}
    // if (pathSegments.length == 3 &&
    //     pathSegments[0].toLowerCase() == 'public' &&
    //     pathSegments[1].toLowerCase() == 'report' &&
    //     pathSegments[2].isNotEmpty) {
    //   final code = pathSegments[2];
    //   // يمكن إضافة route جديد إذا لزم الأمر
    //   Get.toNamed(RouteNameX.root, arguments: {NameX.code: code});
    //   return;
    // }

    /// TODO: Add sponsorships details route
    // التعامل مع تفاصيل الكفالة - public/sponsorships/{id}
    // if (pathSegments.length == 3 &&
    //     pathSegments[0].toLowerCase() == 'public' &&
    //     pathSegments[1].toLowerCase() == 'sponsorships' &&
    //     pathSegments[2].isNotEmpty) {
    //   final id = pathSegments[2];
    //   Get.toNamed(RouteNameX.allSponsorships, arguments: {NameX.id: id});
    //   return;
    // }
  }
}
