part of '../../widget.dart';

class StatisticGroupCardX extends StatefulWidget {
  const StatisticGroupCardX({
    super.key,
    required this.child,
    required this.title, required this.linkTitle, required this.linkTo,
  });
  final String title;
  final String linkTitle;
  final String linkTo;
  final Widget child;

  @override
  State<StatisticGroupCardX> createState() => _StatisticGroupCardXState();
}

class _StatisticGroupCardXState extends State<StatisticGroupCardX> {
  bool isOpen=false;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isOpen=!isOpen;
              });
            },
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextX(widget.title, style: TextStyleX.titleLarge),
                  Icon(isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                ],
              ),
            ),
          ),
          if(isOpen)
            Divider(height: 1,color: Theme.of(context).dividerColor,),
          SizedBox(
            child: isOpen
                ? Padding(
              padding: const EdgeInsets.all(16),
                  child: widget.child
                )
                : null,
          ).sizeAnimation300,
          if(!context.isDarkMode)
          Divider(height: 1, color: ColorX.primary.shade100),
          GestureDetector(
            onTap: ()=>Get.toNamed(widget.linkTo),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: context.isDarkMode?ColorX.primary.shade500:Theme.of(context).colorScheme.onPrimary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextX(widget.linkTitle,
                      color:context.isDarkMode?Colors.white:ColorX.primary,
                  fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(width: 16),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Icon(DeviseX.isLTR?Icons.arrow_forward_ios_rounded:Icons.arrow_back_ios_rounded,
                        color: context.isDarkMode?Colors.white:ColorX.primary,
                    size: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
