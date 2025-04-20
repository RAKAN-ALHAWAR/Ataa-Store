part of '../../widget.dart';

class ZakatCalculatorCardX extends StatelessWidget {
  const ZakatCalculatorCardX({
    super.key,
    required this.isOpen,
    required this.onChangeOpen,
    required this.child,
    required this.title,
    required this.error,
    required this.isLoading,
    required this.isDone,
  });
  final String title;
  final bool isOpen;
  final Function(bool val) onChangeOpen;
  final Widget child;
  final String? error;
  final bool isLoading;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchX(
            value: isOpen,
            onChange: onChangeOpen,
            label: title,
          ),
          SizedBox(
            child: isOpen
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContainerX(
                        color: Theme.of(context).cardTheme.color,
                        child: child,
                      ),
                    if (error != null && error!.isNotEmpty)
                      MessageCardX(message: error!, isError: true)
                          .paddingOnly(top: 10)
                          .sizeAnimation200,
                    if (error == null && isLoading)
                      Row(
                        children: [
                          TextX(
                            'Calculating the value of Zakat',
                            style: TextStyleX.supTitleLarge,
                              color: Theme.of(context).colorScheme.secondary,
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(width: 16),
                          const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              )),
                        ],
                      ).paddingOnly(top: 10).sizeAnimation200,
                    if (error == null && !isLoading && isDone)
                      TextX(
                        'Zakat value has been calculated successfully',
                        color: Theme.of(context).primaryColor,
                      ).sizeAnimation200.paddingOnly(top: 10),
                  ],
                )
                : null,
          ).sizeAnimation300,
        ],
      ),
    );
  }
}
