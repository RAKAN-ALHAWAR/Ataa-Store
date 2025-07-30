part of '../../widget.dart';

class MyDonationCardX extends StatelessWidget {
  const MyDonationCardX({
    super.key,
    required this.myDonation,
  });
  final PaymentTransactionItemX myDonation;

  @override
  Widget build(BuildContext context) {
    return AccordionX(
      title: '${myDonation.type.name.tr} - ${myDonation.name}',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActivityDataRowX(
            title: "State",
            data: myDonation.paymentTransaction.statusLocalized ??
                myDonation.paymentTransaction.status.name,
          ).fadeAnimation100,
          ActivityDataRowX(
            title: "Donation amount",
            dataWidget: Row(children: [
              TextX(
                FunctionX.formatLargeNumber(myDonation.price),
                fontWeight: FontWeight.w700,
                maxLines: 1,
              ),
              const SizedBox(width: 6),
              const Icon(IconX.sar,size: 15),
            ],),
          ).fadeAnimation200,
          ActivityDataRowX(
            title: "Payment method",
            data: myDonation.paymentTransaction.paymentMethodLocalized ??
                myDonation.paymentTransaction.paymentMethod.name,
          ).fadeAnimation200,
          if(myDonation.paymentTransaction.createdAt!=null)
          ActivityDataRowX(
            title: "Donation date",
            data: intl.DateFormat('dd/MM/yyyy')
                .format(myDonation.paymentTransaction.createdAt!),
          ).fadeAnimation300,
          if (myDonation.paymentTransaction.receiptUrl != null)
            InkWell(
              onTap: () => Get.toNamed(RouteNameX.receiptPreview,
                  arguments: myDonation.paymentTransaction.receiptUrl),
              child: ActivityDataRowX(
                title: "Donation receipt",
                dataWidget: Row(
                  children: [
                    TextX(
                      "Show receipt",
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.image_outlined,
                      size: 22,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ).fadeAnimation400,
            ),
          // ActivityDataRowX(
          //   isLine: false,
          //   title: "Project report",
          //   dataWidget: InkWell(
          //     onTap: () {
          //       /// TODO: add code to download project report
          //       ToastX.success(message: "The file was downloaded successfully");
          //     },
          //     child: Row(
          //       children: [
          //         TextX(
          //           "Download the report",
          //           fontWeight: FontWeight.w600,
          //           color: Theme.of(context).primaryColor,
          //         ),
          //         const SizedBox(width: 8),
          //         Icon(
          //           Icons.download_rounded,
          //           size: 22,
          //           color: Theme.of(context).primaryColor,
          //         )
          //       ],
          //     ),
          //   ),
          // ).fadeAnimation400,
        ],
      ),
    );
  }
}
