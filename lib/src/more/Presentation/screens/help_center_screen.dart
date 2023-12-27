import 'package:connect_me/app.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({
    super.key,
    required this.appDataModel,
  });
  final AppDataModel? appDataModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextConstant.helpCenter247,
          textScaleFactor: 0.9,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: AppEdgeInsets.eV16,
        children: [
          const CustomListTileWidget(
            title: TextConstant.tellUsHowWeCanHelpYou,
            subtitle: TextConstant.superHumansWithABody,
            subtitleMaxLines: 2,
            subtitleTextAlign: TextAlign.center,
          ),
          Consumer(builder: (context, ref, _) {
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoreCustomListTileWidget(
                    title:
                        '${TextConstant.whatsapp} - ${TextConstant.contactUs}',
                    subtitle: TextConstant.chatWithUsOnWhatsapp,
                    icon: whatsappIcon,
                    onTap: () {
                      ref
                          .read(helpCenterImplProvider)
                          .contactWhatsapp(appDataModel?.whatsappSupport ?? '')
                          .onError((error, stackTrace) {
                        showScaffoldSnackBarMessageNoColor(
                          TextConstant.currentlyAvailable,
                          context: context,
                          isError: true,
                          appearsBottom: false,
                        );
                      });
                    },
                  ),
                  MoreCustomListTileWidget(
                    title: '${TextConstant.twitter}(X)',
                    subtitle: TextConstant.tellUsHowWeCanHelpYouOnX,
                    icon: twitterIcon,
                    onTap: () {
                      ref
                          .read(helpCenterImplProvider)
                          .contactTwitter(appDataModel?.twitterSupport ?? '')
                          .onError((error, stackTrace) {
                        showScaffoldSnackBarMessageNoColor(
                          TextConstant.currentlyAvailable,
                          context: context,
                          isError: true,
                          appearsBottom: false,
                        );
                      });
                    },
                  ),
                  MoreCustomListTileWidget(
                    title: TextConstant.email,
                    subtitle: TextConstant.getYourSolutionsViaEmail,
                    icon: mailIcon,
                    iconSize: 17,
                    onTap: () {
                      ref
                          .read(helpCenterImplProvider)
                          .contactEmail(appDataModel?.emailSupport ?? '')
                          .onError((error, stackTrace) {
                        showScaffoldSnackBarMessageNoColor(
                          TextConstant.currentlyAvailable,
                          context: context,
                          isError: true,
                          appearsBottom: false,
                        );
                      });
                    },
                  ),
                ],
              ),
            ).padSymmetric(horizontal: 15);
          })
        ].columnInPadding(20),
      ),
    );
  }
}
