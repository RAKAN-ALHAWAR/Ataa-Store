import 'dart:async';
import 'package:ataa/Data/data.dart';
import 'package:get/get.dart';
import '../../../Data/Enum/linkable_type_status.dart';
import '../../../Data/Model/ShareLink/miniShareLink.dart';
import '../../core.dart';

class ShareControllerX extends GetxController {
  //============================================================================
  // Injection of required controls

  AppControllerX app = Get.find();

  //============================================================================
  // Variables

  late String id;
  late int code;
  late LinkableTypeStatusX type;

  String shareUrl='';

  //============================================================================
  // Functions

  /// Get the share link
  shareLink()async{
    try{
      /// If the user is logged in, a special link will be created for him
     if(app.isLogin.value){
       shareUrl = await createCustomLink();
     }else{
       shareUrl = createLink();
     }
    }catch(e){
      return Future.error(e);
    }
  }

  String createLink(){
    switch (type) {
      case LinkableTypeStatusX.donation:
        return 'https://store.edialoguec.org.sa/donationsDetails/$code';
      case LinkableTypeStatusX.deduction:
        return 'https://store.edialoguec.org.sa/DeductionsDetails/$code';
      case LinkableTypeStatusX.org:
        return 'https://store.edialoguec.org.sa/ProgramsDetail/$code';
      case LinkableTypeStatusX.campaign:
        return 'https://store.edialoguec.org.sa/donation-campaigns/$code';
    }
  }

  Future<String> createCustomLink()async{
    try{
      MiniShareLinkX link =await DatabaseX.createShareLink(linkableType: type, modelId: id);
      return link.affiliateLink;
    }catch(e){
      return Future.error(e);
    }
  }
}