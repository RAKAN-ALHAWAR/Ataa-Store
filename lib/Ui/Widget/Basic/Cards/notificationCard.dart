part of '../../widget.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({required this.notification, super.key});
  final NotificationX notification;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(17.0),
      radius: 16,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContainerX(
              padding: const EdgeInsets.all(12.0),
              color: Theme.of(context).colorScheme.onPrimary,
              child: Icon(
                Icons.notifications_rounded,
                color: ColorX.primary,
                size: 28.0,
              )),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(notification.titleDonor!=null)
                TextX(
                  notification.titleDonor!,
                  style: TextStyleX.titleSmall,
                  fontWeight: FontWeight.w700,
                ),
                if(notification.titleDonor!=null)
                const SizedBox(height: 6.0),
                if(notification.contentDonor!=null)
                TextX(
                  notification.contentDonor!,
                  style: TextStyleX.supTitleLarge,
                    color: Theme.of(context).colorScheme.secondary,
                  size: 13,
                ),
                const SizedBox(height: 7.0),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextX(
                    intl.DateFormat('yyyy/MM/dd  HH:mm').format(notification.createdAt),
                    style: TextStyleX.supTitleLarge,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
