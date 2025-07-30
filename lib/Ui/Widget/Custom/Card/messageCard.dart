part of '../../widget.dart';

class MessageCardX extends StatelessWidget {
  const MessageCardX({
    super.key,
    this.message,
    this.description,
    this.maxLine = 2,
    this.child,
    this.icon,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.isError = false,
  });
  final String? message;
  final String? description;
  final int maxLine;
  final Widget? child;
  final IconData? icon;
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: double.maxFinite,
      color: backgroundColor ??
          (isError
              ? context.isDarkMode
                  ? ColorX.danger.shade900.withValues(alpha: 0.05)
                  : Theme.of(context).colorScheme.onError
              : Theme.of(context).colorScheme.onPrimary),
      isBorder: borderColor != null || isError,
      borderColor: borderColor ??
          (isError
              ? context.isDarkMode
                  ? ColorX.danger.shade400
                  : ColorX.danger.shade300
              : ColorX.primary.shade300),
      child: Row(
        crossAxisAlignment: description != null &&
                description!.isNotEmpty &&
                message != null &&
                message!.isNotEmpty
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(
            icon ??
                (isError ? Icons.warning_amber_rounded : Icons.info_rounded),
            color: color ??
                (isError
                    ? Theme.of(context).colorScheme.error
                    : ColorX.primary),
            size: 28,
          ),
          const SizedBox(width: 10),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (message != null && message!.isNotEmpty)
                TextX(
                  message!,
                  maxLines: maxLine,
                  style: description != null && description!.isNotEmpty
                      ? TextStyleX.titleMedium
                      : TextStyleX.titleSmall,
                  fontWeight: description != null && description!.isNotEmpty
                      ? FontWeight.w700
                      : FontWeight.w500,
                  size: description != null && description!.isNotEmpty
                      ? 16.5
                      : 14,
                  color: color ??
                      (isError ? ColorX.danger.shade500 : ColorX.primary),
                ),
              if (description != null && description!.isNotEmpty)
                TextX(
                  description!,
                  maxLines: maxLine,
                  style: TextStyleX.titleSmall,
                  color: color ??
                      (isError ? ColorX.danger.shade500 : ColorX.primary),
                ).marginOnly(
                    top: message != null && message!.isNotEmpty ? 6 : 0)
            ]),
          ),
          if (child != null) child!
        ],
      ),
    );
  }
}
