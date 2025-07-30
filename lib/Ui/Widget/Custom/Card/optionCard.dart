part of '../../widget.dart';

class OptionCardX extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function()? onTap;
  final bool isDanger;
  final Widget? child;
  final bool isBottomLine;

  const OptionCardX({
    required this.title,
    required this.icon,
    this.onTap,
    this.child,
    this.isDanger = false,
    this.isBottomLine = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.only(
                      right: DeviseX.isLTR ? 15.0 : 0.0,
                      left: DeviseX.isLTR ? 0 : 19),
                  decoration: BoxDecoration(
                    color: isDanger
                        ? Theme.of(context).colorScheme.onError
                        : Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: isDanger
                          ? Theme.of(context).colorScheme.error
                          : context.isDarkMode
                              ? ColorX.grey.shade200
                              : ColorX.grey.shade700,
                      size: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: TextX(
                    title,
                    color: isDanger ? ColorX.danger : null,
                  ),
                ),
                child != null
                    ? child!
                    : Container(
                        margin: EdgeInsets.only(
                            left: DeviseX.isLTR ? 24 : 0,
                            right: DeviseX.isLTR ? 0 : 24),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color:
                              isDanger ? ColorX.danger : ColorX.grey.shade400,
                          size: 16,
                        ),
                      ),
              ],
            ),
          ),
        ),
        if (isBottomLine)
          Container(height: 1, color: Theme.of(context).dividerColor),
      ],
    );
  }
}
