library data;

import 'dart:async';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Core/Service/firebaseRemoteConfigService.dart';
import 'package:ataa/Core/core.dart';
import 'package:ataa/Data/Enum/model_type_status.dart';
import 'package:ataa/Data/Enum/rate_type_status.dart';
import 'package:ataa/Data/Model/Basic/data_source_param.dart';
import 'package:ataa/Data/Model/Deduction/Order/deductionOrder.dart';
import 'package:ataa/Data/Model/Gift/Order/giftOrder.dart';
import 'package:ataa/Data/Model/PaymentTransaction/paymentTransaction.dart';
import 'package:ataa/Data/Model/PaymentTransaction/paymentTransactionItem.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../Config/Translation/translation.dart';
import '../Config/config.dart';

import '../Core/Error/error.dart';
import '../Core/Helper/model/model.dart';
import 'Enum/ads_section_type_status.dart';
import 'Enum/campaign_status.dart';
import 'Enum/linkable_type_status.dart';
import 'Enum/metal_status.dart';
import 'Enum/payment_card_status_status.dart';
import 'Enum/payment_status_status.dart';
import 'Model/Campaign/campaignDonation.dart';
import 'Model/Campaign/campaignStatistics.dart';
import 'Model/Campaign/createCampaignForm.dart';
import 'Model/Cart/MiniCart.dart';
import 'Model/Cart/cart.dart';
import 'Model/Cart/updateCartItemForm.dart';
import 'Model/ContactUs/contactUs.dart';
import 'Model/ContactUs/contactUsSocialMedia.dart';
import 'Model/Deduction/deduction.dart';
import 'Model/Donation/Order/donationOrder.dart';
import 'Model/Donation/Order/donationOrderForm.dart';
import 'Model/Donation/donation.dart';
import 'Model/General/generalPaymentMethodsSettings.dart';
import 'Model/Gift/GiftMessage/giftMessage.dart';
import 'Model/Gift/Subclass/giftCategory.dart';
import 'Model/Gift/gift.dart';
import 'Model/HomeElement/homeElementSettings.dart';
import 'Model/Other/adSection.dart';
import 'Model/Other/notification.dart';
import 'Model/PaymentCard/paymentCardForm.dart';
import 'Model/PaymentTransaction/paymentTransactionForm.dart';
import 'Model/ShareLink/miniShareLink.dart';
import 'Model/ShareLink/shareLink.dart';
import 'Model/Statistics/myCampaignStatistics.dart';
import 'Model/Statistics/deductionStatistics.dart';
import 'Model/Statistics/donationStatistics.dart';
import 'Model/Statistics/giftStatistics.dart';
import 'Model/Statistics/orderStatistics.dart';
import 'Model/Statistics/shareLinkStatistics.dart';
import 'Model/Statistics/sponsorshipStatistics.dart';
import 'Model/ZakatCalculation/metalPrice.dart';
import 'Model/ZakatCalculation/zakatCalculationForm.dart';
import 'Remote/remote_data.dart';

part 'Constant/constant.dart';
part 'Enum/enum.dart';
part 'Constant/name.dart';
part 'Database/database.dart';
part 'Local/Config/defaultData.dart';
part 'Local/Config/localKey.dart';
part 'Local/localData.dart';
part 'Local/Storage/hive.dart';
part 'Model/User/user.dart';
part 'Model/Auth/otp.dart';
part 'Model/Basic/settings.dart';
part 'API/config.dart';
part "Model/Delivery/deliveryLocation.dart";
part 'Model/Product/orderProduct.dart';
part 'Model/Order/order.dart';
part 'Model/Basic/rootPage.dart';
part "Database/Config/DBEndPoint.dart";
part 'Model/Bank/bankAccount.dart';
part 'Model/Bank/bank.dart';
part 'Model/Other/ads.dart';
part 'Model/Other/organization.dart';
part 'Model/Other/product.dart';
part 'Model/Other/partner.dart';
part 'API/keys.dart';
part 'Model/Other/sponsorship.dart';
part 'Model/PaymentCard/paymentCard.dart';
part 'Model/Campaign/campaign.dart';
part 'Model/General/generalSettings.dart';
part 'Model/Basic/scrollRefreshLoadMoreParameters.dart';
part 'Model/Other/page.dart';
part 'Model/General/generalStatistic.dart';
part 'Model/Other/testimonial.dart';
part 'Model/Other/country.dart';


// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Control all types of data within the application, including static data,
/// managing data stored on the device, database connections, data models, etc.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class DataX {
  static init() async {
    /// Formatting and retrieving data stored on the device
    await LocalDataX.init();

    /// Configure database connections
    await DatabaseX.init();
  }
}
