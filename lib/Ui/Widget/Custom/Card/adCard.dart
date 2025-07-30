part of '../../widget.dart';

class AdCardX extends StatefulWidget {
  const AdCardX(
      {super.key,
      required this.ad,
      required this.onTap,
      required this.onTapButton,
      });
  final AdsX ad;
  final Function(AdsX) onTap;
  final Function(AdsX) onTapButton;
  @override
  State<AdCardX> createState() => _AdCardXState();
}

class _AdCardXState extends State<AdCardX> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isInitChewieController = false;

  @override
  void initState() {
    /// Init Video Player
    if (widget.ad.videoUrl != null &&
        widget.ad.videoUrl!.isNotEmpty &&
        widget.ad.videoUrl!.isURL) {
      initVideoPlayer(widget.ad.videoUrl!);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.ad.videoUrl != null &&
        widget.ad.videoUrl!.isNotEmpty &&
        widget.ad.videoUrl!.isURL) {
      chewieController.dispose();
      videoPlayerController.dispose();
    }
    super.dispose();
  }

  initVideoPlayer(String url) async {
    try {
      setState(() {
        isInitChewieController = false;
      });
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url));
      await videoPlayerController.initialize();
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        allowPlaybackSpeedChanging: false,
        showControls: false,
        showOptions: false,
        allowMuting: true,
      );
      setState(() {
        isInitChewieController = true;
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: StyleX.hPaddingApp,
      ),
      child: GestureDetector(
        onTap: () async => await widget.onTap(widget.ad),
        child: ContainerX(
          color: Theme.of(context).colorScheme.onPrimary,
          width: double.maxFinite,
          height: StyleX.adsCardHeight,
          radius: StyleX.radiusMd,
          padding: EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(StyleX.radiusMd),
            child: Stack(
              children: [
                if (widget.ad.imageUrl != null &&
                    widget.ad.imageUrl!.isNotEmpty)
                  Positioned.fill(
                    child: ImageNetworkX(
                      imageUrl: widget.ad.imageUrl!,
                      fit: BoxFit.fill,
                      failed: const SizedBox(),
                    ),
                  ),
                if (widget.ad.videoUrl != null &&
                    widget.ad.videoUrl!.isNotEmpty &&
                    (widget.ad.imageUrl == null || widget.ad.imageUrl!.isEmpty))
                  Positioned.fill(
                    child: (!isInitChewieController)
                        ? const Center(child: CircularProgressIndicator())
                        : FittedBox(
                            fit: BoxFit.fill,
                            child: SizedBox(
                              height: videoPlayerController.value.size.height,
                              width: videoPlayerController.value.size.width,
                              child: Chewie(
                                controller: chewieController,
                              ),
                            ),
                          ),
                  ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black26,
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.ad.title.isEmpty) const SizedBox(),
                        if (widget.ad.videoUrl != null &&
                            widget.ad.videoUrl!.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow_rounded,
                                size: 17,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 2),
                              TextX(
                                'Watch the video',
                                style: TextStyleX.titleSmall,
                                size: 12,
                                textAlign: TextAlign.center,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        if (widget.ad.title.isNotEmpty)
                          AutoSizeText(
                            widget.ad.title,
                            style: TextStyleX.headerSmall
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        if (widget.ad.subtitle.isEmpty) const SizedBox(),
                        if (widget.ad.subtitle.isNotEmpty)
                          AutoSizeText(
                            widget.ad.subtitle,
                            style: TextStyleX.titleMedium
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ).paddingOnly(bottom: 6),
                        if (widget.ad.buttonTitle.isNotEmpty)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ButtonX(
                                height: 44,
                                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                colorButton: Colors.white,
                                borderColor: Colors.white,
                                colorText: ColorX.primary,
                                text: widget.ad.buttonTitle,
                                onTap: () async =>
                                    await widget.onTapButton(widget.ad),
                                isMaxFinite: false,
                                radius: 100,
                                marginVertical: 0,
                              ),
                            ],
                          ),
                        if (widget.ad.buttonTitle.isEmpty) const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
