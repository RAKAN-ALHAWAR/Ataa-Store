part of '../../widget.dart';

class ImageNetworkX extends StatelessWidget {
  const ImageNetworkX({
    super.key,
    required this.imageUrl,
    this.color,
    this.backgroundLoading,
    this.height,
    this.width,
    this.radius = 0,
    this.isFile = false,
    this.fit = BoxFit.cover,
    this.failed,
    this.empty,
  });

  final String imageUrl;
  final Widget? failed;
  final Widget? empty;

  final double? height;
  final double? width;
  final BoxFit fit;
  final bool isFile;
  final Color? color;
  final Color? backgroundLoading;
  final double radius;

  @override
  Widget build(BuildContext context) {
    double getPaddingEmpty() => (width ?? height ?? 200) >= 200
        ? 50.0
        : (width ?? height ?? 100) >= 100
        ? 10.0
        : 2.0;

    String getImageEmpty() => (width ?? height ?? 160) >= 160
        ? context.isDarkMode
              ? ImageX.logoWhite
              : ImageX.logo
        : context.isDarkMode
        ? ImageX.logoSymbolWhite
        : ImageX.logoSymbol;

    Widget buildEmptyOrFailed() {
      return SizedBox(
        width: width,
        height: height,
        child:
            failed ??
            empty ??
            Padding(
              padding: EdgeInsets.all(getPaddingEmpty()),
              child: SvgPicture.asset(getImageEmpty()),
            ),
      );
    }

    // إذا كان الـ URL فارغ
    if (imageUrl.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: buildEmptyOrFailed(),
      );
    }

    // إذا كان ملف محلي (File)
    if (isFile) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(imageUrl),
          height: height,
          width: width,
          fit: fit,
          color: color,
          errorBuilder: (context, error, stackTrace) => buildEmptyOrFailed(),
        ),
      );
    }

    // إذا كان SVG (سواء من الشبكة أو asset محلي)
    if (imageUrl.toLowerCase().endsWith('.svg') ||
        imageUrl.toLowerCase().contains('.svg')) {
      // تحديد إذا كان asset محلي أم من الشبكة
      bool isAsset =
          imageUrl.startsWith('assets/') || !imageUrl.startsWith('http');

      return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: isAsset
            ? SvgPicture.asset(
                imageUrl,
                height: height,
                width: width,
                fit: fit,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
                placeholderBuilder: (_) => Container(
                  color:
                      backgroundLoading ??
                      Theme.of(context).colorScheme.onPrimary,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              )
            : SvgPicture.network(
                imageUrl,
                height: height,
                width: width,
                fit: fit,
                colorFilter: color != null
                    ? ColorFilter.mode(color!, BlendMode.srcIn)
                    : null,
                placeholderBuilder: (_) => Container(
                  color:
                      backgroundLoading ??
                      Theme.of(context).colorScheme.onPrimary,
                  width: width,
                  height: height,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
      );
    }

    // صور عادية من الشبكة (PNG, JPG, WebP, إلخ)
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        imageUrl,
        height: height,
        width: width,
        fit: fit,
        color: color,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          if (frame == null) {
            return Container(
              color:
                  backgroundLoading ?? Theme.of(context).colorScheme.onPrimary,
              width: width,
              height: height,
            );
          }
          return child;
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return Container(
              color:
                  backgroundLoading ?? Theme.of(context).colorScheme.onPrimary,
              width: width,
              height: height,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          return child;
        },
        errorBuilder: (context, error, stackTrace) => buildEmptyOrFailed(),
      ),
    );
  }
}
