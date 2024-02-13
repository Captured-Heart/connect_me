import 'dart:ui';

import 'package:connect_me/app.dart' hide Image;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'packages/flutter/lib/src/widgets/image.dart' as ui;
// import 'packages/flutter/lib/src/widgets/painting.dart';
// import 'package:flutter/src/widgets/image.dart' as ui;
// import 'package:flutter/ui/widgets/painting.dart';

final uint8ListImageProvider =
    FutureProvider.family<Uint8List, String>((ref, imgUrl) async {
  return _resizeImage(imgUrl);
});

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

class CircleCacheNetworkImage extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // final image = ref.watch(
    //   uint8ListImageProvider(imgUrl ?? ImagesConstant.noImagePlaceholderHttp),
    // );

    return ClipRRect(
      borderRadius: AppBorderRadius.c12,
      child: CachedNetworkImage(
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
                  scale: 0.8,
                ),
                fit: BoxFit.cover,
              ),
            ),
            // child: ui.Image.memory(data),
          );
          // image.when(
          //   data: (data) {
          //     return Container(
          //       height: height,
          //       width: width,
          //       clipBehavior: Clip.antiAlias,
          //       decoration: BoxDecoration(
          //         shape: isNotCircle == true ? BoxShape.rectangle : BoxShape.circle,
          //         borderRadius: borderRadius,
          //       ),
          //       child: ui.Image.memory(data),
          //     );
          //   },
          //   error: (err, _) => Container(
          //     width: width,
          //     height: height,
          //     decoration: const BoxDecoration(
          //       shape: BoxShape.rectangle,
          //       image: DecorationImage(
          //         image: AssetImage(ImagesConstant.noImagePlaceholder),
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   ),
          //   loading: () => const Center(
          //     child: CircularProgressIndicator(),
          //   ),
          // );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Center(
            child: CircularProgressIndicator(
              value: progress.progress,
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
      ),
    );
  }
}

late Uint8List targetlUinit8List;
late Uint8List originalUnit8List;

//! THIS METHODS DOWNLOADS THE IMAGE AND RESIZES IT
Future<Uint8List> _resizeImage(String imgUrl) async {
  var imageUrl = Uri.parse(imgUrl);
  http.Response response = await http.get(imageUrl);
  originalUnit8List = response.bodyBytes;

  // Image originalUiImage = await decodeImageFromList(originalUnit8List);
  // ByteData? originalByteData = await originalUiImage.toByteData();
  // log('original image ByteData size is ${originalByteData!.lengthInBytes}');

  var codec = await instantiateImageCodec(originalUnit8List,
      targetHeight: 100, targetWidth: 100);
  var frameInfo = await codec.getNextFrame();
  Image targetUiImage = frameInfo.image;

  ByteData? targetByteData =
      await targetUiImage.toByteData(format: ImageByteFormat.png);
  // print('target image ByteData size is ${targetByteData!.lengthInBytes}');
  targetlUinit8List = targetByteData!.buffer.asUint8List();

  return targetlUinit8List;
}
