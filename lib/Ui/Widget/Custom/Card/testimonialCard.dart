part of "../../widget.dart";

class TestimonialCardX extends StatelessWidget {
  const TestimonialCardX({super.key, required this.testimonial});
  final TestimonialX testimonial;
  @override
  Widget build(BuildContext context) {
    return ContainerX(
      width: 280,
      height: 250,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(IconX.testimonial,
              size: 40, color: Theme.of(context).primaryColor),
          Expanded(
            child: Center(
              child: AutoSizeText(
                testimonial.content,
                style: TextStyleX.titleLarge.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ).paddingSymmetric(vertical: 26),
            ),
          ),
          if (testimonial.country == null || testimonial.country!.name.isEmpty)
            Center(
              child: AutoSizeText(
                testimonial.name,
                style: TextStyleX.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (testimonial.country != null &&
              testimonial.country!.name.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageNetworkX(
                  imageUrl: testimonial.imageUrl??'',
                  radius: 100,
                  height: 24,
                  width: 24,
                  empty: Image.asset(
                    ImageX.defaultUserTestimonial,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 9),
                Container(
                  constraints: const BoxConstraints(maxWidth: 90),
                  child: AutoSizeText(
                    testimonial.name,
                    style: TextStyleX.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 9),
                const TextX(
                  '/',
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 9),
                Container(
                  constraints: const BoxConstraints(maxWidth: 90),
                  child: AutoSizeText(
                    testimonial.country!
                            .name[TranslationX.getLocale.languageCode] ??
                        testimonial.country!
                            .name[TranslationX.fallbackLocale.languageCode] ??
                        testimonial.country!.name.values.first,
                    style: TextStyleX.titleMedium.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
