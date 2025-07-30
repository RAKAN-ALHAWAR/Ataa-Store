part of '../../widget.dart';

class ContactCardX extends StatelessWidget {
  const ContactCardX({super.key, required this.icon, required this.title, required this.isShow, required this.onTap, this.iconSize = 24});
  final IconData icon;
  final String? title;
  final bool isShow;
  final double iconSize;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    if(isShow) {
      return GestureDetector(
        onTap: onTap,
        child: ContainerX(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        child: Row(
          children: [
            ContainerX(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(4),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Center(
                child: FittedBox(
                  child: Icon(
                    icon,
                    color: context.isDarkMode?ColorX.primary.shade800:ColorX.primary.shade700,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextX(title??"",overflow: TextOverflow.ellipsis,maxLines: 1,),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: ColorX.grey.shade400,
              size: 16,
            ),
          ],
        ),
            ),
      ).marginOnly(bottom: 12);
    }else{
      return const SizedBox();
    }
  }
}
