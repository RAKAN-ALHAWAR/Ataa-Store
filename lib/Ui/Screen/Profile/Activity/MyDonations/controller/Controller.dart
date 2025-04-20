import 'package:get/get.dart';
import '../../../../../../Data/Model/PaymentTransaction/paymentTransactionItem.dart';
import '../../../../../../Data/data.dart';

class MyDonationsController extends GetxController {
  //============================================================================
  // Variables

  bool isShowMore = false;

  //============================================================================
  // Functions

  Future<List<PaymentTransactionItemX<OrderX>>> getData(ScrollRefreshLoadMoreParametersX data) async {
    var x = await DatabaseX.getAllMyRecords<OrderX>(
      page: data.page,
      perPage: data.perPage,
    );
    return x;
  }

  onShowMore(){
    isShowMore=true;
    update();
  }
}
