import 'package:ataa/Ui/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Config/config.dart';
import '../../../../Core/Controller/SelectedOptions/donationSelectionController.dart';
import '../../../../Data/Model/Donation/donation.dart';
import '../../../Widget/Basic/Other/scrollRefreshLoadMore.dart';
import '../../../Widget/widget.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~{{ Why this bottom sheet }}~~~~~~~~~~~~~~~~~~~~~~~~~~~
/// View donation projects to choose one of them with a search bar
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

donationSelectionSheetX({
  required DonationSelectionControllerX controller,
}) {
  return bottomSheetX(
    isPaddingBottom: false,
    title: "Choose a donation opportunity",
    child: SizedBox(
      height: 400,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(controller.app.generalSettings.isActiveDonationSearch)
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
