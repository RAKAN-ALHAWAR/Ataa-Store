import 'package:ataa/Ui/Screen/Auth/ContinueToAccount/view/view.dart';
import 'package:get/get.dart';
import '../../Core/Controller/Cart/deliveryAddressController.dart';
import '../../Core/Controller/Pay/directZakatPaymentController.dart';
import '../../Ui/Screen/Auth/ContinueToAccount/controller/Controller.dart';
import '../../Ui/Screen/Basic/About/About/controller/Controller.dart';
import '../../Ui/Screen/Basic/About/About/view/View.dart';
import '../../Ui/Screen/Basic/Loading/View/View.dart';
import '../../Ui/Screen/Basic/Loading/controller/Controller.dart';
import '../../Ui/Screen/Campaigns/MyCampaignDetails/controller/controller.dart';
import '../../Ui/Screen/Campaigns/MyCampaignDetails/view/view.dart';
import '../../Ui/Screen/Cart/controller/Controller.dart';
import '../../Ui/Screen/Cart/view/View.dart';
import '../../Ui/Screen/Campaigns/AllCampaigns/controller/Controller.dart';
import '../../Ui/Screen/Campaigns/AllCampaigns/view/View.dart';
import '../../Ui/Screen/Campaigns/CampaignDetails/controller/Controller.dart';
import '../../Ui/Screen/Campaigns/CampaignDetails/view/View.dart';
import '../../Ui/Screen/Campaigns/CreateCampaign/controller/Controller.dart';
import '../../Ui/Screen/Campaigns/CreateCampaign/view/View.dart';
import '../../Ui/Screen/DynamicPage/controller/Controller.dart';
import '../../Ui/Screen/DynamicPage/view/View.dart';
import '../../Ui/Screen/Deduction/AllDeductions/controller/Controller.dart';
import '../../Ui/Screen/Deduction/AllDeductions/view/View.dart';
import '../../Ui/Screen/Deduction/DeductionDetails/controller/Controller.dart';
import '../../Ui/Screen/Deduction/DeductionDetails/view/View.dart';
import '../../Ui/Screen/Gift/CreateGift/controller/Controller.dart';
import '../../Ui/Screen/Gift/CreateGift/view/View.dart';
import '../../Ui/Screen/Gift/PreviewGift/controller/Controller.dart';
import '../../Ui/Screen/Gift/PreviewGift/view/View.dart';
import '../../Ui/Screen/Payment/DeductionPayment/controller/Controller.dart';
import '../../Ui/Screen/Payment/DeductionPayment/view/View.dart';
import '../../Ui/Screen/Payment/GeneralPayment/controller/Controller.dart';
import '../../Ui/Screen/Payment/GeneralPayment/view/View.dart';
import '../../Ui/Screen/Payment/PaymentSuccessful/controller/Controller.dart';
import '../../Ui/Screen/Payment/PaymentSuccessful/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MyShareLinks/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MyShareLinks/view/View.dart';
import '../../Ui/Screen/ReceiptPreview/controller/Controller.dart';
import '../../Ui/Screen/ReceiptPreview/view/View.dart';
import '../../Ui/Screen/Sponsorships/AllSponsorships/controller/Controller.dart';
import '../../Ui/Screen/Sponsorships/AllSponsorships/view/View.dart';
import '../../Ui/Screen/Sponsorships/TypesSponsorships/controller/Controller.dart';
import '../../Ui/Screen/Sponsorships/TypesSponsorships/view/View.dart';
import '../../Ui/Screen/Profile/Activity/Activity/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/Activity/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MyCampaigns/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MyCampaigns/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MyGift/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MyGift/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MyDeductions/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MyDeductions/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MyDonations/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MyDonations/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MySponsorships/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MySponsorships/view/View.dart';
import '../../Ui/Screen/Profile/Activity/MyOrders/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/MyOrders/view/View.dart';
import '../../Ui/Screen/Profile/Activity/PaymentCards/controller/Controller.dart';
import '../../Ui/Screen/Profile/Activity/PaymentCards/view/View.dart';
import '../../Ui/Screen/VerificationUrl/controller/Controller.dart';
import '../../Ui/Screen/VerificationUrl/view/View.dart';
import '../../Ui/Screen/Zakat/Zakat/controller/Controller.dart';
import '../../Ui/Screen/Zakat/Zakat/view/View.dart';
import '../../Ui/Screen/Zakat/ZakatCalculator/controller/Controller.dart';
import '../../Ui/Screen/Zakat/ZakatCalculator/view/View.dart';
import '../../Ui/Screen/Zakat/ZakatDisbursements/controller/Controller.dart';
import '../../Ui/Screen/Zakat/ZakatDisbursements/view/View.dart';
import '../config.dart';
import '../../Ui/Screen/Donation/AllDonation/controller/Controller.dart';
import '../../Ui/Screen/Organization/AllOrganizations/controller/Controller.dart';
import '../../Ui/Screen/Organization/AllOrganizations/view/View.dart';
import '../../Ui/Screen/Organization/OrganizationDetails/controller/Controller.dart';
import '../../Ui/Screen/Organization/OrganizationDetails/view/View.dart';
import '../../Ui/Screen/Store/ProductDetails/controller/Controller.dart';
import '../../Ui/Screen/Store/ProductDetails/view/View.dart';
import '../../Ui/Screen/Store/Store/controller/Controller.dart';
import '../../Ui/Screen/Store/Store/view/View.dart';
import '../../Ui/Screen/Donation/DonationDetails/controller/Controller.dart';
import '../../Ui/Screen/Donation/DonationDetails/view/View.dart';
import '../../Ui/Screen/Auth/CompleteAccountData/controller/Controller.dart';
import '../../Ui/Screen/Auth/CompleteAccountData/view/View.dart';
import '../../Ui/Screen/Auth/OTP/controller/Controller.dart';
import '../../Ui/Screen/Auth/OTP/view/View.dart';
import '../../Ui/Screen/Auth/SignUp/controller/Controller.dart';
import '../../Ui/Screen/Auth/SignUp/view/View.dart';
import '../../Ui/Screen/Basic/About/ContactUs/controller/Controller.dart';
import '../../Ui/Screen/Basic/About/ContactUs/view/View.dart';
import '../../Ui/Screen/Basic/About/OurBank/controller/Controller.dart';
import '../../Ui/Screen/Basic/About/OurBank/view/View.dart';
import '../../Ui/Screen/Basic/About/PrivacyPolicy/controller/Controller.dart';
import '../../Ui/Screen/Basic/About/PrivacyPolicy/view/View.dart';
import '../../Ui/Screen/Basic/About/TermsConditions/controller/Controller.dart';
import '../../Ui/Screen/Basic/About/TermsConditions/view/View.dart';
import '../../Ui/Screen/Basic/Notification/controller/Controller.dart';
import '../../Ui/Screen/Basic/Notification/view/View.dart';
import '../../Ui/Screen/Basic/Root/View/View.dart';
import '../../Ui/Screen/Basic/Root/controller/Controller.dart';
import '../../Ui/Screen/Onboarding/controller/Controller.dart';
import '../../Ui/Screen/Onboarding/view/View.dart';
import '../../Ui/Screen/Home/controller/Controller.dart';
import '../../UI/Screen/Auth/Login/controller/Controller.dart';
import '../../UI/Screen/Auth/Login/view/loginView.dart';
import '../../Ui/Screen/MoreSections/controller/Controller.dart';
import '../../Ui/Screen/Profile/EditProfile/controller/Controller.dart';
import '../../Ui/Screen/Profile/EditProfile/view/View.dart';
import '../../Ui/Screen/Profile/ProfileDetails/controller/Controller.dart';
import '../../Ui/Screen/Profile/Statistics/controller/Controller.dart';
import '../../Ui/Screen/Profile/Statistics/view/View.dart';
import '../../../Ui/Screen/Basic/Settings/controller/Controller.dart';
import '../../../Ui/Screen/Basic/Settings/view/View.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Link pages to their controller via the page name
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class RouteListX {
  /// List Routes
  static final List<GetPage<dynamic>> routes = [
    /// Loading
    GetPage(
      name: RouteNameX.loading,
      page: () => const LoadingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoadingController());
      }),
    ),

    /// Root
    GetPage(
      name: RouteNameX.root,
      page: () => const RootView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RootController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.lazyPut(() => AllDonationController(), fenix: true);
        Get.lazyPut(() => MoreSectionsController(), fenix: true);
        Get.lazyPut(() => ProfileDetailsController(), fenix: true);
      }),
    ),
    //========================================================
    ///Auth
    GetPage(
      name: RouteNameX.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => LoginController());
      }),
    ),
    GetPage(
      name: RouteNameX.continueToAccount,
      page: () => ContinueToAccountView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ContinueToAccountController());
      }),
    ),
    GetPage(
      name: RouteNameX.signUp,
      page: () => SignUpView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SignUpController());
      }),
    ),
    GetPage(
      name: RouteNameX.otp,
      page: () => OTPView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OTPController());
      }),
    ),
    GetPage(
      name: RouteNameX.completeAccountData,
      page: () => const CompleteAccountDataView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CompleteAccountDataController());
      }),
    ),
    //========================================================
    /// Onboarding
    GetPage(
      name: RouteNameX.onboarding,
      page: () => const OnboardingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OnboardingController());
      }),
    ),
    //========================================================
    /// Dynamic Page
    GetPage(
      name: RouteNameX.dynamicPage,
      page: () => const DynamicPageView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DynamicPageController());
      }),
    ),
    //========================================================
    /// Receipt Preview
    GetPage(
      name: RouteNameX.receiptPreview,
      page: () => const ReceiptPreviewView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ReceiptPreviewController());
      }),
    ),
    //========================================================
    /// Verification Url
    GetPage(
      name: RouteNameX.verificationUrl,
      page: () => const VerificationUrlView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => VerificationUrlController());
      }),
    ),
    //========================================================
    /// Payment
    GetPage(
      name: RouteNameX.generalPayment,
      page: () => const GeneralPaymentView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => GeneralPaymentController());
      }),
    ),
    GetPage(
      name: RouteNameX.deductionPayment,
      page: () => const DeductionPaymentView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DeductionPaymentController());
      }),
    ),
    GetPage(
      name: RouteNameX.paymentSuccessful,
      page: () => const PaymentSuccessfulView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PaymentSuccessfulController());
      }),
    ),
    //========================================================
    /// Profile
    GetPage(
      name: RouteNameX.editProfile,
      page: () => const EditProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => EditProfileController());
      }),
    ),
    GetPage(
      name: RouteNameX.notifications,
      page: () => const NotificationsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => NotificationsController());
      }),
    ),
    GetPage(
      name: RouteNameX.statistics,
      page: () => const StatisticsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => StatisticsController());
      }),
    ),
    //========================================================
    /// Activity
    GetPage(
      name: RouteNameX.activity,
      page: () => const ActivityView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ActivityController());
      }),
    ),
    GetPage(
      name: RouteNameX.myDonations,
      page: () => const MyDonationsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyDonationsController());
      }),
    ),
    GetPage(
      name: RouteNameX.myOrders,
      page: () => const MyOrdersView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyOrdersController());
      }),
    ),
    GetPage(
      name: RouteNameX.myGifts,
      page: () => const MyGiftingView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyGiftingController());
      }),
    ),
    GetPage(
      name: RouteNameX.myCampaigns,
      page: () => const MyCampaignsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyCampaignsController());
      }),
    ),
    GetPage(
      name: RouteNameX.myDeductions,
      page: () => const MyDeductionsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyDeductionsController());
      }),
    ),
    GetPage(
      name: RouteNameX.mySponsorships,
      page: () => const MySponsorshipsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MySponsorshipsController());
      }),
    ),
    GetPage(
      name: RouteNameX.myShareLinks,
      page: () => const MyShariLinksView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyShareLinksController());
      }),
    ),
    GetPage(
      name: RouteNameX.paymentCards,
      page: () => const PaymentCardsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PaymentCardsController());
      }),
    ),
    //========================================================
    /// Info
    GetPage(
      name: RouteNameX.settings,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => SettingsController(), fenix: true);
      }),
    ),
    GetPage(
      name: RouteNameX.contactUs,
      page: () => const ContactUsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ContactUsController());
      }),
    ),
    GetPage(
      name: RouteNameX.about,
      page: () => const AboutView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AboutController());
      }),
    ),
    GetPage(
      name: RouteNameX.ourBank,
      page: () => const OurBankView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OurBankController());
      }),
    ),
    GetPage(
      name: RouteNameX.privacyPolicy,
      page: () => const PrivacyPolicyView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PrivacyPolicyController());
      }),
    ),
    GetPage(
      name: RouteNameX.termsConditions,
      page: () => const TermsConditionsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TermsConditionsController());
      }),
    ),
    //========================================================
    /// Store
    GetPage(
      name: RouteNameX.store,
      page: () => const StoreView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => StoreController());
      }),
    ),
    GetPage(
      name: RouteNameX.productDetails,
      page: () => const ProductDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ProductDetailsController());
      }),
    ),
    //========================================================
    /// Organization
    GetPage(
      name: RouteNameX.allOrganizations,
      page: () => const AllOrganizationsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AllOrganizationsController());
      }),
    ),
    GetPage(
      name: RouteNameX.organizationDetails,
      page: () => const OrganizationDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => OrganizationDetailsController());
      }),
    ),
    //========================================================
    /// Deduction
    GetPage(
      name: RouteNameX.allDeductions,
      page: () => const AllDeductionsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AllDeductionsController());
      }),
    ),
    GetPage(
      name: RouteNameX.deductionDetails,
      page: () => const DeductionDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DeductionDetailsController());
      }),
    ),
    //========================================================
    /// Gifting
    GetPage(
      name: RouteNameX.gift,
      page: () => const CreateGiftView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateGiftController());
      }),
    ),
    GetPage(
      name: RouteNameX.previewGift,
      page: () => const PreviewGiftView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => PreviewGiftController());
      }),
    ),
    //========================================================
    /// Cart
    GetPage(
      name: RouteNameX.cart,
      page: () => const CartView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CartController());
        Get.lazyPut(() => DeliveryAddressControllerX());
      }),
    ),
    //========================================================
    /// Sponsorships
    GetPage(
      name: RouteNameX.typesSponsorships,
      page: () => const TypesSponsorshipsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => TypesSponsorshipsController());
      }),
    ),
    GetPage(
      name: RouteNameX.allSponsorships,
      page: () => const AllSponsorshipsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AllSponsorshipsController());
      }),
    ),
    //========================================================
    /// Zakat
    GetPage(
      name: RouteNameX.zakat,
      page: () => const ZakatView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ZakatController());
        Get.lazyPut(() => DirectZakatPaymentControllerX());
      }),
    ),
    GetPage(
      name: RouteNameX.zakatDisbursements,
      page: () => const ZakatDisbursementsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ZakatDisbursementsController());
      }),
    ),
    GetPage(
      name: RouteNameX.zakatCalculator,
      page: () => const ZakatCalculatorView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => ZakatCalculatorController());
      }),
    ),
    //========================================================
    /// Donation
    GetPage(
      name: RouteNameX.donationDetails,
      page: () => const DonationDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => DonationDetailsController());
      }),
    ),
    //========================================================
    /// Campaign
    GetPage(
      name: RouteNameX.allCampaigns,
      page: () => const AllCampaignsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => AllCampaignsController());
      }),
    ),
    GetPage(
      name: RouteNameX.createCampaign,
      page: () => const CreateCampaignView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CreateCampaignController());
      }),
    ),
    GetPage(
      name: RouteNameX.campaignDetails,
      page: () => const CampaignDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => CampaignDetailsController());
      }),
    ),
    GetPage(
      name: RouteNameX.myCampaignDetails,
      page: () => const MyCampaignDetailsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MyCampaignDetailsController());
      }),
    ),
    //========================================================
    /// Template
    // GetPage(
    //    name: RouteNameX.,
    //    page: () => const View(),
    //    binding: BindingsBuilder(() {
    //      Get.lazyPut(
    //              () => Controller());
    //    })),
    //
  ];
}
