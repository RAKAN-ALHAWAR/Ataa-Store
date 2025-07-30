import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../Ui/Screen/Donation/AllDonation/view/view.dart';
import '../../Ui/Screen/Home/view/View.dart';
import '../../Ui/Screen/MoreSections/view/View.dart';
import '../../Ui/Screen/Profile/ProfileDetails/view/View.dart';
import '../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Control data of nav bar elements
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

List<RootPageX> navBarItems = [
  RootPageX(
    view: const HomeView(),
    label: 'Home',
    icon: const Icon(Icons.home_rounded),
  ),
  RootPageX(
    view: const AllDonationView(),
    label: 'Donation',
    icon: Transform.flip(
      flipX: true,
      flipY: true,
      child: const Icon(Icons.payments_rounded),
    ),
  ),
  /// Note: An empty item with an empty icon was used instead of the quick donation item because it is displayed in a different way
  RootPageX(
    view: const SizedBox(),
    label: '',
    icon: const Icon(Iconsax.home2),
  ),
  RootPageX(
    view: const MoreSectionsView(),
    label: 'More',
    icon: Transform.rotate(
      alignment: Alignment.center,
      angle: 11,
      child: const Icon(Icons.web_stories),
    ),
  ),
  RootPageX(
    view: const ProfileDetailsView(),
    label: 'Profile',
    icon: const Icon(Icons.account_circle_rounded),
  )
];