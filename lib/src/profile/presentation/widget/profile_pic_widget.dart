import '../../../../app.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
    this.withoutBorder = false,
    this.authUserModel,
    this.onTap,
    this.isStaticTheme = false,
    this.height,
    this.width,
    this.heroTag,
    this.enlargeDP = true,
  });

  final bool withoutBorder;
  final AuthUserModel? authUserModel;
  final VoidCallback? onTap;
  final bool isStaticTheme;
  final double? height, width;
  final Object? heroTag;
  final bool enlargeDP;
  @override
  Widget build(BuildContext context) {
    return authUserModel?.docId == null
        ? const SizedBox.shrink()
        : Hero(
            tag: authUserModel?.imgUrl ?? 'imgUrl',
            child: GestureDetector(
              onTap: enlargeDP == false
                  ? null
                  : () {
                      if (authUserModel?.imgUrl != null ||
                          authUserModel?.imgUrl?.isNotEmpty == true) {
                        Navigator.of(context).push(
                          HeroDialogRoute(
                            builder: (context) =>
                                FullScreenImageDisplay(imgUrl: authUserModel!.imgUrl!),
                          ),
                        );
                      }
                    },
              child: Container(
                padding: AppEdgeInsets.eA2,
                decoration: withoutBorder == true
                    ? null
                    : BoxDecoration(
                        gradient: orangeGradient(isLongBTN: true, context: context),
                        borderRadius: height != null ? AppBorderRadius.c16 : AppBorderRadius.c32,
                        // border: Border.all(color: Colors.red)
                      ),
                child: SizedBox(
                  height: height ?? 90,
                  width: width ?? 90,
                  // width: double.minPositive,
                  child: authUserModel?.imgUrl == null || authUserModel?.imgUrl?.isEmpty == true
                      ? Card(
                          shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.c32),
                          margin: AppEdgeInsets.eA05,
                          child: Center(
                            child: AutoSizeText(
                              authUserModel?.username?.isNotEmpty == true
                                  ? authUserModel?.username?.substring(0, 1).toString() ?? '?'
                                  : '',
                              style: context.textTheme.displayMedium,
                              maxLines: 1,
                            ),
                          ),
                        )
                      : Card(
                          elevation: 5,
                          color: isStaticTheme == true ? Colors.white : null,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                height != null ? AppBorderRadius.c16 : AppBorderRadius.c32,
                          ),
                          child: CircleCacheNetworkImage(
                            imgUrl: authUserModel?.imgUrl ?? '',
                            height: 100,
                            width: context.sizeWidth(0.2),
                            isNotCircle: true,
                            borderRadius:
                                height != null ? AppBorderRadius.c16 : AppBorderRadius.c28,
                          ).padAll(height != null ? 3 : 6),
                        ),
                ),
              ),
            ),
          );
  }
}

/// full display of the profile picture, originally written by [Edeme_Paul]

class FullScreenImageDisplay extends ConsumerWidget {
  final String imgUrl;

  const FullScreenImageDisplay({
    super.key,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: context.sizeHeight(1),
                width: context.sizeWidth(1),
                color: Colors.transparent,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.clear),
                ).padAll(10),
              ],
            ),
            Center(
              child: Container(
                padding: AppEdgeInsets.eA6,
                decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.primary, width: 2),
                  // gradient: orangeGradient(isLongBTN: true, context: context),
                  shape: BoxShape.circle,
                  // border: Border.all(color: Colors.red)
                ),
                child: Hero(
                  tag: imgUrl,
                  child: CircleCacheNetworkImage(
                    imgUrl: imgUrl,
                    height: context.sizeHeight(0.4),
                  ),
                ),
              ),
            ),
            // const SizedBox(height: AppSpacings.cardPadding),
          ],
        ),
      ),
    );
  }
}
