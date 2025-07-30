part of '../../widget.dart';

class OrderCardX extends StatelessWidget {
  const OrderCardX({
    super.key,
    required this.order,
    required this.products,
  });
  final OrderX order;
  final List<OrderProductX> products;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return AccordionX(
    //   title: "${"Order number".tr} : ${order.numOrder}",
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       for(int i=0;i<products.length;i++)
    //       InkWell(
    //         onTap: () => Get.toNamed(RouteNameX.productDetails,arguments: products[i].productID),
    //         child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //               child:  Row(
    //                 children: [
    //                   Flexible(
    //                     child: Row(
    //                       children: [
    //                         ImageNetworkX(
    //                           imageUrl: products[i].imageUrl,
    //                           height: 65,
    //                           width: 65,
    //                           radius: StyleX.radiusSm,
    //                         ),
    //                         const SizedBox(
    //                           width: 16,
    //                         ),
    //                         Flexible(
    //                           child: TextX(
    //                             products[i].name,
    //                             style: TextStyleX.titleSmall,
    //                             fontWeight: FontWeight.w700,
    //                             maxLines: 2,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   const SizedBox(width: 25),
    //                   TextX(
    //                     "${FunctionX.formatLargeNumber(products[i].price)} ${"SAR".tr}",
    //                     style: TextStyleX.supTitleLarge,
    //                     fontWeight: FontWeight.w700,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //               Divider(
    //                 height: 1,
    //                 color: Theme.of(context).dividerColor,
    //               )
    //           ],
    //         ).fadeAnimationX(100*i+1),
    //       ),
    //       const SizedBox(height: 6),
    //       ContainerX(
    //         color: Theme.of(context).cardTheme.color,
    //         padding: EdgeInsets.zero,
    //         margin: const EdgeInsets.all(12),
    //         child: Column(children: [
    //           ActivityDataRowX(
    //             title: "State",
    //             data: order.state,
    //           ).fadeAnimation300,
    //           ActivityDataRowX(
    //             title: "Order date",
    //             data: order.orderDate,
    //           ).fadeAnimation300,
    //           ActivityDataRowX(
    //             title: "Payment method",
    //             data: order.paymentMethod,
    //           ).fadeAnimation400,
    //           ActivityDataRowX(
    //             title: "Order invoice",
    //             dataWidget: InkWell(
    //               onTap: () {
    //                 /// TODO: add code to download order invoice
    //                 ToastX.success(message: "The file was downloaded successfully");
    //               },
    //               child: Row(
    //                 children: [
    //                   TextX(
    //                     "Download the invoice",
    //                     style: TextStyleX.supTitleMedium,
    //                     fontWeight: FontWeight.w600,
    //                     color: Theme.of(context).primaryColor,
    //                   ),
    //                   const SizedBox(width: 8),
    //                   Icon(
    //                     Icons.download_rounded,
    //                     size: 22,
    //                     color: Theme.of(context).primaryColor,
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ).fadeAnimation400,
    //           ActivityDataRowX(
    //             isLine: false,
    //             title: "Aramex invoice",
    //             dataWidget: InkWell(
    //               onTap: () {
    //                 /// TODO: add code to download Aramex invoice
    //                 ToastX.success(message: "The file was downloaded successfully");
    //               },
    //               child: Row(
    //                 children: [
    //                   TextX(
    //                     "Download the invoice",
    //                     style: TextStyleX.supTitleMedium,
    //                     fontWeight: FontWeight.w600,
    //                     color: Theme.of(context).primaryColor,
    //                   ),
    //                   const SizedBox(width: 8),
    //                   Icon(
    //                     Icons.download_rounded,
    //                     size: 22,
    //                     color: Theme.of(context).primaryColor,
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ).fadeAnimation500,
    //         ],),
    //       ).fadeAnimation300,
    //       ContainerX(
    //         color: Theme.of(context).cardTheme.color,
    //         padding: const EdgeInsets.all(12),
    //         margin: const EdgeInsets.symmetric(horizontal: 12),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             TextX(
    //               "Total demand",
    //               style: TextStyleX.supTitleLarge,
    //             ),
    //               TextX(
    //                 "${FunctionX.formatLargeNumber(order.totalPrice)} ${"SAR".tr}",
    //                 fontWeight: FontWeight.w600,
    //               ),
    //           ],
    //         ),
    //       ).fadeAnimation600,
    //       const SizedBox(height: 12),
    //     ],
    //   ),
    // );
  }
}
