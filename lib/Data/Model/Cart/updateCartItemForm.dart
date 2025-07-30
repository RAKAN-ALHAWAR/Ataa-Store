import '../../data.dart';

class UpdateCartItemFormX {
  UpdateCartItemFormX({
    required this.id,
    required this.price,
    required this.quantity,
    this.sharesQuantity,
    this.donationOpenPackageId,
    this.donationSharesPackageId,
    this.donationDeductionPackageId,
  });

  String id;
  int price;
  int quantity;
  int? sharesQuantity;
  String? donationOpenPackageId;
  String? donationSharesPackageId;
  String? donationDeductionPackageId;

  Map<String, dynamic> toJson() {
    return {
      NameX.id: id,
      NameX.price: price,
      NameX.quantity: quantity,
      if(sharesQuantity!=null || donationOpenPackageId!=null || donationSharesPackageId!=null || donationDeductionPackageId!=null)
      NameX.donationData:{
        if(sharesQuantity!=null)
         NameX.sharesQuantity: sharesQuantity,
        if(donationOpenPackageId!=null)
          NameX.donationOpenPackageId: donationOpenPackageId,
        if(donationSharesPackageId!=null)
          NameX.donationSharesPackageId: donationSharesPackageId,
        if(donationDeductionPackageId!=null)
          NameX.donationDeductionPackageId: donationDeductionPackageId,
      }
    };
  }
}