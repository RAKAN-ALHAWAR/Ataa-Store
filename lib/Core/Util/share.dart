part of '../core.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this Util }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage sharing with other applications
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

enum ShareOn { facebook, twitter, whatsapp, telegram, shareSystem }

class ShareX {
  static Future<String?> share({required ShareOn share, required String url}) async {
    try {
      String? response;
      final fullMessage = url;

      switch (share) {
        case ShareOn.facebook:
          response = await _launchUrl("https://www.facebook.com/sharer/sharer.php?u=$url");
          break;

        case ShareOn.twitter:
          response = await _launchUrl("https://twitter.com/intent/tweet?text=${Uri.encodeComponent(fullMessage)}");
          break;

        case ShareOn.whatsapp:
          response = await _launchUrl("https://wa.me/?text=${Uri.encodeComponent(fullMessage)}");
          break;

        case ShareOn.telegram:
          response = await _launchUrl("https://t.me/share/url?url=${Uri.encodeComponent(url)}");
          break;

        case ShareOn.shareSystem:
          await Share.share(fullMessage);
          response = "Shared successfully";
          break;
      }

      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<String> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return "Opened successfully";
    } else {
      return Future.error("Could not launch $url");
    }
  }
}