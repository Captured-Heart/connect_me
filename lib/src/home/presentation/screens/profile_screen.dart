import 'package:connect_me/app.dart';
import 'package:faker/faker.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: AppEdgeInsets.eA4,
              
              decoration: BoxDecoration(
                gradient: orangeGradient(isLongBTN: false),
                borderRadius: AppBorderRadius.c20,
                // border: Border.all(color: Colors.red)
              ),
              child: SizedBox(
                height: 90,
                // width: context.sizeWidth(0.2),
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.zero,
                  child: circleCacheNetworkImage(
                    imgUrl: ImagesConstant.imgPlaceholderHttp,
                    height: 100,
                    width: context.sizeWidth(0.2),
                    isNotCircle: true,
                    borderRadius: AppBorderRadius.c20,
                  ).padAll(5)
                ),
              ),
            ),

           

            //
            GradientLongBTN(),
            Card(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GradientShortBTN(),
                        GradientShortBTN(),
                        GradientShortBTN(),
                        GradientShortBTN(),
                      ].rowInPadding(15),
                    ),
                  ).padAll(10),
                  Text(
                    faker.lorem.sentences(10).toString(),
                    textAlign: TextAlign.justify,
                    softWrap: true,
                  )
                ],
              ).padOnly(
                left: 12,
                right: 12,
                bottom: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GradientLongBTN extends StatelessWidget {
  const GradientLongBTN({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: orangeGradient(),
        borderRadius: AppBorderRadius.c12,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          'Follow',
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: AppFontWeight.w600,
            color: AppThemeColorDark.textDark,
          ),
        ),
      ),
    );
  }
}

class GradientShortBTN extends StatelessWidget {
  const GradientShortBTN({
    super.key,
    this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: orangeGradient(isLongBTN: true),
        borderRadius: AppBorderRadius.c12,
      ),
      child: child ??
          const SizedBox(
            height: 55,
            width: 55,
            child: Card(
              elevation: 5,
              margin: AppEdgeInsets.eA2,
              child: Icon(
                notificationIcon,
                size: 28,
              ),
            ),
          ),
    );
  }
}
