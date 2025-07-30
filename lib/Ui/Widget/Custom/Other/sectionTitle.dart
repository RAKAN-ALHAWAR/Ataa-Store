part of '../../widget.dart';


class SectionTitleX extends StatelessWidget {
  const SectionTitleX({super.key,required this.title, this.icon, this.showMore, this.iconSize=22});
  final IconData? icon;
  final double iconSize;
  final String title;
  final Function()? showMore;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 10.0,top:10,start: StyleX.hPaddingApp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(children: [
              if(icon!=null)
                Icon(icon,color: context.isDarkMode?ColorX.grey.shade300:ColorX.grey.shade700,size: iconSize),
              if(icon!=null)
                const SizedBox(width: 8),
              Flexible(child: TextX(title,style: TextStyleX.titleLarge,color: context.isDarkMode?ColorX.grey.shade100:ColorX.grey.shade700,maxLines: 1,)),
            ],),
          ),
          const SizedBox(width: 8,),
          if(showMore!=null)
          InkWell(
            onTap: showMore,
            borderRadius: BorderRadius.circular(StyleX.radius),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: StyleX.hPaddingApp,vertical: 4),
              child: TextX("Show more",style: TextStyleX.supTitleLarge, color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
