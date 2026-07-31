part of '../../widget.dart';

class PhoneFieldX extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final int countryCode;
  final bool? isRequired;
  final bool isShowCountryCode;
  final bool isDisableChangeCountryCode;
  final bool isActiveError;
  final Color? color;
  final Function(String countryCode) onChangeCountryCode;
  const PhoneFieldX({
    required this.controller,
    required this.onChangeCountryCode,
    this.label,
    this.isRequired,
    this.color,
    this.hint = "512345678",
    this.countryCode = 966,
    this.isShowCountryCode = true,
    this.isActiveError = false,
    this.isDisableChangeCountryCode = false,
    super.key,
  });

  @override
  State<PhoneFieldX> createState() => _PhoneFieldXState();
}

class _PhoneFieldXState extends State<PhoneFieldX> {
  late int _countryCode;

  @override
  void initState() {
    super.initState();
    _countryCode = widget.countryCode;
  }

  @override
  void didUpdateWidget(covariant PhoneFieldX oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countryCode != widget.countryCode) {
      _countryCode = widget.countryCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          LabelInputX(widget.label!, isRequired: widget.isRequired),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: InternationalPhoneNumberInput(
              height: StyleX.inputHeight,
              isActiveError: widget.isActiveError,
              controller: widget.controller,
              initCountry: _countryCode,
              betweenPadding: 5,
              isShowCountryCode: widget.isShowCountryCode,
              isDisableChangeCountryCode: widget.isDisableChangeCountryCode,
              onInputChanged: (phone) {
                widget.onChangeCountryCode(phone.dial_code);
                final nextCountryCode = int.tryParse(phone.dial_code);
                if (nextCountryCode != null && nextCountryCode != _countryCode) {
                  setState(() {
                    _countryCode = nextCountryCode;
                  });
                }
              },
              dialogConfig: DialogConfig(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                searchBoxBackgroundColor: Theme.of(context).cardTheme.color!,
                countryItemHeight: 46,
                topBarColor: ColorX.grey.shade800,
                selectedItemColor: Theme.of(context).cardTheme.color!,
                textStyle: TextStyleX.titleMedium.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
                searchBoxTextStyle: TextStyleX.titleSmall,
                titleStyle: TextStyleX.titleLarge,
                title: "Select the country code".tr,
                flatFlag: true,
                itemFlagSize: 26,
                searchBoxIconColor: Theme.of(context).colorScheme.secondary,
                searchBoxRadius: StyleX.radius,
                searchHintText: "Search by name...".tr,
                searchBoxHintStyle: TextStyleX.titleSmall.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              countryConfig: CountryConfig(
                noFlag: false,
                flatFlag: true,
                flagSize: 22,
                textStyle: TextStyleX.titleMedium.copyWith(
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              validate: (value) => ValidateX.phone(
                    value,
                    countryCode: _countryCode,
                    isCountryCodeLocked: widget.isDisableChangeCountryCode,
                  ),
              phoneConfig: PhoneConfig(
                color: widget.color,
                focusedColor: Colors.transparent,
                enabledColor: Colors.transparent,
                labelStyle: null,
                labelText: null,
                floatingLabelStyle: null,
                focusNode: null,
                radius: 0,
                borderWidth: 0,
                hintText: widget.hint,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.transparent, width: 0),
                ),
                autoFocus: false,
                showCursor: false,
                errorStyle: TextStyleX.supTitleMedium.copyWith(
                  color: ColorX.danger.shade500,
                ),
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                textStyle: TextStyleX.titleSmall,
                hintStyle: TextStyleX.titleSmall.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
