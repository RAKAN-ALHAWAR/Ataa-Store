part of '../../widget.dart';

class SearchBarX extends StatelessWidget {
  const SearchBarX(
      {super.key,
      required this.search,
      required this.onTapFilter,
      this.onSearching,
      this.filterIcon,
      this.hint='search',
      this.disabledSearch=false,
      this.isMargin=true,
      });
  final TextEditingController search;
  final Function onTapFilter;
  final bool disabledSearch;
  final bool isMargin;
  final String hint;
  final Function(String val)? onSearching;
  final IconData? filterIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMargin?const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
        vertical: 10,
      ):EdgeInsets.zero,
      child: Row(
        children: [
          Flexible(
            child: TextFieldX(
              disabled: disabledSearch,
              color: Theme.of(context).cardColor,
              icon: Icons.search_rounded,
              controller: search,
              hint: hint,
              textInputAction: TextInputAction.search,
              textInputType: TextInputType.text,
              onChanged: onSearching,
            ),
          ),
          const SizedBox(width: 10),
          ButtonX(
            onTap: onTapFilter,
            iconData: filterIcon??Iconsax.setting_5,
            width: StyleX.buttonHeight,
          )
        ],
      ),
    );
  }
}
