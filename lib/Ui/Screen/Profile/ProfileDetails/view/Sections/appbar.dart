import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../controller/Controller.dart';

class AppBarSectionX extends GetView<ProfileDetailsController> {
  const AppBarSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// If the user is logged in
      if (controller.app.isLogin.value) {
        return Obx(
          () => ProfileAccountCardX(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).cardTheme.color,
                radius: 35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: ImageNetworkX(
                    /// So that the image is updated if it changes
                    key: Key(
                      controller.app.user.value?.imageUrl ?? "profile image",
                    ),
                    height: 120,
                    width: 120,
                    imageUrl: controller.app.user.value?.imageUrl ?? "",
                    fit: BoxFit.cover,

                    /// Empty State
                    empty: Center(
                      child: controller.app.user.value?.name.isNotEmpty ?? false
                          ? TextX(
                              controller.app.user.value!.name[0],
                              style: TextStyleX.headerLarge,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            )
                          : Icon(
                              Icons.account_circle_rounded,
                              color: Theme.of(context).primaryColor,
                              size: 50,
                            ),
                    ),
                  ),
                ),
              ).fadeAnimation300,
              const SizedBox(height: 10),

              /// User Name && Edit Button
              InkWell(
                onTap: controller.onEditProfile,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 20),
                    TextX(
                      controller.app.user.value?.name.isNotEmpty ?? false
                          ? controller.app.user.value!.name
                          : 'User',
                      color: Theme.of(context).primaryColor,
                      textAlign: TextAlign.center,
                      style: TextStyleX.titleLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        IconX.edit,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ).fadeAnimation300,

              /// Motivational text
              TextX(
                'Contribute with us by spreading goodness',
                style: TextStyleX.supTitleLarge,
                color: Theme.of(context).colorScheme.secondary,
              ).fadeAnimation300,
            ],
          ),
        );
      } else {
        /// If you are not logged in
        /// Auth Buttons
        return ProfileAccountCardX(
          isButtonPadding: true,
          children: [
            ButtonX.second(
              onTap: () {
                String route =
                    controller
                        .app
                        .generalSettings
                        .accountCreationMethodIsTraditionalForm
                    ? RouteNameX.login
                    : RouteNameX.continueToAccount;
                Get.offAllNamed(route);
              },
              text: "Login",
            ).fadeAnimation300,
            ButtonX(
              onTap: () {
                String route =
                    controller
                        .app
                        .generalSettings
                        .accountCreationMethodIsTraditionalForm
                    ? RouteNameX.signUp
                    : RouteNameX.continueToAccount;
                Get.offAllNamed(route);
              },
              text: "Sing Up",
            ).fadeAnimation300,
          ],
        );
      }
    });
  }
}
