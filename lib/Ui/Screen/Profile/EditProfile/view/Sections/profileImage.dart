import 'package:ataa/UI/Animation/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Config/config.dart';
import '../../../../../Widget/widget.dart';
import '../../controller/Controller.dart';

class ProfileImageSectionX extends GetView<EditProfileController> {
  const ProfileImageSectionX({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.changeImage,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          /// Image
          GetBuilder<EditProfileController>(
            builder: (controller) => CircleAvatar(
              radius: 50,
              backgroundColor: ColorX.grey.shade50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ImageNetworkX(
                  imageUrl: controller.image != null
                      ? controller.image!.path
                      : controller.app.user.value!.imageUrl ?? "",
                  height: 100,
                  width: 100,
                  isFile: controller.image != null,
                  failed: Center(
                    child: TextX(
                      controller.app.user.value!.name[0],
                      style: TextStyleX.headerLarge,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ).fadeAnimation200,
          ),

          /// Upload Icon
          Positioned(
            left: -5.0,
            bottom: -5.0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 17,
              child: const Icon(
                Icons.upload_rounded,
                color: Colors.white,
                size: 22,
              ),
            ).fadeAnimation200,
          ),
        ],
      ),
    );
  }
}
