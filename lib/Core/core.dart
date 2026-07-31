library core;

import 'dart:async';
import 'dart:io';
import 'package:ataa/Core/Extension/convert/convert.dart';
import 'package:ataa/Ui/Screen/Auth/ContinueToAccount/view/view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:url_launcher/url_launcher.dart';
import '../Config/config.dart';
import '../Data/Model/General/generalPaymentMethodsSettings.dart';
import '../Data/Model/HomeElement/homeElementSettings.dart';
import '../Data/data.dart';
import '../UI/Screen/Auth/Login/view/loginView.dart';
import '../UI/Screen/Auth/SignUp/view/View.dart';
import '../UI/Widget/widget.dart';

import '../Ui/Screen/Donation/AllDonation/controller/Controller.dart';
import 'Controller/Cart/cartGeneralController.dart';
import 'Helper/http/http.dart';
import 'Service/deep_link_service.dart';
import 'Service/onesignalService.dart';
import 'Util/info.dart';
import 'package:share_plus/share_plus.dart';

part 'Controller/App/appController.dart';
part 'Util/function.dart';
part 'Helper/clipboard.dart';
part 'Helper/configApp.dart';
part 'Helper/catchError.dart';
part 'Helper/color.dart';
part 'Helper/devise.dart';
part 'Util/validate.dart';
part 'Util/creditCard.dart';
part 'Util/share.dart';
part 'Helper/httpOverrides.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this section }}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Controlling the internal processes of an application and general controllers,
/// containing all internal processors and general functions
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

class CoreX {
  static init() async {
    await InfoUtilX.init();
    await HttpX.init();
    await OnesignalServiceX.init();
    await DeepLinkServiceX.init();

    /// Here codes are added to configure anything within this section when the application starts
  }
}
