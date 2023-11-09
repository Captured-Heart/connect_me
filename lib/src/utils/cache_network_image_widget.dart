import 'package:connect_me/app.dart';

CachedNetworkImage cachedNetworkImageWidget({
  required String? imgUrl,
  required double height,
  double? width,
  bool? isProgressIndicator = false,
  // double? loaderHeight,
  // double? loaderWidth,
}) {
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
          : shimmerWidget(
              child: Container(
                alignment: Alignment.center,
                height: height,
                width: width ?? context.sizeWidth(1),
                decoration: BoxDecoration(
                  color: AppThemeColorDark.indicatorActiveColor,
                  borderRadius: BorderRadius.circular(20),
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

Widget circleCacheNetworkImage({
  String? imgUrl,
  required double height,
  double? width,
}) {
  return CachedNetworkImage(
    key: UniqueKey(),
    imageUrl: imgUrl ?? ImagesConstant.noImagePlaceholderHttp,
    height: height,
    width: width,
    fit: BoxFit.fill,
    imageBuilder: (context, imageProvider) {
      return Container(
        // height: height,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: CachedNetworkImageProvider(imgUrl ?? ImagesConstant.noImagePlaceholderHttp),
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
