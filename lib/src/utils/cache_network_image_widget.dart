import 'package:connect_me/app.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    super.key,
    required this.imgUrl,
    required this.height,
    this.width,
    this.isProgressIndicator = false,
  });
  final String? imgUrl;
  final double height;
  final double? width;
  final bool? isProgressIndicator;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl ?? ImagesConstant.noImagePlaceholderHttp,
      height: height,
      width: width,
      fit: BoxFit.fill,
      progressIndicatorBuilder: (context, string, progress) {
        // ignore: use_if_null_to_convert_nulls_to_bools
        return isProgressIndicator == true
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ShimmerWidget(
                  child: Container(
                    alignment: Alignment.center,
                    margin: AppEdgeInsets.eA8,
                    height: height,
                    width: width ?? context.sizeWidth(1),
                    decoration: BoxDecoration(
                      color: AppThemeColorDark.indicatorActiveColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage(ImagesConstant.noImagePlaceholder),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}

class CircleCacheNetworkImage extends StatelessWidget {
  const CircleCacheNetworkImage({
    super.key,
    required this.height,
    this.isNotCircle = false,
    this.borderRadius,
    this.imgUrl,
    this.width,
  });
  final String? imgUrl;
  final double height;
  final double? width;
  final bool? isNotCircle;
  final BorderRadiusGeometry? borderRadius;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: UniqueKey(),
      imageUrl: imgUrl ?? ImagesConstant.noImagePlaceholderHttp,
      // height: height,
      // width: width,
      // fit: BoxFit.fill,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: isNotCircle == true ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: borderRadius,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                  imgUrl ?? ImagesConstant.noImagePlaceholderHttp,
                  scale: 0.8),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          width: width,
          height: height,
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: AssetImage(ImagesConstant.noImagePlaceholder),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
    );
  }
}
