part of '../../widget.dart';

class DeductionCardX extends StatefulWidget {
  const DeductionCardX({
    super.key,
    required this.deduction,
    required this.onTap,
    required this.onSubscribe,
    this.isSmallCard = false,
  });
  final DeductionX deduction;
  final Future<dynamic> Function(int code) onTap;
  final Future<bool> Function(DeductionX deduction) onSubscribe;
  final bool isSmallCard;

  @override
  State<DeductionCardX> createState() => _DeductionCardXState();
}

class _DeductionCardXState extends State<DeductionCardX> {
  bool isSubscribed = false;
  @override
  void initState() {
    isSubscribed = widget.deduction.isSubscribed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      color: Theme.of(context).cardColor,
      radius: StyleX.radius,
      margin: widget.isSmallCard
          ? const EdgeInsetsDirectional.only(end: 14)
          : const EdgeInsetsDirectional.only(bottom: 14),
      padding: EdgeInsets.zero,
      width:
          widget.isSmallCard ? StyleX.deductionCardWidthSM : double.maxFinite,
      child: GestureDetector(
        onTap: () async {
          var x = await widget.onTap(widget.deduction.code);
          if (x == true) {
            setState(() {
              isSubscribed = true;
            });
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Stack(
                children: [
                  /// Cover Image
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(StyleX.radius),
                    ),
                    child: ImageNetworkX(
                      height: 170,
                      width: double.maxFinite,
                      imageUrl: widget.deduction.imageUrl,
                    ),
                  ),

                  /// Share Button
                  Positioned.directional(
                    textDirection: Directionality.of(context),
                    end: 10,
                    top: 10,
                    child: InkResponse(
                      onTap: () async{
                        await shareSheet(
                          id: widget.deduction.id,
                          code: widget.deduction.code,
                          type: LinkableTypeStatusX.deduction,
                        );
                      },
                      child: const ContainerX(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Icon(Icons.share_rounded),
                      ),
                    ),
                  ),

                  /// Deduction Recurring Marker
                  Positioned.directional(
                      textDirection: Directionality.of(context),
                      start: 10,
                      top: 12,
                      child: DeductionMarkerCardX(
                          deduction: widget.deduction.recurring.name)),
                ],
              ),
              const SizedBox(height: 4),

              /// Content
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Deduction Name
                    TextX(
                      widget.deduction.name,
                      style: TextStyleX.titleMedium,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 8),

                    /// Subscribe Button
                    if (isSubscribed)
                      ButtonX.gray(
                        text: 'Subscribed',
                        height: 48,
                        onTap: () {},
                      ),
                    if (!isSubscribed)
                      ButtonX(
                        text: "Subscribe Now",
                        onTap: () async {
                          var x = await widget.onSubscribe(widget.deduction);
                          if (x == true) {
                            setState(() {
                              isSubscribed = true;
                            });
                          }
                        },
                        iconData: Icons.payments_rounded,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
