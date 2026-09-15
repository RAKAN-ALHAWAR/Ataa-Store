part of '../data.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Manage all database connections
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class DatabaseX {
  static init() async {
    try {
      /// Here codes are added to configure anything within this section when the application starts
      DBEndPointX.mainAPI = FirebaseRemoteConfigServiceX.getString(
        'base_url',
        'https://api-store.edialoguec.org.sa/api/v1/',
      );
      // DBEndPointX.mainAPI= 'https://ataa-store-backend-staging.edialoguecenter.com/api/v1/';
    } catch (e) {
      return Future.error(e);
    }
  }

  //============================================================================
  // Auth

  static Future<String?> signUp({
    required String name,
    required int phone,
    required int countryCode,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postSignUp,
      body: {
        NameX.name: name,
        NameX.phone: phone,
        NameX.countryCode: countryCode,
      },
    );
    return data.$2;
  }

  static Future<String?> loginByPhone({
    required int phone,
    required int countryCode,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postLoginByPhone,
      body: {NameX.phone: phone, NameX.countryCode: countryCode},
    );
    return data.$2;
  }

  static Future<String?> loginByEmail({required String email}) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postLoginByEmail,
      body: {NameX.email: email},
    );
    return data.$2;
  }

  static Future<UserX?> completeDataSingUp({
    required String gender,
    required String email,
  }) async {
    var data = await RemoteDataSourceX.put(
      DBEndPointX.putCompleteDataSingUp,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {
          NameX.email: email.toLowerCase().trim(),
          NameX.gender: gender.toLowerCase().trim(),
        },
      ),
    );
    try {
      return UserX.fromJson(data.$1[NameX.data], LocalDataX.token);
    } catch (_) {
      return null;
    }
  }

  static Future<void> logout() async {
    await RemoteDataSourceX.post(
      DBEndPointX.postLogout,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        ignoreUnauthorized: true,
        ignoreError: true,
      ),
    );
  }

  static Future<String?> deleteAccount() async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deleteAccount,
      param: DataSourceParamX(authToken: LocalDataX.token),
    );
    return data.$2;
  }

  //============================================================================
  // OTP

  static Future<UserX> otpByPhone({
    required int otp,
    required int phone,
    required int countryCode,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postVerifyOtpPhone,
      body: {
        NameX.phone: phone,
        NameX.countryCode: countryCode,
        NameX.otp: otp,
      },
    );
    return UserX.fromJson(data.$1[NameX.data], data.$1[NameX.token]);
  }

  static Future<UserX> otpByEmail({
    required int otp,
    required String email,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postVerifyOtpEmail,
      body: {NameX.email: email, NameX.otp: otp.toString()},
    );
    return UserX.fromJson(data.$1[NameX.data], data.$1[NameX.token]);
  }

  static Future<UserX?> otpUpdateProfile({required int otp}) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postOtpVerifyUpdateProfile,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {NameX.otp: otp},
      ),
    );
    try {
      return UserX.fromJson(data.$1[NameX.data], LocalDataX.token);
    } catch (_) {
      return null;
    }
  }

  static Future<String?> resendOtpUpdateProfile() async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postResendOTPUpdateProfile,
      param: DataSourceParamX(authToken: LocalDataX.token),
    );
    return data.$2;
  }

  static Future<String?> resendOtpByPhone({
    required int phone,
    required int countryCode,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postResendOtp,
      body: {NameX.phone: phone, NameX.countryCode: countryCode},
    );
    return data.$2;
  }

  //============================================================================
  // Profile

  static Future<UserX?> getProfile() async {
    try {
      var data = await RemoteDataSourceX.get(
        DBEndPointX.getProfile,
        param: DataSourceParamX(
          maxRetries: 3,
          localCacheKey: 'profile',
          localCacheMaxAge: const Duration(days: 3),
          authToken: LocalDataX.token,
        ),
      );
      return UserX.fromJson(
        Map<String, dynamic>.from(data.$1[NameX.data]),
        LocalDataX.token,
      );
    } catch (error) {
      if (error.toErrorX.errorCode == ErrorCodesX.unauthorized) {
        AppControllerX app = Get.find();
        await app.logOut();
      } else {
        rethrow;
      }
    }
    return null;
  }

  static Future<(UserX?, String?)> updateProfile({
    required String gender,
    required int phone,
    required int countryCode,
    required String? name,
    required String? email,
  }) async {
    var data = await RemoteDataSourceX.put(
      DBEndPointX.putUpdateProfile,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {
          NameX.name: name?.trim(),
          NameX.phone: phone,
          NameX.countryCode: countryCode,
          NameX.gender: gender.toLowerCase().trim(),
          NameX.email: email?.toLowerCase().trim(),
        },
      ),
    );
    try {
      return (UserX.fromJson(data.$1[NameX.data], LocalDataX.token), data.$2);
    } catch (e) {
      return (null, data.$2);
    }
  }

  static Future<String?> uploadProfileImage({required File image}) async {
    var data = await RemoteDataSourceX.postFiles(
      DBEndPointX.postUploadProfileImage,
      {NameX.imageFile: image},
      param: DataSourceParamX(authToken: LocalDataX.token),
    );
    return data.$2;
  }

  static Future<void> deleteProfileImage() async {
    await RemoteDataSourceX.delete(
      DBEndPointX.deleteProfileImage,
      param: DataSourceParamX(authToken: LocalDataX.token),
    );
  }

  //============================================================================
  // Home Element Settings

  static Future<HomeElementSettingsX> getHomeElementSettings() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getHomeElementSettings,
      param: DataSourceParamX(
        maxRetries: 3,
        localCacheKey: 'home_element_settings',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    final Map<String, dynamic> elementMap = {
      for (var item in (data.$1[NameX.data] ?? []) as List)
        item[NameX.name].toString(): item,
    };
    return HomeElementSettingsX.fromJson(elementMap);
  }
  //============================================================================
  // General Settings

  static Future<GeneralAppSettingsX> getGeneralSettings() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getGeneralSettings,
      param: DataSourceParamX(
        maxRetries: 3,
        // localCacheKey: 'general_settings',
        // localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return GeneralAppSettingsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // General Statistics

  static Future<List<GeneralStatisticX>> getGeneralStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getGeneralStatistics,
      param: DataSourceParamX(
        localCacheKey: 'general_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems<GeneralStatisticX>(
      data.$1[NameX.data],
      GeneralStatisticX.fromJson,
    );
  }

  //============================================================================
  // General Payment Methods Settings

  static Future<GeneralPaymentMethodsSettingsX>
  getGeneralPaymentMethodsSettings() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getGeneralPaymentMethodsSettings,
      param: DataSourceParamX(
        localCacheKey: 'general_payment_methods_settings',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return GeneralPaymentMethodsSettingsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // Dynamic Pages

  static Future<List<PageX>> getDynamicPages({
    int page = 1,
    int perPage = 20,
  }) async {
    List<String> exclude = [
      NameX.aboutPage,
      NameX.contactUsPage,
      NameX.termsAndConditionsPage,
      NameX.privacyPolicyPage,
    ];
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDynamicPages,
      param: DataSourceParamX(
        page: page,
        limit: perPage,
        localCacheKey: 'dynamic_pages',
        localCacheMaxAge: const Duration(days: 1),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems<PageX>(
      data.$1[NameX.data],
      PageX.fromJson,
    ).where((page) => !exclude.contains(page.tag)).toList();
  }

  //============================================================================
  // About

  static Future<PageX> getAboutPage() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAboutPage,
      param: DataSourceParamX(
        localCacheKey: 'about_page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    var aboutData = List.from(data.$1[NameX.data] ?? []).firstWhere(
      (page) => page[NameX.tag] == NameX.aboutPage,
      orElse: () => {},
    );
    return PageX.fromJson(Map<String, dynamic>.from(aboutData));
  }

  static Future<PageX> getPrivacyPolicyPage() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getPrivacyPolicyPage,
      param: DataSourceParamX(
        localCacheKey: 'privacy_policy_page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    var privacyPolicyData = List.from(data.$1[NameX.data] ?? []).firstWhere(
      (page) => page[NameX.tag] == NameX.privacyPolicyPage,
      orElse: () => {},
    );
    return PageX.fromJson(Map<String, dynamic>.from(privacyPolicyData));
  }

  static Future<PageX> getTermsAndConditionsPage() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getTermsAndConditionsPage,
      param: DataSourceParamX(
        localCacheKey: 'terms_and_conditions_page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    var termsAndConditionsData = List.from(data.$1[NameX.data] ?? [])
        .firstWhere(
          (page) => page[NameX.tag] == NameX.termsAndConditionsPage,
          orElse: () => {},
        );
    return PageX.fromJson(Map<String, dynamic>.from(termsAndConditionsData));
  }

  //============================================================================
  // Contact Us

  static Future<ContactUsX> getContactUs() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getContentUs,
      param: DataSourceParamX(
        localCacheKey: 'contact_us',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ContactUsX.fromJson(
      Map<String, dynamic>.from(data.$1?[NameX.data] ?? {}),
    );
  }

  static Future<ContactUsSocialMediaX> getContactUsSocialMedia() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getContentUsSocialMedia,
      param: DataSourceParamX(
        localCacheKey: 'contact_us_social_media',
        localCacheMaxAge: const Duration(days: 30),
        authToken: LocalDataX.token,
      ),
    );
    return ContactUsSocialMediaX.fromJson(
      Map<String, dynamic>.from(data.$1?[NameX.data] ?? {}),
    );
  }

  static Future<PageX> getContactUsPage() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getContactUsPage,
      param: DataSourceParamX(
        localCacheKey: 'contact_us_page',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    var contactUsData = List.from(data.$1[NameX.data] ?? []).firstWhere(
      (page) => page[NameX.tag] == NameX.contactUsPage,
      orElse: () => {},
    );
    return PageX.fromJson(Map<String, dynamic>.from(contactUsData));
  }

  //============================================================================
  // Bank Accounts

  static Future<List<BankX>> getAllBanks({
    int page = 1,
    int perPage = 20,
    bool onlyActive = true,
  }) async {
    var data = await RemoteDataSourceX.get(
      onlyActive ? DBEndPointX.getAllActiveBanks : DBEndPointX.getAllBanks,
      param: DataSourceParamX(
        localCacheKey: 'all-banks',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems<BankX>(data.$1[NameX.data], BankX.fromJson);
  }

  static Future<BankAccountX> getBankAccountDetails({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getBankAccountDetails,
      param: DataSourceParamX(
        localCacheKey: 'bank-account-$id',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return BankAccountX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // Gift

  static Future<List<GiftCategoryX>> getAllGiftCategories({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllGiftCategories,
      param: DataSourceParamX(
        localCacheKey: 'all_gift_categories',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.data],
      GiftCategoryX.fromJson,
    );
  }

  static Future<GiftCategoryX> getGiftCategoryDetails({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getGiftCategoryDetails,
      param: DataSourceParamX(
        localCacheKey: 'gift_category_details_$id',
        localCacheMaxAge: const Duration(days: 1),
        authToken: LocalDataX.token,
        pathParams: {NameX.id: id},
      ),
    );
    return GiftCategoryX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<GiftMessageX> getGiftMessageTemplate() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getGiftMessageTemplate,
      param: DataSourceParamX(
        localCacheKey: 'get_gift_message_template',
        localCacheMaxAge: const Duration(days: 7),
        authToken: LocalDataX.token,
      ),
    );
    return GiftMessageX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<GiftOrderX> createGiftOrder({required GiftX gift}) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postCreateGiftOrder,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: gift.toJson(),
      ),
    );
    return GiftOrderX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<List<GiftOrderX>> getAllMyGiftOrders({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllMyGiftOrders,
      param: DataSourceParamX(
        localCacheKey: 'all_my_gift_orders',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], GiftOrderX.fromJson);
  }

  static Future<GiftOrderX> getMyGiftOrderDetails({required String id}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getMyGiftOrderDetails,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.id: id},
      ),
    );
    return GiftOrderX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  //============================================================================
  // Statistics

  static Future<DonationStatisticsX> getDonationStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDonationStatistics,
      param: DataSourceParamX(
        localCacheKey: 'donation_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return DonationStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<MyCampaignStatisticsX> getCampaignStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getCampaignStatistics,
      param: DataSourceParamX(
        localCacheKey: 'campaign_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return MyCampaignStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<OrderStatisticsX> getOrderStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getOrderStatistics,
      param: DataSourceParamX(
        localCacheKey: 'order_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return OrderStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<GiftStatisticsX> getGiftStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getGiftStatistics,
      param: DataSourceParamX(
        localCacheKey: 'gift_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return GiftStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<DeductionStatisticsX> getDeductionStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDeductionStatistics,
      param: DataSourceParamX(
        localCacheKey: 'deduction_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return DeductionStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<SponsorshipStatisticsX> getSponsorshipStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getSponsorshipStatistics,
      param: DataSourceParamX(
        localCacheKey: 'sponsorship_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return SponsorshipStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<ShareLinkStatisticsX> getShareLinkStatistics() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getShareLinkStatistics,
      param: DataSourceParamX(
        localCacheKey: 'share_link_statistics',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ShareLinkStatisticsX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // Ads

  static Future<List<AdsX>> getAds() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAds,
      param: DataSourceParamX(
        localCacheKey: 'ads',
        localCacheMaxAge: const Duration(days: 1),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems<AdsX>(data.$1[NameX.data], AdsX.fromJson);
  }

  //============================================================================
  // Testimonials

  static Future<List<TestimonialX>> getTestimonials({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getTestimonials,
      param: DataSourceParamX(
        localCacheKey: 'testimonials',
        localCacheMaxAge: const Duration(days: 30),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems<TestimonialX>(
      data.$1[NameX.data],
      TestimonialX.fromJson,
    );
  }

  //============================================================================
  // Partners

  static Future<List<PartnerX>> getPartners({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getPartners,
      param: DataSourceParamX(
        localCacheKey: 'partners',
        localCacheMaxAge: const Duration(days: 30),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems<PartnerX>(
      data.$1[NameX.data],
      PartnerX.fromJson,
    );
  }

  //============================================================================
  // Organizations

  static Future<List<OrganizationX>> getAllOrganizations({
    bool? isHome,
    bool? isQuickDonation,
    int page = 1,
    int perPage = 20,
  }) async {
    Map<String, dynamic>? filterParams = {
      NameX.isShowHome: isHome.toIntNullableX,
      NameX.isQuickDonation: isQuickDonation.toIntNullableX,
    };
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllOrganizations,
      param: DataSourceParamX(
        localCacheKey: 'all_organizations$filterParams',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
        filterParams: filterParams,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.data],
      OrganizationX.fromJson,
    );
  }

  static Future<OrganizationX> getOrganizationDetails({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getOrganizationDetails,
      param: DataSourceParamX(
        localCacheKey: 'organization_details_$id',
        localCacheMaxAge: const Duration(days: 1),
        authToken: LocalDataX.token,
        pathParams: {NameX.id: id},
      ),
    );
    return OrganizationX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // Deduction

  static Future<List<DeductionX>> getAllDeductions({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllDeductions,
      param: DataSourceParamX(
        localCacheKey: 'all_deductions',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], DeductionX.fromJson);
  }

  static Future<List<DeductionX>> getDeductionsBySearch({
    String? sortType,
    String? recurring,
    String? categoryID,
    String? searchQuery,
    int page = 1,
    int perPage = 20,
  }) async {
    Map<String, dynamic>? filterParams = {
      NameX.sortType: sortType,
      NameX.donationCategoryId: categoryID,
      if (recurring != null) NameX.manyRecurring: [recurring],
    };
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDeductionsBySearch,
      param: DataSourceParamX(
        localCacheKey: 'deductions_by_search_$filterParams',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
        filterParams: filterParams,
        search: searchQuery,
        searchKey: NameX.search,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], DeductionX.fromJson);
  }

  static Future<DeductionX> getDeductionDetails({required int code}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDeductionDetails,
      param: DataSourceParamX(
        localCacheKey: 'deduction_details_$code',
        localCacheMaxAge: const Duration(days: 1),
        authToken: LocalDataX.token,
        pathParams: {NameX.code: code},
      ),
    );
    return DeductionX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  //============================================================================
  // Subscription

  static Future<DeductionOrderX> updateMyDeductionSubscriptionStatus({
    required String id,
    required bool status,
  }) async {
    var data = await RemoteDataSourceX.put(
      DBEndPointX.putUpdateMyDeductionSubscriptionStatus,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.donationSubscriptionId: id},
        requestBody: {NameX.status: status.toIntX},
      ),
    );
    return DeductionOrderX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<List<DeductionOrderX>> getAllMyDeductionSubscription() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllMyDeductionSubscription,
      param: DataSourceParamX(
        localCacheKey: 'all_my_deduction_subscription',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.data],
      DeductionOrderX.fromJson,
    );
  }

  //============================================================================
  // Donations

  static Future<List<DonationX>> getAllDonations({
    bool? isHome,
    bool? isZakat,
    String? categoryID,
    int page = 1,
    int perPage = 20,
  }) async {
    Map<String, dynamic>? filterParams = {
      if (isHome != null) NameX.isShowHome: isHome.toIntNullableX,
      if (isZakat != null) NameX.isZakat: isZakat.toIntNullableX,
      NameX.donationCategoryId: categoryID,
    };
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllDonations,
      param: DataSourceParamX(
        localCacheKey: 'donations_$filterParams',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
        filterParams: filterParams,
      ),
    );
    List<DonationX> result = ModelUtilX.generateItems(
      data.$1[NameX.data],
      DonationX.fromJson,
    );
    if (result.isEmpty && isZakat == true) {
      result = [await getDefaultZakat()];
    }
    return result;
  }

  static Future<List<DonationX>> getDonationsBySearch({
    bool? isZakat,
    String? sortType,
    String? categoryID,
    String? searchQuery,
    int page = 1,
    int perPage = 20,
  }) async {
    if ((searchQuery == null || searchQuery.isEmpty) &&
        (sortType == null || sortType.isEmpty)) {
      return await getAllDonations(
        isZakat: isZakat,
        categoryID: categoryID,
        page: page,
        perPage: perPage,
      );
    } else {
      Map<String, dynamic>? filterParams = {
        if (isZakat != null) NameX.isZakat: isZakat.toIntNullableX,
        NameX.donationCategoryId: categoryID,
        NameX.sortType: sortType,
      };
      var data = await RemoteDataSourceX.get(
        DBEndPointX.getDonationsBySearch,
        param: DataSourceParamX(
          localCacheKey: 'donations_by_search_$filterParams',
          localCacheMaxAge: const Duration(days: 3),
          authToken: LocalDataX.token,
          page: page,
          limit: perPage,
          filterParams: filterParams,
          search: searchQuery,
          searchKey: NameX.search,
        ),
      );
      List<DonationX> result = ModelUtilX.generateItems(
        data.$1[NameX.data],
        DonationX.fromJson,
      );
      if (result.isEmpty &&
          isZakat == true &&
          (searchQuery == null || searchQuery.isEmpty)) {
        result = [await getDefaultZakat()];
      }
      return result;
    }
  }

  static Future<DonationX> getDonationDetails({required int code}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDonationDetails,
      param: DataSourceParamX(
        localCacheKey: 'donation_details_$code',
        localCacheMaxAge: const Duration(days: 1),
        authToken: LocalDataX.token,
        pathParams: {NameX.code: code},
      ),
    );
    return DonationX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<List<DonationX>> getAllDonationInQuickDonation() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDonationIsShowInQuickDonation,
      param: DataSourceParamX(
        localCacheKey: 'all_donation_in_quick_donation',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], DonationX.fromJson);
  }

  /// Projects eligible to be used when creating a campaign.
  ///
  /// The `projects/show_campaign` endpoint already excludes completed projects.
  /// It returns the full list at once and ignores server-side pagination and
  /// search, so the query params are forwarded for consistency and the search
  /// is applied locally on the returned list.
  static Future<List<DonationX>> getAllDonationInCampaign({
    int page = 1,
    int perPage = 20,
    String? searchQuery,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDonationIsShowInCampaign,
      param: DataSourceParamX(
        localCacheKey: 'all_donation_in_campaign',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
        search: searchQuery,
        searchKey: NameX.search,
      ),
    );

    List<DonationX> result =
        ModelUtilX.generateItems(data.$1[NameX.data], DonationX.fromJson);

    if (searchQuery != null && searchQuery.trim().isNotEmpty) {
      final String query = searchQuery.trim().toLowerCase();
      result = result
          .where((d) => d.donationBasic.name.toLowerCase().contains(query))
          .toList();
    }

    return result;
  }

  static Future<DonationOrderX> createDonationOrder({
    required DonationOrderFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postCreateDonationOrder,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
      ),
    );
    return DonationOrderX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // Zakat

  static Future<List<DonationX>> getAllDonationOfZakat() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllDonationOfZakat,
      param: DataSourceParamX(
        localCacheKey: 'all_donation_of_zakat',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], DonationX.fromJson);
  }

  static Future<DonationX> getDefaultZakat() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getDefaultZakat,
      param: DataSourceParamX(
        localCacheKey: 'default_zakat',
        localCacheMaxAge: const Duration(days: 7),
        authToken: LocalDataX.token,
      ),
    );
    return DonationX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  //============================================================================
  // Zakat Calculation Management

  static Future<MetalPriceX> getMetalPrice({
    required MetalStatusX metal,
    int? karat,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postMetalPrice,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {NameX.metal: metal.name, NameX.karat: karat?.toString()},
      ),
    );
    return MetalPriceX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<int> getZakatCalculation({
    required ZakatCalculationFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postZakatCalculation,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
      ),
    );
    if (data.$1.runtimeType == int || data.$1.runtimeType == double) {
      return int.parse(data.$1.toString());
    } else {
      return throw ErrorX(message: data.$2);
    }
  }

  //============================================================================
  // Campaigns

  static Future<CampaignX> getCampaignDetails({required String code}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getCampaignDetails,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.code: code},
      ),
    );
    return CampaignX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<CampaignX> getCampaignDetailsById({required String id}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getCampaignDetailsById,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.id: id},
      ),
    );
    return CampaignX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<List<CampaignDonationX>> getAllCampaignDonations({
    required String campaignId,
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllCampaignDonations,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
        filterParams: {NameX.campaignId: campaignId},
      ),
    );
    return ModelUtilX.generateItems(
      data.$1[NameX.data],
      CampaignDonationX.fromJson,
    );
  }

  static Future<List<CampaignX>> getAllCampaigns({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllCampaigns,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], CampaignX.fromJson);
  }

  static Future<List<CampaignX>> getCampaignsBySearch({
    String? sortType,
    String? searchQuery,
    int page = 1,
    int perPage = 20,
  }) async {
    if ((searchQuery == null || searchQuery.isEmpty) &&
        (sortType == null || sortType.isEmpty)) {
      return await getAllCampaigns(page: page, perPage: perPage);
    } else {
      Map<String, dynamic>? filterParams = {NameX.sortType: sortType};
      var data = await RemoteDataSourceX.get(
        DBEndPointX.getCampaignsBySearch,
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          page: page,
          limit: perPage,
          filterParams: filterParams,
          search: searchQuery,
          searchKey: NameX.search,
        ),
      );
      return ModelUtilX.generateItems(data.$1[NameX.data], CampaignX.fromJson);
    }
  }

  static Future<List<CampaignX>> getMyCampaigns({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getMyCampaigns,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], CampaignX.fromJson);
  }

  static Future<CampaignX> createNewCampaign({
    required CampaignFormX form,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postCreateNewCampaign,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: form.toJson(),
      ),
    );
    return CampaignX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<CampaignX> updateMyCampaign({
    required CampaignFormX form,
    required String id,
  }) async {
    var data = await RemoteDataSourceX.put(
      DBEndPointX.putUpdateMyCampaign,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.id: id},
        requestBody: form.toJson(),
      ),
    );
    return CampaignX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  //============================================================================
  // Payment Transaction

  static Future<PaymentTransactionX> createPaymentTransactionForQuickDonation({
    required PaymentTransactionFormX form,
    required String projectId,
  }) async {
    dynamic data;
    if (form.transferImageFile != null) {
      data = await RemoteDataSourceX.postFiles(
        DBEndPointX.postCreatePaymentTransactionForQuickDonation,
        {NameX.transferImageFile: form.transferImageFile!},
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          requestBody: form.toJson(),
          pathParams: {NameX.projectId: projectId},
          maxRetries: 3,
        ),
      );
    } else {
      data = await RemoteDataSourceX.post(
        DBEndPointX.postCreatePaymentTransactionForQuickDonation,
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          pathParams: {NameX.projectId: projectId},
          requestBody: form.toJson(),
          maxRetries: 3,
        ),
      );
    }
    return PaymentTransactionX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<PaymentTransactionX> createPaymentTransactionForCart({
    required PaymentTransactionFormX form,
  }) async {
    dynamic data;
    if (form.transferImageFile != null) {
      data = await RemoteDataSourceX.postFiles(
        DBEndPointX.postCreatePaymentTransactionForCart,
        {NameX.transferImageFile: form.transferImageFile!},
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          requestBody: form.toJson(),
          maxRetries: 3,
        ),
      );
    } else {
      data = await RemoteDataSourceX.post(
        DBEndPointX.postCreatePaymentTransactionForCart,
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          requestBody: form.toJson(),
          maxRetries: 3,
        ),
      );
    }
    return PaymentTransactionX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<PaymentTransactionX> createPaymentTransactionForDeduction({
    required PaymentTransactionFormX form,
    required String deductionId,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postCreatePaymentTransactionForDeduction,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.deductionId: deductionId},
        requestBody: form.toJson(),
        maxRetries: 3,
      ),
    );
    return PaymentTransactionX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<String?> assignPaymentTransaction({
    required int paymentTransactionCode,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postAssignPaymentTransaction,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.paymentTransactionsCode: paymentTransactionCode},
        maxRetries: 3,
      ),
    );
    return data.$2;
  }

  static Future<PaymentStatusStatusX?> getCheckStatusPaymentTransaction({
    required String id,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getCheckStatusPaymentTransaction,
      param: DataSourceParamX(pathParams: {NameX.id: id}, maxRetries: 3),
    );
    String status = (data.$1 ?? '').toString();
    return PaymentStatusStatusX.values.firstWhereOrNull(
      (x) => x.name == status,
    );
  }

  //============================================================================
  // Cart

  static Future assignCart(String cartId, String token) async {
    try {
      return await RemoteDataSourceX.post(
        DBEndPointX.postAssignCart,
        param: DataSourceParamX(
          maxRetries: 3,
          authToken: token,
          pathParams: {NameX.cartId: cartId},
        ),
      );
    } catch (e) {
      e.toErrorX.log();
      if (e.toErrorX.errorCode == ErrorCodesX.notFound) {
        return;
      } else {
        rethrow;
      }
    }
  }

  static Future<CartX> createCart() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getCreateCartID,
      param: DataSourceParamX(authToken: LocalDataX.token),
    );
    return CartX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<CartX> getAllCartItems({String? cartId}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllCartItems,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        localCacheKey: 'cart',
        localCacheMaxAge: const Duration(days: 1),
        pathParams: {NameX.cartId: cartId ?? ''},
      ),
    );
    return CartX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data]));
  }

  static Future<MiniCartX> createCartItem(
    String cartId,
    ModelTypeStatusX modelType,
    String modelId, {
    int quantity = 1,
  }) async {
    try {
      var data = await RemoteDataSourceX.post(
        DBEndPointX.postCreateCartItem,
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          pathParams: {NameX.cartId: cartId},
          requestBody: {
            // NameX.cartId: cartId,
            NameX.modelType: modelType.name,
            NameX.modelId: modelId,
            NameX.quantity: quantity,
          },
        ),
      );
      return MiniCartX.fromJson(Map<String, dynamic>.from(data.$1));
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<(CartX, String?)> updateCartItem({
    required UpdateCartItemFormX form,
  }) async {
    try {
      var data = await RemoteDataSourceX.put(
        DBEndPointX.putUpdateCartItem,
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          pathParams: {NameX.itemId: form.id},
          requestBody: form.toJson(),
        ),
      );
      return (
        CartX.fromJson(Map<String, dynamic>.from(data.$1[NameX.data])),
        data.$2,
      );
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<MiniCartX> deleteCartItem({required String itemId}) async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deleteCartItem,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.itemId: itemId},
      ),
    );
    return MiniCartX.fromJson(Map<String, dynamic>.from(data.$1));
  }

  static Future<MiniCartX> deleteAllCartItems({required String cartId}) async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deleteAllCartItems,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.cartId: cartId},
      ),
    );
    Map<String, dynamic> dataJson = data.$1 is Map
        ? Map<String, dynamic>.from(data.$1)
        : {};
    return MiniCartX.fromJson(dataJson);
  }

  //============================================================================
  // Payment Card

  static Future<List<PaymentCardX>> getAllPaymentCards() async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllPaymentCards,
      param: DataSourceParamX(
        localCacheKey: 'payment_cards',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
      ),
    );
    return ModelUtilX.generateItems(data.$1[NameX.data], PaymentCardX.fromJson);
  }

  static Future<PaymentCardX> getPaymentCardDetails({
    required String cardId,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getPaymentCardDetails,
      param: DataSourceParamX(
        localCacheKey: 'payment_card_$cardId',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        pathParams: {NameX.cardId: cardId},
      ),
    );
    return PaymentCardX.fromJson(data.$1[NameX.data]);
  }

  static Future<PaymentCardX> createPaymentCard({
    required PaymentCardFormX form,
  }) async {
    try {
      var data = await RemoteDataSourceX.post(
        DBEndPointX.postCreatePaymentCard,
        param: DataSourceParamX(
          authToken: LocalDataX.token,
          requestBody: form.toJson(),
        ),
      );
      return PaymentCardX.fromJson(
        Map<String, dynamic>.from(data.$1[NameX.data]),
      );
    } catch (e) {
      ErrorX error = e.toErrorX;
      if (error.details[NameX.data]?[NameX.data]?[NameX.message] != null) {
        error.message = error.details[NameX.data][NameX.data][NameX.message];
      }
      return throw error;
    }
  }

  static Future<PaymentCardX> updatePaymentCardSetAsDefault({
    required String cardId,
  }) async {
    var data = await RemoteDataSourceX.put(
      DBEndPointX.putUpdatePaymentCardAsDefault,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.cardId: cardId},
      ),
    );
    return PaymentCardX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  static Future<String?> deletePaymentCard({required String cardId}) async {
    var data = await RemoteDataSourceX.delete(
      DBEndPointX.deletePaymentCard,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.cardId: cardId},
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Rating

  static Future<String?> rating({
    required String id,
    required RateTypeStatusX type,
    required int rate,
    required String? comment,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postRating,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {
          NameX.id: id,
          NameX.type: type.name,
          NameX.rate: rate,
          NameX.comment: comment,
        },
      ),
    );
    return data.$2;
  }

  //============================================================================
  // Notifications

  static Future<List<NotificationX>> getAllNotifications({
    bool? isRead,
    String? type,
    int page = 1,
    int perPage = 20,
  }) async {
    Map<String, dynamic>? filterParams = {
      if (isRead != null) NameX.isRead: isRead,
      if (type != null) NameX.type: type,
    };
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllNotifications,
      param: DataSourceParamX(
        localCacheKey: 'get_all_notifications$filterParams',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
        filterParams: filterParams,
      ),
    );

    List<Map<String, dynamic>> allNotifications = [];
    for (var item in data.$1[NameX.data]) {
      if (item[NameX.notifications] != null) {
        allNotifications.addAll(
          List<Map<String, dynamic>>.from(item[NameX.notifications]),
        );
      }
    }
    return ModelUtilX.generateItems(allNotifications, NotificationX.fromJson);
  }
  //============================================================================
  // Share Links

  static Future<List<ShareLinkX>> getAllMyShareLinks({
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllMyShareLinks,
      param: DataSourceParamX(
        localCacheKey: 'get_all_share_links',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        page: page,
        // NOTE: the affiliations endpoint returns HTTP 502 when a per_page
        // (limit) query param is sent, so it is intentionally omitted here and
        // the server default page size is used.
        filterParams: {
          NameX.ownerType: 'User',
          NameX.isPaginate: 1,
        },
      ),
    );

    return ModelUtilX.generateItems(data.$1[NameX.data], ShareLinkX.fromJson);
  }

  static Future<MiniShareLinkX> createShareLink({
    required LinkableTypeStatusX linkableType,
    required String modelId,
  }) async {
    var data = await RemoteDataSourceX.post(
      DBEndPointX.postCreateShareLink,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        requestBody: {
          NameX.linkableType: linkableType.name,
          NameX.linkableId: modelId,
        },
      ),
    );

    return MiniShareLinkX.fromJson(
      Map<String, dynamic>.from(data.$1[NameX.data]),
    );
  }

  //============================================================================
  // My Records

  static Future<List<PaymentTransactionItemX<T>>>
  getAllMyRecords<T extends OrderX>({
    ModelTypeStatusX? type,
    T Function(Map<String, dynamic>)? orderModelFromJson,
    bool isAllWithoutPaginated = false,
    String? byModelId,
    int page = 1,
    int perPage = 20,
  }) async {
    var data = await RemoteDataSourceX.get(
      !isAllWithoutPaginated
          ? DBEndPointX.getAllPaymentTransactionItemByModelType
          : DBEndPointX.getAllPaymentTransactionItemByModelTypeWithoutPaginated,
      param: DataSourceParamX(
        localCacheKey:
            'all_my_records_by_model_type_${type?.name}_$isAllWithoutPaginated',
        localCacheMaxAge: const Duration(days: 3),
        authToken: LocalDataX.token,
        filterParams: {
          if (type != null) NameX.modelType: type.name,
          if (byModelId != null) NameX.modelId: byModelId,
        },
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems<PaymentTransactionItemX<T>>(
      data.$1[NameX.data],
      (Map<String, dynamic> json) =>
          PaymentTransactionItemX<T>.fromJson(json, orderModelFromJson),
    );
  }

  static Future<List<PaymentTransactionX>> getAllPaymentTransactions<
    T extends OrderX
  >({int page = 1, int perPage = 20}) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getAllPaymentTransactions,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        page: page,
        limit: perPage,
      ),
    );
    return ModelUtilX.generateItems<PaymentTransactionX>(
      data.$1[NameX.data],
      (Map<String, dynamic> json) => PaymentTransactionX.fromJson(json),
    );
  }

  static Future<PaymentTransactionX> getPaymentTransaction<T extends OrderX>({
    required String paymentTransactionId,
  }) async {
    var data = await RemoteDataSourceX.get(
      DBEndPointX.getPaymentTransactionDetails,
      param: DataSourceParamX(
        authToken: LocalDataX.token,
        pathParams: {NameX.id: paymentTransactionId},
      ),
    );
    return PaymentTransactionX.fromJson(data.$1[NameX.data]);
  }
}
