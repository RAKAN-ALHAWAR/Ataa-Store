import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/SelectedOptions/donationSelectionController.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../GeneralState/empty.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View donation projects to choose one of them with a search bar.
///
/// Two data sources share this sheet (see DonationSelectionSourceX):
/// - campaign: the full campaign-eligible list is loaded once and searched
///   instantly on-device (the endpoint ignores server search), so typing never
///   triggers a reload or a skeleton flash.
/// - allDonations: the classic paginated list with server-side search.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

donationSelectionSheetX({
  required DonationSelectionControllerX controller,
}) {
  if (controller.isCampaignSource) {
    return _campaignSheet(controller);
  }
  return _allDonationsSheet(controller);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Campaign source: instant local search over a list loaded once.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

_campaignSheet(DonationSelectionControllerX controller) {
  /// Fresh state every time the sheet opens.
  controller.search.text = "";
  controller.query.value = "";
  controller.loadCampaignProjects();

  return bottomSheetX(
    isPaddingBottom: false,
    title: "Choose a donation opportunity",
    child: SizedBox(
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.app.generalSettings.isActiveDonationSearch)
            TextFieldX(
              color: Get.theme.cardColor,
              controller: controller.search,
              hint: "Search by project name",
              icon: Icons.search,
              onChanged: (value) => controller.query.value = value,
            ).fadeAnimation200,
          Expanded(
            child: Obx(() {
              if (controller.isCampaignLoading.value) {
                return ListView(
                  padding: const EdgeInsets.only(top: 6, bottom: 10),
                  children: [
                    for (int i = 0; i < 12; i++)
                      const ShimmerAnimationX(
                        height: StyleX.inputHeight,
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                  ],
                );
              }

              if (controller.campaignError.value != null) {
                return EmptyView(message: controller.campaignError.value!);
              }

              final List<DonationX> results = controller.campaignResults;
              if (results.isEmpty) {
                return EmptyView(
                  message: controller.query.value.trim().isEmpty
                      ? "There are no donation opportunities available."
                      : "There are no search results.\nTry searching for something else",
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 6, bottom: 10),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final DonationX data = results[index];
                  return RadioButtonX<String?>(
                    groupValue: controller.donationSelected.value?.id,
                    value: data.id,
                    onChanged: (_) async => await controller.onChange(data),
                    label: data.donationBasic.name,
                  );
                },
              );
            }),
          ),
        ],
      ),
    ),
  );
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// All-donations source: classic paginated list with server-side search.
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

_allDonationsSheet(DonationSelectionControllerX controller) {
  return bottomSheetX(
    isPaddingBottom: false,
    title: "Choose a donation opportunity",
    child: SizedBox(
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (controller.app.generalSettings.isActiveDonationSearch)
            TextFieldX(
              color: Get.theme.cardColor,
              controller: controller.search,
              hint: "Search by project name",
              icon: Icons.search,
            ).fadeAnimation200,
          ScrollRefreshLoadMoreX<DonationX>(
            fetchData: controller.getData,
            spaceBetweenHeaderAndContent: 4,
            initLoading: Column(
              children: [
                for (int i = 0; i < 12; i++)
                  const ShimmerAnimationX(
                    height: StyleX.inputHeight,
                    margin: EdgeInsets.only(bottom: 10),
                  )
              ],
            ),
            searchQueryController: controller.search,
            padding: const EdgeInsets.only(
              top: 6,
              bottom: 10,
            ),
            emptyMessage: "There are no search results.\nTry searching for something else",
            itemBuilder: (data, index) {
              return RadioButtonX<String?>(
                groupValue: controller.donationSelected.value?.id,
                value: data.id,
                onChanged: (_)async=>await controller.onChange(data),
                label: data.donationBasic.name,
              ).fadeAnimation300;
            },
          ),
        ],
      ),
    ),
  );
}
