import 'package:ataa/Config/Translation/translation.dart';
import 'package:ataa/Data/Enum/recurring_status.dart';
import 'package:ataa/Ui/Animation/animation.dart';
import 'package:ataa/Ui/Widget/Basic/Utils/future_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' as intl;
import '../../../Config/config.dart';
import '../../../Core/Controller/DeductionHistory/deductionHistoryController.dart';
import '../../../Core/core.dart';
import '../../../Data/Enum/payment_status_status.dart';
import '../../../UI/Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// Show Deduction History
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

deductionHistorySheetX({required DeductionHistoryControllerX controller}) {
  //============================================================================
  // Content

  initializeDateFormatting(TranslationX.getLanguageCode, null);
  return bottomSheetX(
    title: "Subscription Details",
    isPaddingBottom: false,
    child: Container(
      constraints: const BoxConstraints(minHeight: 200),
      child: FutureBuilderX(
        future: controller.getData,
        child: (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MessageCardX(
              message: controller.myDeduction.deduction.recurring.name ==
                      RecurringStatusX.monthly.name
                  ? 'The amount will be automatically deducted on the first day of every calendar month.'
                      .tr
                  : '${'The amount is automatically deducted every'.tr} ${(controller.myDeduction.deduction.recurring.name == RecurringStatusX.daily.name) ? '' : '${controller.myDeduction.deduction.day?.tr ?? controller.myDeduction.deduction.dayLocalized} ${'of each week.'.tr}'}',
            ).fadeAnimation200,
            const SizedBox(height: 20),
            TextX(
              controller.myDeduction.deduction.name,
              style: TextStyleX.titleLarge,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ).fadeAnimation200,
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextX('${'Start Date'.tr}:'),
                ),
                TextX(
                  intl.DateFormat('yyyy/MM/dd').format(
                    controller.myDeduction.nextSubscriptionDiscountDate,
                  ),
                  style: TextStyleX.supTitleLarge,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  size: 14,
                ),
              ],
            ).fadeAnimation300,
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextX('${'State'.tr}:'),
                ),
                TextX(
                  controller.myDeduction.deduction.status
                      ? controller.myDeduction.deduction.isSubscribed
                          ? 'Active'
                          : 'Disabled'
                      : 'Expired',
                  style: TextStyleX.supTitleLarge,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  size: 14,
                ),
              ],
            ).paddingSymmetric(vertical: 7).fadeAnimation300,
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: TextX('${'The Amount'.tr}:'),
                ),
                TextX(
                  '${FunctionX.formatLargeNumber(controller.myDeduction.price)} ',
                  style: TextStyleX.supTitleLarge,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  size: 14,
                ),
                Icon(
                  IconX.sar,
                  size: 13,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                ),
                TextX(
                  " / ${controller.myDeduction.deduction.recurring.name.tr}",
                  style: TextStyleX.supTitleLarge,
                  color: Theme.of(Get.context!).colorScheme.secondary,
                  size: 14,
                ),
              ],
            ).fadeAnimation300,
            const SizedBox(height: 20),
            const TextX(
              'Transaction history',
              fontWeight: FontWeight.w700,
            ).fadeAnimation400,
            const SizedBox(height: 10),
            Container(
              constraints: const BoxConstraints(maxHeight: 400),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 10),
                children: [
                  for (var data in controller.history)
                    ContainerX(
                      isBorder: true,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  ImageNetworkX(
                                    imageUrl: data.paymentTransaction
                                            .paymentTransactionCard?.iconUrl ??
                                        '',
                                    height: 26,
                                    width: 26,
                                  ),
                                  TextX(
                                    data
                                            .paymentTransaction
                                            .paymentTransactionCard
                                            ?.paymentCardCompany ??
                                        '',
                                  ).marginSymmetric(horizontal: 8),
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: TextX(
                                      "****${data.paymentTransaction.paymentTransactionCard?.lastFourDigits}",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const SizedBox(width: 16),
                              ContainerX(
                                radius: StyleX.radiusSm,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                color: data.paymentTransaction.status ==
                                        PaymentStatusStatusX.paid
                                    ? ColorX.green.shade100
                                    : data.paymentTransaction.status ==
                                                PaymentStatusStatusX.failed ||
                                            data.paymentTransaction.status ==
                                                PaymentStatusStatusX.voided
                                        ? ColorX.red.shade100
                                        : Theme.of(Get.context!).dividerColor,
                                child: TextX(
                                  "${data.paymentTransaction.status.name[0].toUpperCase()}${data.paymentTransaction.status.name.substring(1).toLowerCase()}",
                                  color: data.paymentTransaction.status ==
                                          PaymentStatusStatusX.paid
                                      ? ColorX.green.shade800
                                      : data.paymentTransaction.status ==
                                                  PaymentStatusStatusX.failed ||
                                              data.paymentTransaction.status ==
                                                  PaymentStatusStatusX.voided
                                          ? ColorX.red.shade800
                                          : null,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextX(
                                    'The Amount',
                                    style: TextStyleX.supTitleMedium,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .secondary,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      TextX(
                                        FunctionX.formatLargeNumber(data.price),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(IconX.sar, size: 13),
                                    ],
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextX(
                                    'Payment date',
                                    style: TextStyleX.supTitleMedium,
                                    color: Theme.of(Get.context!)
                                        .colorScheme
                                        .secondary,
                                  ),
                                  const SizedBox(height: 6),
                                  if (data.paymentTransaction.createdAt != null)
                                    TextX(
                                      '${intl.DateFormat('yyyy/MM/dd').format(data.paymentTransaction.createdAt!)} | ${intl.DateFormat('hh:mm ').format(data.paymentTransaction.createdAt!)}${intl.DateFormat('a').format(data.paymentTransaction.createdAt!).tr}',
                                    ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ).fadeAnimation400,
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
