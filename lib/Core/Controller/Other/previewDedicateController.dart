import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/Model/Gift/GiftMessage/giftMessage.dart';
import '../../../Data/Model/Gift/Subclass/giftCardFormByGender.dart';
import '../../../Data/data.dart';
import '../../../Ui/Widget/widget.dart';

class PreviewGiftCardControllerX  extends GetxController {
  //============================================================================
  // Variables

  late String nameTo;
  late String nameFrom;
  late String amount;
  late Color color;
  late bool isShowAmount;
  late String orgName;
  late GiftCardFormByGenderX giftCardFormByGender;


  RxBool isCard = true.obs;
  final previewVia = ValueNotifier(1);
  late GiftMessageX message;
  bool isGetMessage = false;

  //============================================================================
  // Functions

  Future<void> getDate()async{
    if(!isGetMessage) {
      message = await DatabaseX.getGiftMessageTemplate();
      isGetMessage=true;
    }
  }

  /// Move the user to the gift link
  onTapUrl()async{
    try{
      String url = message.variables.firstWhereOrNull((e) => e.name==NameX.giftUrl,)?.example??'';
      if(url.isNotEmpty) {
        await launchUrl(Uri.parse(url));
      }
    }catch(e){
      ToastX.error(message: "There is an error the link cannot be opened.\nTry again");
    }
  }

  String getMessageString(){
    String result = message.content;
    final Map<String, String?> values = {
      NameX.recipientName: nameTo,
      NameX.donorName: nameFrom,
      NameX.donationAmount: amount,
      NameX.organizationName: orgName,
    };
    for (var variable in message.variables) {
      final value = values[variable.name] ?? variable.example;
      result = result.replaceAll('{${variable.name}}', value);
    }

    return result;
  }

  //============================================================================
  // Initialization

  @override
  void onInit() {
    super.onInit();

    /// listener if change tap is image or massage
    previewVia.addListener(() {
      isCard.value = previewVia.value == 1;
    });
  }
}