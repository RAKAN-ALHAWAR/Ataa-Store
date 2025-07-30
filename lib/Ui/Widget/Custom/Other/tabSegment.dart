part of '../../widget.dart';

class TabSegmentX extends StatelessWidget {
  const TabSegmentX({required this.controller,required this.tabs,this.width=double.maxFinite,super.key});
  final ValueNotifier<int> controller;
  final Map<int, String> tabs;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(StyleX.radius),border: Border.all(width: 1,color: Theme.of(context).dividerColor)),
      child: AdvancedSegment<int,String>(
        controller: controller,
        segments: tabs,
        activeStyle: TextStyleX.titleSmall.copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.w600,fontFamily: FontX.fontFamily),
        inactiveStyle: TextStyleX.titleSmall.copyWith(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w600,fontFamily: FontX.fontFamily),
        backgroundColor: context.isDarkMode?Theme.of(context).cardColor:ColorX.grey.shade100,
        sliderColor: context.isDarkMode?ColorX.grey.shade700:Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(StyleX.radius)),
        itemPadding: const EdgeInsets.symmetric(
          horizontal: 4,
        ),
        sliderOffset: 3,
        shadow: const [],
      ),
    );
  }
}
