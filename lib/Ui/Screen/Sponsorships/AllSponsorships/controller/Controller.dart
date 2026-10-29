import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Core/Controller/Cart/cartGeneralController.dart';
import '../../../../../Core/Controller/Filter/sponsorshipFilterController.dart';
import '../../../../../Core/core.dart';
import '../../../../../Data/data.dart';
import '../../../../../Ui/Widget/widget.dart';
import '../../../../ScreenSheet/Filter/SponsorshipFilter/sponsorshipFilterSheet.dart';

class AllSponsorshipsController extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();
  CartGeneralControllerX basketController = Get.find();
  SponsorshipFilterControllerX sponsorshipFilterController =
      Get.put(SponsorshipFilterControllerX());

  //============================================================================
  // Variables

  List<SponsorshipX> sponsorships = [];
  RxList<SponsorshipX> sponsorshipResults = <SponsorshipX>[].obs;

  TextEditingController search = TextEditingController();

  RxBool isLoading = false.obs;
  Map<String, ButtonStateEX> donationButtonsState = <String, ButtonStateEX>{};
  Map<String, ButtonStateEX> addToCartButtonsState = <String, ButtonStateEX>{};

  /// Bring the type of sponsorships selected from the previous page
  bool isNewMuslim = Get.arguments[NameX.isNewMuslim] ?? false;
  bool isPreachers = Get.arguments[NameX.isPreachers] ?? false;
  bool isEducationQuran = Get.arguments[NameX.isEducationQuran] ?? false;
  bool isEducationNewMuslim =
      Get.arguments[NameX.isEducationNewMuslim] ?? false;

  //============================================================================
  // Functions

  getData() async {
    try {
      /// To hide the choice of the previous religion other than sponsoring the new Muslim
      sponsorshipFilterController.isNewMuslim = isNewMuslim;

      /// TODO: Database >>> Fetch all sponsorships
      await Future.delayed(const Duration(seconds: 1)); // delete this

      /// Fetch data according to the type of sponsorships selected from the previous page
      if (isNewMuslim) {
        // sponsorships = TestDataX.sponsorships
        //     .where((x) => x.previousReligion != null)
        //     .toList();
      } else if (isEducationNewMuslim) {
        // sponsorships = TestDataX.sponsorships.where((x) => x.courseName != null).toList();
      } else if (isEducationQuran) {
        // sponsorships = TestDataX.sponsorships
        //     .where((x) =>
        //         x.muslimNum != null &&
        //         x.courseName == null &&
        //         x.previousReligion == null)
        //     .toList();
      } else if (isPreachers) {
        // sponsorships =
        //     TestDataX.sponsorships.where((x) => x.muslimNum == null).toList();
      }

      /// Data initialization
      sponsorshipResults.value = sponsorships;
      for (int i = 0; i < sponsorships.length; i++) {
        /// Create special button controllers for each card and link them to an identifier
        donationButtonsState[sponsorships[i].id] = ButtonStateEX.normal;
        addToCartButtonsState[sponsorships[i].id] = ButtonStateEX.normal;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  //----------------------------------------------------------------------------
  // Display texts on screen

  getTitle() {
    if (isNewMuslim) {
      return "Supporting a new Muslim's Islamization";
    } else if (isEducationNewMuslim) {
      return "Sponsoring the education of a new Muslim";
    } else if (isEducationQuran) {
      return "Supporting Quranic education";
    } else if (isPreachers) {
      return "Sponsoring preachers";
    }
  }

  getDescription() {
    if (isNewMuslim) {
      return "Sponsor the expenses of converting a new person to Islam";
    } else if (isEducationNewMuslim) {
      return "Sponsor the expenses for teaching a new Muslim the fundamentals of his religion";
    } else if (isEducationQuran) {
      return "Sponsor the expenses for teaching a new Muslim the Quran";
    } else if (isPreachers) {
      return "Sponsor the expenses of those who call to God";
    }
  }

  //----------------------------------------------------------------------------
  // Main processors

  onAddToCart(SponsorshipX sponsorship) async {
    if (isLoading.isFalse) {
      try {
        isLoading.value = true;
        addToCartButtonsState[sponsorship.id] = ButtonStateEX.loading;

        /// Connect to basket Controller to add to cart in database
        // await basketController.addSponsorship(sponsorship);

        /// The time delay here is aesthetically beneficial
        addToCartButtonsState[sponsorship.id] = ButtonStateEX.success;
        await Future.delayed(const Duration(seconds: 1));
        ToastX.success(message: "Added to cart successfully");
      } catch (error) {
        ToastX.error(message: error.toString());
        addToCartButtonsState[sponsorship.id] = ButtonStateEX.failed;
        update();
      }

      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          addToCartButtonsState[sponsorship.id] = ButtonStateEX.normal;
          update();
        },
      );
    }
  }

  onDonation(SponsorshipX sponsorship) async {
    if (isLoading.isFalse) {
      try {
        isLoading.value = true;
        donationButtonsState[sponsorship.id] = ButtonStateEX.loading;

        /// TODO: Connect to the database to complete payment
        /// TODO: Go to the payment screen
        /// TODO: Connect to the database to add the donation to the account records
        await Future.delayed(const Duration(seconds: 1)); // delete this

        /// The time delay here is aesthetically beneficial
        donationButtonsState[sponsorship.id] = ButtonStateEX.success;
        await Future.delayed(
          const Duration(seconds: StyleX.successButtonSecond),
        );

        ToastX.success(message: "Payment completed successfully");
      } catch (error) {
        ToastX.error(message: error.toString());
        donationButtonsState[sponsorship.id] = ButtonStateEX.failed;
        update();
      }

      isLoading.value = false;

      /// Reset the button state
      Timer(
        const Duration(seconds: StyleX.returnButtonToNormalStateSecond),
        () {
          donationButtonsState[sponsorship.id] = ButtonStateEX.normal;
          update();
        },
      );
    }
  }

  //----------------------------------------------------------------------------
  // Search & Filter

  onFilter() async {
    bool? result = await sponsorshipFilterSheetX(
      controller: sponsorshipFilterController,
    );
    if (result == true) {
      /// TODO: Database >>> Add a sponsorship filter
      /// TODO: Algorithm >>> Add a sponsorship filter
      onSearching(search.text);
    }
  }

  onSearching(String search) async {
    /// TODO: Expected Condition >>> Change the search code if you want to retrieve search results from the database
    try {
      /// clean search text from withe space and convert all char to lower case for contains with sponsorship data
      search = search.toLowerCase().trimLeft().trimRight();

      /// Bring all sponsorships that partially or completely match the all data
      sponsorshipResults.value = sponsorships
          .where((sponsorship) =>
              sponsorship.language.toLowerCase().contains(search) ||
              sponsorship.country.toLowerCase().contains(search) ||
              sponsorship.gender.toLowerCase().contains(search) ||
              sponsorship.donationAmount.toString().contains(search) ||
              (sponsorship.courseName != null
                  ? sponsorship.courseName!.toLowerCase().contains(search)
                  : false) ||
              (sponsorship.previousReligion != null
                  ? sponsorship.previousReligion!.toLowerCase().contains(search)
                  : false) ||
              (sponsorship.muslimNum != null
                  ? sponsorship.muslimNum!.toString().contains(search)
                  : false))
          .toList();
    } catch (e) {
      return Future.error(e);
    }
  }
  //===================================================================
}
