part of '../../widget.dart';

class OptionWithIconCardX extends StatelessWidget {
  const OptionWithIconCardX({super.key, required this.title, required this.icon, required this.onTap, required this.subtitle});
  final String title;
  final String subtitle;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: ContainerX(
          isBorder: true,
            minHeight:80,
          padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon,color: ColorX.primary.shade500,size: 32,),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextX(title,fontWeight: FontWeight.w700,),
                    const SizedBox(height: 6),
                    TextX(subtitle,style: TextStyleX.supTitleMedium,
      color: Theme.of(context).colorScheme.secondary,maxLines: 2,),
                  ],
                ),
              ),
              // const Spacer(),
              const SizedBox(width: 20),
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
