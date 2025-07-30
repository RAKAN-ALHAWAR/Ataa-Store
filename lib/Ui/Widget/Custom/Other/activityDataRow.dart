part of '../../widget.dart';

class ActivityDataRowX extends StatelessWidget {
  const ActivityDataRowX(
      {super.key,
      this.isLine = true,
      required this.title,
      this.data = '',
      this.dataWidget});
  final bool isLine;
  final String title;
  final String data;
  final Widget? dataWidget;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextX(
                title,
                color: context.isDarkMode?ColorX.grey.shade400:ColorX.grey.shade500,
              ),
              const SizedBox(width: 40,),
              if (dataWidget == null)
                Flexible(
                  child: TextX(
                    data,
                    fontWeight: FontWeight.w700,
                    maxLines: 1,
                  ),
                ),
              if (dataWidget != null) dataWidget!,
            ],
          ),
        ),
        if (isLine)
          Divider(
            height: 1,
            color: Theme.of(context).dividerColor,
          )
      ],
    );
  }
}
