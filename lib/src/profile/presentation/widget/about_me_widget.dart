import 'package:connect_me/app.dart';

class AboutMeWidget extends StatelessWidget {
  const AboutMeWidget({
    super.key,
    this.offset = 0.0,
  });
  final double? offset;
  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: offset! > 300 ? const EdgeInsets.only(top: 170) : EdgeInsets.zero,
        children: [
          Card(
            elevation: 5,
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pushAsVoid(context, const QrCodeScreen());
                        },
                        child: const GradientShortBTN(
                          iconData: mailIcon,
                          iconSize: 21,
                        ),
                      ),
                      const GradientShortBTN(
                        iconData: twitterIcon,
                        iconSize: 28,
                      ),
                      const GradientShortBTN(
                        iconData: whatsappIcon,
                      ),
                      const GradientShortBTN(
                        iconData: telegramIcon,
                      ),
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
          ),
          Card(
            elevation: 5,
            child: Column(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      GradientShortBTN(
                        iconData: mailIcon,
                        iconSize: 21,
                      ),
                      GradientShortBTN(
                        iconData: twitterIcon,
                        iconSize: 28,
                      ),
                      GradientShortBTN(
                        iconData: whatsappIcon,
                      ),
                      GradientShortBTN(
                        iconData: telegramIcon,
                      ),
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
          ),
        ].columnInPadding(7));
  }
}
