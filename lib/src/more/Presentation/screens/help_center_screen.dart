import 'package:connect_me/app.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

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
          const Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MoreCustomListTileWidget(
                  title: '${TextConstant.whatsapp} - ${TextConstant.contactUs}',
                  subtitle: TextConstant.chatWithUsOnWhatsapp,
                  icon: whatsappIcon,
                ),
                MoreCustomListTileWidget(
                  title: '${TextConstant.twitter}(X)',
                  subtitle: TextConstant.tellUsHowWeCanHelpYouOnX,
                  icon: twitterIcon,
                ),
                MoreCustomListTileWidget(
                  title: TextConstant.email,
                  subtitle: TextConstant.getYourSolutionsViaEmail,
                  icon: mailIcon,
                  iconSize: 17,
                ),
              ],
            ),
          ).padSymmetric(horizontal: 15)
        ].columnInPadding(20),
      ),
    );
  }
}
