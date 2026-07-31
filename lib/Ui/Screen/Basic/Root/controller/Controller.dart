import 'package:ataa/Ui/Screen/Donation/AllDonation/controller/Controller.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../../Data/data.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/Constant/navbarItems.dart';
import '../../../../../UI/Widget/widget.dart';
import '../../../QuickDonation/controller/Controller.dart';
import '../../../QuickDonation/view/View.dart';

class RootController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  QuickDonationController quickDonationController = Get.put(
    QuickDonationController(),
  );
  AllDonationController allDonationController = Get.find();

  //============================================================================
  // Variables

  RxInt indexPageSelected = 0.obs;
  late List<RootPageX> pages = app.generalSettings.isActiveQuickDonation
      ? navBarItems
      : [navBarItems[0], navBarItems[1], navBarItems[3], navBarItems[4]];
  RxBool isMoreDynamicPage = false.obs;

  //============================================================================
  // Functions

  isHomePage() => indexPageSelected.value == 0;
  isAllDonationPage() => indexPageSelected.value == 1;
  isMorePage() => indexPageSelected.value == 3;
  goToHome() => onItemSelected(0);
  changeMoreDynamicPage() => isMoreDynamicPage.value = !isMoreDynamicPage.value;
  appBarTitle() {
    if (indexPageSelected.value == 1) {
      return "Donation opportunities";
    } else if (isMoreDynamicPage.isTrue && indexPageSelected.value == 3) {
      return 'More Pages';
    } else if (indexPageSelected.value != 0) {
      return pages[indexPageSelected.value].label;
    } else {
      /// So that a title does not appear when the home page is open
      return "";
    }
  }

  onItemSelected(int index) {
    /// To disable the hidden button below the quick donate button
    if (app.generalSettings.isActiveQuickDonation && index == 2) {
      openQuickDonation();
    } else {
      if (indexPageSelected.value == 1) {
        allDonationController.clearData();
      }
      indexPageSelected.value = index;
    }
  }

  returnPage() => pages[indexPageSelected.value].view;

  openDonations() => onItemSelected(1);
  openNotification() => Get.toNamed(RouteNameX.notifications);
  openSettings() => Get.toNamed(RouteNameX.settings);

  openQuickDonation({bool isFromAction = false}) async {
    /// Fix init screen on Quick Action
    if (isFromAction) {
      await Future.delayed(const Duration(milliseconds: 50));
    }

    if (app.isLogin.isFalse) {
      String route = app.generalSettings.accountCreationMethodIsTraditionalForm
          ? RouteNameX.login
          : RouteNameX.continueToAccount;
      return Get.toNamed(route, arguments: {NameX.isFromQuickDonation: true});
    }

    /// Check if it is already open
    if (Get.isBottomSheetOpen != true) {
      bottomSheetX(
        title: "Quick Donation",
        child: QuickDonationView(controller: quickDonationController),
        isPaddingBottom: false,
      );
    }
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();
    init();
  }

  init() async {
    /// Initialize quick actions
    await QuickActionX.init();
  }
}
