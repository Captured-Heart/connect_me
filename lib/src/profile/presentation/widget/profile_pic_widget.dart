import 'package:connect_me/app.dart';

class ProfilePicWidget extends StatelessWidget {
  const ProfilePicWidget({
    super.key,
    this.withoutBorder = false,
  });

  final bool withoutBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppEdgeInsets.eA2,
      decoration: withoutBorder == true
          ? null
          : BoxDecoration(
              gradient: orangeGradient(isLongBTN: true),
              borderRadius: AppBorderRadius.c32,
              // border: Border.all(color: Colors.red)
            ),
      child: SizedBox(
        height: 90,
        width: 90,
        // width: double.minPositive,
        child: Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            shape:
                const RoundedRectangleBorder(borderRadius: AppBorderRadius.c32),
            child: circleCacheNetworkImage(
              imgUrl: ImagesConstant.imgPlaceholderHttp,
              height: 100,
              width: context.sizeWidth(0.2),
              isNotCircle: true,
              borderRadius: AppBorderRadius.c28,
            ).padAll(6)),
      ),
    );
  }
}
