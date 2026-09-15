import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Core/Controller/Create/addShareLinkController.dart';
import '../../../../../../Data/Model/ShareLink/shareLink.dart';
import '../../../../../../Data/data.dart';
import '../../../../../../UI/Widget/widget.dart';
import '../../../../../ScreenSheet/Create/AddShareLink/addShareLinkSheet.dart';
import '../../../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';

class MyShareLinksController extends GetxController {
  //============================================================================
  // Injection of required controls

  final AddShareLinkControllerX addShareLinkController = Get.put(AddShareLinkControllerX());

  //============================================================================
  // Variables

  bool isLoading = false;
  bool isShowMore = false;
  GlobalKey<ScrollRefreshLoadMoreXState> scrollRefreshLoadMoreKey = GlobalKey<ScrollRefreshLoadMoreXState>();


  //============================================================================
  // Functions

  Future<List<ShareLinkX>> getData(ScrollRefreshLoadMoreParametersX data) async {
    return await DatabaseX.getAllMyShareLinks(
      page: data.page,
      perPage: data.perPage,
    );
  }

  onShowMore(){
    isShowMore=true;
    update();
  }

  onAddShareLink() async {
    if (!isLoading) {
      isLoading = true;
      update();
      try {
        /// A sheet is displayed below for entering data and creating a new share link
        var newLink = await addShareLinkSheetX(controller: addShareLinkController);
        /// It is checked whether a share link has been created or not
        if(newLink!=null){
          /// Add to share links list
          scrollRefreshLoadMoreKey.currentState?.refresh();
        }
      } catch (e) {
        ToastX.error(message: e.toString());
      }
      isLoading = false;
      update();
    }
  }
}