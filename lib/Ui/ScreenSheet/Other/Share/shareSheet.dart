import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/Other/shareController.dart';
import '../../../../Core/core.dart';
import '../../../../Data/Enum/linkable_type_status.dart';
import '../../../GeneralState/error.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Display options for sharing the link on social media platforms,
/// with the ability to copy the link and create a link for the user
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

shareSheet({required String id,required int code,required LinkableTypeStatusX type,}) async {
  //============================================================================
  // Injection of required controls

  final ShareControllerX controller = Get.put(ShareControllerX());
  controller.id=id;
  controller.code=code;
  controller.type=type;

  //============================================================================
  // Content

  return bottomSheetX(
    title: "Share the link",
    child: FutureBuilder(
      future: controller.shareLink(),
      builder: (context, snapshot) {
        /// Loading State
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 130,
            child: Center(
              child: const CircularProgressIndicator().fadeAnimation200,
            ),
          );
        }

        /// Error State
        if (snapshot.hasError) {
          return ErrorView(
            error: snapshot.error.toString(),
          );
        }

        /// Main Content
        return Obx(
          () {
            return Column(
              children: [
                /// Mandatory login for the option to create a link for the user
                if (!controller.app.isLogin.value)
                  Column(
                    children: [
                      const TextX(
                        "Log in to create your own sharing link",
                        fontWeight: FontWeight.w600,
                      ).fadeAnimation200,
                      const SizedBox(height: 16),
                      ButtonX(
                        onTap: controller.app.onLoginSheet,
                        text: "Login",
                      ).fadeAnimation200,
                    ],
                  ),

                /// The word "OR" is an element that separates the forced login
                /// from the content of the post
                if (!controller.app.isLogin.value)
                  Row(
                    children: [
                      const Flexible(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: TextX(
                          "OR",
                          color: ColorX.grey.shade400,
                        ),
                      ),
                      const Flexible(child: Divider()),
                    ],
                  ).marginOnly(top: 10, bottom: 14).fadeAnimation200,

                /// Title
                TextX(
                  controller.app.isLogin.value
                      ? "Share your link"
                      : "Share a public link",
                  fontWeight: FontWeight.w600,
                  style: TextStyleX.titleMedium.copyWith(letterSpacing:0.05),
                ).fadeAnimation200,
                const SizedBox(height: 8),

                /// Copy button & Share Url
                Row(
                  children: [
                    /// Copy button
                    Flexible(
                      flex: 3,
                      child: ButtonX.gray(
                        onTap: () async => ClipboardX.copy(controller.shareUrl),
                        text: "Copy",
                        iconData: IconX.copy,
                        colorText: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    const SizedBox(width: 10),

                    /// Share Url
                    Flexible(
                      flex: 7,
                      child: ContainerX(
                        width: double.maxFinite,
                        isBorder: true,
                        color: Get.isDarkMode
                            ? ColorX.grey.shade900
                            : ColorX.grey.shade50,
                        child: TextX(
                          controller.shareUrl,
                          maxLines: 1,
                          textDirection:TextDirection.ltr,
                          style: TextStyleX.titleSmall,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ).fadeAnimation300,
                const SizedBox(height: 12),

                /// Social media sharing buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    /// Twitter
                    InkResponse(
                      onTap: () => ShareX.share(
                        share: ShareOn.twitter,
                        msg: controller.shareMsg,
                        url: controller.shareUrl,
                      ),
                      child: Icon(
                        IconX.x,
                        size: 27,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    /// Whatsapp
                    InkResponse(
                      onTap: () => ShareX.share(
                        share: ShareOn.whatsapp,
                        msg: controller.shareMsg,
                        url: controller.shareUrl,
                      ),
                      child: Icon(
                        IconX.whatsapp,
                        size: 27,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    /// Facebook
                    InkResponse(
                      onTap: () => ShareX.share(
                        share: ShareOn.facebook,
                        msg: controller.shareMsg,
                        url: controller.shareUrl,
                      ),
                      child: Icon(
                        IconX.facebook,
                        size: 27,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    /// Telegram
                    InkResponse(
                      onTap: () => ShareX.share(
                        share: ShareOn.telegram,
                        msg: controller.shareMsg,
                        url: controller.shareUrl,
                      ),
                      child: Icon(
                        IconX.telegram,
                        size: 27,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 16),

                    /// Share System
                    InkResponse(
                      onTap: () => ShareX.share(
                        share: ShareOn.shareSystem,
                        msg: controller.shareMsg,
                        url: controller.shareUrl,
                      ),
                      child: Icon(
                        Icons.share_rounded,
                        size: 27,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ).fadeAnimation400
              ],
            );
          },
        );
      },
    ),
  );
}
