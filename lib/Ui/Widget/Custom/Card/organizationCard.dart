part of "../../widget.dart";

class OrganizationCardX extends StatelessWidget {
  const OrganizationCardX({super.key, required this.org, required this.onTap});
  final OrganizationX org;
  final Function(OrganizationX org) onTap;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      height: StyleX.organizationCardHeight,
      width: StyleX.organizationCardWidth,
      margin: const EdgeInsetsDirectional.only(end: 14),
      padding: const EdgeInsets.all(18),
      child: GestureDetector(
        onTap: () => onTap(org),
        child: Column(
          children: [
            ImageNetworkX(
              imageUrl: org.imageUrl,
              height: 66,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Center(
                child: AutoSizeText(
                  org.name,
                  style: TextStyleX.titleSmall.copyWith(fontWeight: FontWeight.w600),
                  maxLines: 2,
                  minFontSize: 8,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
