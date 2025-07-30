part of '../../widget.dart';

class MoreCardX extends StatelessWidget {
  const MoreCardX({super.key, required this.title, this.icon, required this.onTap, this.iconSize=26});
  final String title;
  final IconData? icon;
  final double iconSize;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ContainerX(
          height: 66,
          isBorder: true,
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if(icon!=null)
                    Icon(icon,color: ColorX.primary.shade500,size: iconSize),
                    if(icon!=null)
                    const SizedBox(width: 12),
                    Expanded(child: TextX(title)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon( Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.secondary,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
