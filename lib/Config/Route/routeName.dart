part of '../config.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// This class is used to navigate between pages using the page name
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class RouteNameX {
  /// Root
  static const String root = '/';

  /// Loading
  static const String loading = '/loading';

  /// Onboarding
  static const String onboarding = '/onboarding';

  /// Pages
  static const String dynamicPage = '/dynamicPage';

  /// Receipt Preview
  static const String receiptPreview = '/receiptPreview';

  /// Verification Url
  static const String verificationUrl = '/verificationUrl';

  /// Auth
  static const String login = '/login';
  static const String continueToAccount = '/continueToAccount';
  static const String signUp = '/signUp';
  static const String otp = '/otp';
  static const String completeAccountData = '/completeAccountData';

  /// Payment
  static const String generalPayment = '/generalPayment';
  static const String deductionPayment = '/deductionPayment';
  static const String paymentSuccessful = '/paymentSuccessful';

  /// Profile
  static const String editProfile = '/editProfile';
  static const String statistics = '/statistics';
  static const String notifications = '/notifications';

  /// Activity
  static const String activity = '/activity';
  static const String myDonations = '/myDonations';
  static const String myCampaigns = '/myCampaigns';
  static const String myOrders = '/myOrders';
  static const String myDeductions = '/myDeductions';
  static const String myGifts = '/myGifts';
  static const String myShareLinks = '/myShareLinks';
  static const String mySponsorships = '/mySponsorships';
  static const String paymentCards = '/paymentCards';

  /// Gifting
  static const String gift = '/gift';
  static const String previewGift = '/previewGift';

  /// Cart
  static const String cart = '/cart';

  /// Campaigns
  static const String allCampaigns = '/allCampaigns';
  static const String createCampaign = '/createCampaign';
  static const String campaignDetails = '/campaignDetails';
  static const String myCampaignDetails = '/myCampaignDetails';

  /// Donations
  static const String donationDetails = '/donationDetails';

  /// Sponsorships
  static const String typesSponsorships = '/typesSponsorships';
  static const String allSponsorships = '/allSponsorships';

  /// Organization
  static const String allOrganizations = '/allOrganizations';
  static const String organizationDetails = '/organizationDetails';

  /// Deduction
  static const String allDeductions = '/allDeductions';
  static const String deductionDetails = '/deductionDetails';

  /// Zakat
  static const String zakat = '/zakat';
  static const String zakatDisbursements = '/zakatDisbursements';
  static const String zakatCalculator = '/ZakatCalculator';

  /// Shop
  static const String store = '/store';
  static const String productDetails = '/productDetails';

  /// Info
  static const String settings = '/settings';
  static const String contactUs = '/contactUs';
  static const String about = '/about';
  static const String ourBank = '/OurBank';
  static const String termsConditions = '/termsConditions';
  static const String privacyPolicy = '/privacyPolicy';
}
