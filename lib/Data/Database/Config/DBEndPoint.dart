part of '../../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Contains links to database connection points
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class DBEndPointX {
  //============================================================================
  // Main API links

  static late final String mainAPI;

  //============================================================================
  // Auth

  static final String postSignUp = '${mainAPI}register';
  static final String postLoginByPhone = '${mainAPI}login/mobile';
  static final String postLoginByEmail = '${mainAPI}login/email';
  static final String putCompleteDataSingUp = '${mainAPI}register/complete';
  static final String postLogout = '${mainAPI}logout';
  static final String deleteAccount = '${mainAPI}profile';

  //============================================================================
  // OTP

  static final String postVerifyOtpPhone = '${mainAPI}verify-otp/mobile';
  static final String postVerifyOtpEmail = '${mainAPI}verify-otp/email';
  static final String postResendOtp = '${mainAPI}re-send';
  static final String postResendOTPUpdateProfile = '${mainAPI}profile/re-send';
  static final String postOtpVerifyUpdateProfile = '${mainAPI}profile/verify';

  //============================================================================
  // Profile

  static final String getProfile = '${mainAPI}profile';
  static final String putUpdateProfile = '${mainAPI}profile';
  static final String postUploadProfileImage = '${mainAPI}profile/image';
  static final String deleteProfileImage = '${mainAPI}profile/image';

  //============================================================================
  // General

  static final String getGeneralSettings = '${mainAPI}portal-settings/general';
  static final String getHomeElementSettings =
      '${mainAPI}portal-settings/home-page-element';
  static final String getGeneralStatistics =
      '${mainAPI}portal-settings/statistics';
  static final String getGeneralPaymentMethodsSettings =
      '${mainAPI}portal-settings/payment-methods';
  static final String homePageElementSettings =
      '${mainAPI}portal-settings/home-page-element';

  //============================================================================
  // Pages

  static final String getDynamicPages = '${mainAPI}portal-settings/site-pages';

  //============================================================================
  // About

  static final String getAboutPage = '${mainAPI}portal-settings/site-pages';
  static final String getPrivacyPolicyPage =
      '${mainAPI}portal-settings/site-pages';
  static final String getTermsAndConditionsPage =
      '${mainAPI}portal-settings/site-pages';

  //============================================================================
  // Content Us

  static final String getContentUs = '${mainAPI}organization/contact';
  static final String getContentUsSocialMedia =
      '${mainAPI}organization/social-media';
  static final String getContactUsPage = '${mainAPI}portal-settings/site-pages';

  //============================================================================
  // Bank Account

  static final String getAllActiveBanks = '${mainAPI}organization/banks';
  static final String getAllBanks = '${mainAPI}organization/bank-accounts';
  static final String getBankAccountDetails =
      '${mainAPI}organization/bank-accounts/{id}';

  //============================================================================
  // Gift

  static final String getAllGiftCategories = '${mainAPI}gift/categories';
  static final String getGiftCategoryDetails = '${mainAPI}gift/categories/{id}';
  static final String getGiftMessageTemplate =
      '${mainAPI}portal-settings/notification-templates/gift_card_donation_receiver';
  // ---  gift order ---
  static final String postCreateGiftOrder = '${mainAPI}gift/orders';
  static final String getAllMyGiftOrders = '${mainAPI}gift/orders';
  static final String getMyGiftOrderDetails = '${mainAPI}gift/orders/{id}';

  //============================================================================
  // Statistics

  /// TODO: Database >>> add statistics end points
  static final String getDonationStatistics = '${mainAPI}payments/statics';
  static final String getCampaignStatistics = '${mainAPI}campaign/statistics';
  static final String getOrderStatistics =
      '${mainAPI}1 --------Add Here----------';
  static final String getGiftStatistics = '${mainAPI}gift/statics';
  static final String getDeductionStatistics =
      '${mainAPI}donations/recurring-donations/donation-subscriptions/statistic';
  static final String getSponsorshipStatistics =
      '${mainAPI}3 --------Add Here----------';
  static final String getShareLinkStatistics =
      '${mainAPI}affiliations/statistics';

  //============================================================================
  // Ads

  static final String getAds = '${mainAPI}portal-settings/banner';

  //============================================================================
  // Testimonials

  static final String getTestimonials = '${mainAPI}portal-settings/testimonial';

  //============================================================================
  // Partners

  static final String getPartners = '${mainAPI}portal-settings/partner';

  //============================================================================
  // Organization

  static final String getAllOrganizations = '${mainAPI}donations/categories';
  static final String getOrganizationDetails = '${mainAPI}gift/categories/{id}';

  //============================================================================
  // Deduction

  static final String getAllDeductions =
      '${mainAPI}donations/recurring-donations';
  static final String getDeductionsBySearch =
      '${mainAPI}donations/recurring-donations/search';
  static final String getDeductionDetails =
      '${mainAPI}donations/recurring-donations/{code}';

  //============================================================================
  // Subscription

  static final String getAllMyDeductionSubscription =
      '${mainAPI}donations/recurring-donations/donation-subscriptions';
  static final String getMyDeductionSubscriptionDetails =
      '${mainAPI}donations/recurring-donations/donation-subscriptions/{id}';
  static final String putUpdateMyDeductionSubscriptionStatus =
      '${mainAPI}donations/recurring-donations/donation-subscriptions/{donation_subscription_id}/update-status';

  //============================================================================
  // Donation

  static final String getAllDonations = '${mainAPI}projects';
  static final String getDonationsBySearch = '${mainAPI}projects/search';
  static final String getDonationDetails = '${mainAPI}projects/{code}';
  static final String getDonationIsShowInQuickDonation =
      '${mainAPI}projects/show_quick_donation';
  static final String getDonationIsShowInCampaign =
      '${mainAPI}projects/show_campaign';
  static final String postCreateDonationOrder = '${mainAPI}projects/orders';

  //============================================================================
  // Zakat

  static final String getAllDonationOfZakat = '${mainAPI}projects/zakat';
  static final String getDefaultZakat = '${mainAPI}projects/default_zakat';

  //============================================================================
  // Zakat Calculation Management

  static final String postMetalPrice = '${mainAPI}metal/price';
  static final String postZakatCalculation = '${mainAPI}calculation/zakat';

  //============================================================================
  // Donation

  static final String getAllCampaigns = '${mainAPI}campaigns/all';
  static final String getCampaignsBySearch = '${mainAPI}campaigns/search';
  static final String getCampaignDetails = '${mainAPI}campaigns/{code}';
  static final String getAllCampaignDonations = '${mainAPI}campaign/orders';
  static final String getCampaignDetailsById = '${mainAPI}campaigns/id/{id}';
  static final String getMyCampaigns = '${mainAPI}campaigns';
  static final String postCreateNewCampaign = '${mainAPI}campaigns';
  static final String putUpdateMyCampaign = '${mainAPI}campaigns/{id}';

  //============================================================================
  // Payment Transaction

  static final String getAllPaymentTransactions =
      '${mainAPI}payments/transactions';
  static final String getPaymentTransactionDetails =
      '${mainAPI}payments/transactions/{id}';
  static final String postCreatePaymentTransactionForQuickDonation =
      '${mainAPI}payments/checkout/quick-donation/{project_id}';
  static final String postCreatePaymentTransactionForCart =
      '${mainAPI}payments/checkout/cart';
  // static final String postCreatePaymentTransactionDonation = '${mainAPI}payments/checkout/project/{project_id}';
  static final String postCreatePaymentTransactionForDeduction =
      '${mainAPI}payments/checkout/recurring-donation/{recurring_donation_id}';
  // static final String postCreatePaymentTransactionGiftOrder = '${mainAPI}payments/checkout/{gift_id}';
  static final String postAssignPaymentTransaction =
      '${mainAPI}payments/assign/{payment_transactions_code}';
  static final String getCheckStatusPaymentTransaction =
      '${mainAPI}payments/check/{id}';

  //============================================================================
  // Location

  static final String getAllCountries = '${mainAPI}countries';
  static final String getAllCities = '${mainAPI}cities';
  static final String postCreateLocation = '${mainAPI}carts/location';
  static final String putUpdateLocation = '${mainAPI}carts/location/{id}';

  //============================================================================
  // Cart

  static final String getAllCartItems = '${mainAPI}carts/items/{cart_id}';
  static final String getCreateCartID = '${mainAPI}carts/items/';
  static final String postCreateCartItem = '${mainAPI}carts/items/{cart_id}';
  static final String putUpdateCartItem = '${mainAPI}carts/items/{item_id}';
  static final String postAssignCart =
      '${mainAPI}carts/{cart_id}/assign-my-cart';
  static final String deleteCartItem = '${mainAPI}carts/items/{item_id}';
  static final String deleteAllCartItems =
      '${mainAPI}carts/items/delete-all/{cart_id}';

  //============================================================================
  // Payment Card

  // static final String postPaymentCardValidation = '${mainAPI}payments/cards/validation';
  static final String putUpdatePaymentCardAsDefault =
      '${mainAPI}payments/cards/{card_id}/assign-default';
  // static final String putUpdatePaymentCardStatus = '${mainAPI}payments/cards/status/{card_payment_gateway_card_id}';
  static final String getAllPaymentCards = '${mainAPI}payments/cards';
  static final String getPaymentCardDetails =
      '${mainAPI}payments/cards/{card_id}';
  static final String postCreatePaymentCard = '${mainAPI}payments/cards';
  static final String deletePaymentCard = '${mainAPI}payments/cards/{card_id}';

  //============================================================================
  // Rating

  static final String postRating = '${mainAPI}ratings';

  //============================================================================
  // Notifications

  static final String getAllNotifications =
      '${mainAPI}notification/notifications';

  //============================================================================
  // Share Links

  static final String getAllMyShareLinks = '${mainAPI}affiliations';
  static final String postCreateShareLink = '${mainAPI}affiliations';

  //============================================================================
  // Payment Transaction Item

  static final String getAllPaymentTransactionItemByModelType =
      '${mainAPI}payments/transactions/item';
  static final String getAllPaymentTransactionItemByModelTypeWithoutPaginated =
      '${mainAPI}payments/transactions/item/all';
  static final String getAllPaymentTransactionItemByModelId =
      '${mainAPI}payments/transactions/item/all';
}
