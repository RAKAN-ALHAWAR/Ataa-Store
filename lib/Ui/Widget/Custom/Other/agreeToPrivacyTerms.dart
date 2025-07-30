part of '../../widget.dart';

class AgreeToPrivacyTermsX extends StatelessWidget {
  const AgreeToPrivacyTermsX({super.key, required this.agreedTerms, required this.onChangeAgreedTerms});
   final bool agreedTerms;
   final Function(bool? val) onChangeAgreedTerms;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CheckBoxX(
          value: agreedTerms,
          onChanged: onChangeAgreedTerms,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: RichText(
              text: TextSpan(
                text: "${'I agree to'.tr} ",
                style: TextStyleX.supTitleLarge.copyWith(color: Get.theme.colorScheme.secondary,fontFamily: FontX.fontFamily),
                children: <TextSpan>[
                  TextSpan(
                      text: "${'terms & Conditions'.tr} ",
                      style: TextStyleX.supTitleLarge
                          .copyWith(color: Theme.of(context).primaryColor,fontFamily: FontX.fontFamily,fontWeight: FontWeight.w600),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.toNamed(RouteNameX.termsConditions);
                        }),
                  TextSpan(
                      text: '${'and'.tr} ',
                      style:
                          TextStyleX.supTitleLarge.copyWith(color: Get.iconColor,fontFamily: FontX.fontFamily,),),
                  TextSpan(
                    text: 'Privacy Policy'.tr,
                    style: TextStyleX.supTitleLarge
                        .copyWith(color: Theme.of(context).primaryColor,fontFamily: FontX.fontFamily,fontWeight: FontWeight.w600),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(RouteNameX.privacyPolicy);
                      },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
