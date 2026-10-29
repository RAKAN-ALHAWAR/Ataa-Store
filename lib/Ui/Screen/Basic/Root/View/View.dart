import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// for don't move navbar when open keyboard
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Scaffold(
          extendBody: true,
          /// App Bar
          appBar: AppBarRootX(
            key: Key(controller.appBarTitle()),
            title: controller.appBarTitle(),
            pages: controller.pages,
            indexSelected: controller.indexPageSelected.value,
            leadingWidth: controller.isHomePage() ? 260 :  controller.isMorePage() || controller.isAllDonationPage() ? 100: 0,

            /// To implement the home page design
            leading: controller.isHomePage()
                ? const HomeAppBarLeadingX().fadeAnimation100
                :controller.isAllDonationPage()?BackButtonX(onTap: controller.goToHome).fadeAnimation100
                : (controller.isMorePage() &&
                        controller.isMoreDynamicPage.isTrue)
                    ? BackButtonX(onTap: controller.changeMoreDynamicPage).fadeAnimation100
                    : null,
            actions: [CartIconButtonsX()],
          ),

          /// Pages Content
          body: controller.pages[controller.indexPageSelected.value].view,

          /// Nav Bar
          bottomNavigationBar: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: [
              const SizedBox(
                height: 150,
              ),
              Positioned(
                bottom: StyleX.navBarHeight / 4, // Adjust this value based on the FAB size
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Visibility(
                    /// for don't move when open keyboard
                    visible: MediaQuery.of(context).viewInsets.bottom == 0.0 &&
                        controller.app.generalSettings.isActiveQuickDonation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ContainerX(
                          width: 96, // Diameter of the CircleAvatar (radius * 2)
                          height: 96,
                          isShadow: true,
                          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                          borderRadius: BorderRadius.circular(200), child: const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ContainerX(
                radius: 0,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                isShadow: true,
                color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,

                /// To add some safety space on the edges so that the titles do not come off the screen
                child: SafeArea(
                  top: false,
                  maintainBottomViewPadding: true,
                  child: SizedBox(
                    height: StyleX.navBarHeight,
                    child: BottomNavigationBar(
                      elevation: 0,
                      type: BottomNavigationBarType.fixed,
                      showSelectedLabels: true,
                      showUnselectedLabels: true,
                      currentIndex: controller.indexPageSelected.value,
                      onTap: controller.onItemSelected,
                      iconSize: StyleX.navBarIconSize,
                      items: controller.pages.map(
                            (page) {
                          return BottomNavigationBarItem(
                            icon: page.icon,
                            label: page.label.tr,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),

              /// Adding the shadow behind the floating action button
              Positioned(
                bottom: StyleX.navBarHeight / 4, // Adjust this value based on the FAB size
                left: 0,
                right: 0,
                child: SafeArea(
                  child: Visibility(
                    /// for don't move when open keyboard
                    visible: MediaQuery.of(context).viewInsets.bottom == 0.0 &&
                        controller.app.generalSettings.isActiveQuickDonation,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [QuickDonationButton(onTap: controller.openQuickDonation)]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
