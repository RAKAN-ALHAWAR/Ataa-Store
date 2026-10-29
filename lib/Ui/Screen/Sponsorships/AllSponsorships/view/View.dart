import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Config/config.dart';
import '../../../../../Ui/Animation/animation.dart';
import '../../../../GeneralState/empty.dart';
import '../../../../GeneralState/error.dart';
import '../../../../Widget/widget.dart';
import '../controller/Controller.dart';
import 'Sections/header.dart';
import 'Sections/loading.dart';

class AllSponsorshipsView extends GetView<AllSponsorshipsController> {
  const AllSponsorshipsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarX(
        title: "Sponsorships",
        actions: [CartIconButtonsX()],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: controller.getData(),
          builder: (context, snapshot) {
            /// Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingSectionX();
            }

            /// Error State
            if (snapshot.hasError) {
              return ErrorView(
                error: snapshot.error.toString(),
              );
            }

            /// Main Content
            return Obx(
              () => AbsorbPointer(
                absorbing: controller.isLoading.value,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title & Subtitle
                      const HeaderSectionX(),

                      /// Search Bar
                      if (controller.sponsorships.isNotEmpty)
                      SearchBarX(
                        search: controller.search,
                        onTapFilter: controller.onFilter,
                        onSearching: controller.onSearching,
                      ).fadeAnimation200,

                      /// Cards
                      Column(
                        children: [

                          /// if Empty Sponsorships on Search
                          if (controller.sponsorshipResults.isEmpty)
                            const EmptyView(
                              message:
                                  "There are no search results.\nTry searching for something else",
                            ),

                          /// Sponsorships Result
                          if (controller.sponsorshipResults.isNotEmpty)
                            GetBuilder<AllSponsorshipsController>(
                              builder: (controller) => ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: StyleX.vPaddingApp,
                                  left: StyleX.hPaddingApp,
                                  right: StyleX.hPaddingApp,
                                ),
                                itemCount: controller.sponsorshipResults.length,
                                itemBuilder: (context, index) => SponsorshipCardX(
                                  sponsorship: controller.sponsorshipResults[index],
                                  onAddToCart: controller.onAddToCart,
                                  onDonation: controller.onDonation,
                                  payDonationButtonState: controller
                                      .donationButtonsState[controller.sponsorshipResults[index].id]!,
                                  addToCartButtonState: controller
                                      .addToCartButtonsState[controller.sponsorshipResults[index].id]!,
                                ).fadeAnimation300,
                              )
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
