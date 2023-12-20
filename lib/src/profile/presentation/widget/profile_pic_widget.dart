import 'package:connect_me/app.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
    this.withoutBorder = false,
    this.authUserModel,
    this.onTap,
    this.isStaticTheme = false,
    this.height,
    this.width,
  });

  final bool withoutBorder;
  final AuthUserModel? authUserModel;
  final VoidCallback? onTap;
  final bool isStaticTheme;
  final double? height, width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: AppEdgeInsets.eA2,
        decoration: withoutBorder == true
            ? null
            : BoxDecoration(
                gradient: orangeGradient(isLongBTN: true),
                borderRadius:
                    height != null ? AppBorderRadius.c16 : AppBorderRadius.c32,
                // border: Border.all(color: Colors.red)
              ),
        child: SizedBox(
          height: height ?? 90,
          width: width ?? 90,
          // width: double.minPositive,
          child: Card(
            elevation: 5,
            color: isStaticTheme == true ? Colors.white : null,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius:
                    height != null ? AppBorderRadius.c16 : AppBorderRadius.c32),
            child:

                //TODO: ADD AVATAR TO THE IMG SECTION

                //  authUserModel?.imgUrl == null
                //     ? Card(
                //         shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.c32),
                //         child: Text(
                //           authUserModel?.username?.substring(0, 1).toString() ?? '?',
                //           // style: AppTextStyle.bodyLarge.copyWith(color: Colors.black),
                //         ),
                //       )
                //     :

                CircleCacheNetworkImage(
              imgUrl:
                  authUserModel?.imgUrl ?? ImagesConstant.imgPlaceholderHttp,
              height: 100,
              width: context.sizeWidth(0.2),
              isNotCircle: true,
              borderRadius:
                  height != null ? AppBorderRadius.c16 : AppBorderRadius.c28,
            ).padAll(height != null ? 3 : 6),
          ),
        ),
      ),
    );
  }
}
