// EDUCATION MODEL
import 'dart:developer';

import 'package:connect_me/app.dart';

SliverWoltModalSheetPage socialMediaModal(BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.socialMediaHandles, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const SocialMediaBody().padAll(15),
  );
}

//
class SocialMediaBody extends StatefulWidget {
  const SocialMediaBody({
    super.key,
  });

  @override
  State<SocialMediaBody> createState() => _SocialMediaBodyState();
}

class _SocialMediaBodyState extends State<SocialMediaBody> {
  final List<TextEditingController> textEditingControllerList = [
    TextEditingController(),
  ];

  final List<Widget> items = [
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.facebook.icon, title: SocialDropdownEnum.facebook.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.linkedIn.icon, title: SocialDropdownEnum.linkedIn.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.instagram.icon, title: SocialDropdownEnum.instagram.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.youtube.icon, title: SocialDropdownEnum.youtube.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.behance.icon, title: SocialDropdownEnum.behance.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.twitter.icon, title: SocialDropdownEnum.twitter.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.tiktok.icon, title: SocialDropdownEnum.tiktok.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.github.icon, title: SocialDropdownEnum.github.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.whatsapp.icon, title: SocialDropdownEnum.whatsapp.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.snapchat.icon, title: SocialDropdownEnum.snapchat.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.twitch.icon, title: SocialDropdownEnum.twitch.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.discord.icon, title: SocialDropdownEnum.discord.message),
    SocialMediaDropdownListItem(
        icon: SocialDropdownEnum.gmail.icon, title: SocialDropdownEnum.gmail.message),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //start date
        for (var controller in textEditingControllerList)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: CustomDropdown(
                      items: items,
                      // ['Whatsapp', 'boy'],
                      listItemBuilder: (context, item) {
                        return item;
                      },
                      headerBuilder: (context, selectedItem) {
                        return selectedItem;
                      },
                      hintBuilder: (context, hint) {
                        return AutoSizeText(
                          'Choose',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onBackground.withOpacity(0.6),
                          ),
                        );
                      },
                      closedBorder: Border.all(
                        color: context.theme.textTheme.bodyMedium!.color!,
                        width: 0.3,
                      ),
                      expandedBorder: Border.all(
                        color: context.theme.textTheme.bodyMedium!.color!,
                        width: 0.3,
                      ),
                      closedFillColor: context.theme.scaffoldBackgroundColor,
                      expandedFillColor: context.theme.scaffoldBackgroundColor,
                    ),
                    // DropDownWithLabelWidget(),
                  )),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 5,
                child: AuthTextFieldWidget(
                  controller: controller,
                  hintText: 'Link',
                ),
              ),
            ],
          ),
        TextButton.icon(
          onPressed: () {
            textEditingControllerList.add(TextEditingController());
            setState(() {});
          },
          icon: Icon(addIcon),
          label: Text('Add new'),
        ),
// SAVE BUTTON
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(TextConstant.save),
          ),
        ),
      ].columnInPadding(15),
    );
  }
}

// class DropDownWithLabelWidget extends StatelessWidget {
//   DropDownWithLabelWidget({
//     super.key,
//     this.label = '',
//   });
//   final String label;

//   final List<Widget> items = [
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.facebook.icon, title: SocialDropdownEnum.facebook.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.linkedIn.icon, title: SocialDropdownEnum.linkedIn.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.instagram.icon, title: SocialDropdownEnum.instagram.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.youtube.icon, title: SocialDropdownEnum.youtube.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.behance.icon, title: SocialDropdownEnum.behance.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.twitter.icon, title: SocialDropdownEnum.twitter.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.tiktok.icon, title: SocialDropdownEnum.tiktok.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.github.icon, title: SocialDropdownEnum.github.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.whatsapp.icon, title: SocialDropdownEnum.whatsapp.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.snapchat.icon, title: SocialDropdownEnum.snapchat.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.twitch.icon, title: SocialDropdownEnum.twitch.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.discord.icon, title: SocialDropdownEnum.discord.message),
//     SocialMediaDropdownListItem(
//         icon: SocialDropdownEnum.gmail.icon, title: SocialDropdownEnum.gmail.message),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         label.isEmpty == true
//             ? const SizedBox.shrink()
//             : AutoSizeText(
//                 label,
//                 maxLines: 1,
//                 textScaleFactor: 0.9,
//               ).padOnly(bottom: 7),
//         CustomDropdown(
//           items: items,
//           // ['Whatsapp', 'boy'],
//           listItemBuilder: (context, item) {
//             return item;
//           },
//           headerBuilder: (context, selectedItem) {
//             return selectedItem;
//           },
//           hintBuilder: (context, hint) {
//             return AutoSizeText(
//               'Choose',
//               style: context.textTheme.bodySmall?.copyWith(
//                 color: context.colorScheme.onBackground.withOpacity(0.6),
//               ),
//             );
//           },
//           closedBorder: Border.all(
//             color: context.theme.textTheme.bodyMedium!.color!,
//             width: 0.3,
//           ),
//           expandedBorder: Border.all(
//             color: context.theme.textTheme.bodyMedium!.color!,
//             width: 0.3,
//           ),
//           closedFillColor: context.theme.scaffoldBackgroundColor,
//           expandedFillColor: context.theme.scaffoldBackgroundColor,
//         ),
//       ],
//     );
//   }
// }

class SocialMediaDropdownListItem extends StatelessWidget {
  const SocialMediaDropdownListItem({
    super.key,
    required this.icon,
    required this.title,
  });

  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        Expanded(
            child: AutoSizeText(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ))
      ].rowInPadding(5),
    );
  }
}

enum SocialDropdownEnum {
  facebook('Facebook', IonIcons.logo_facebook),
  linkedIn('LinkedIn', IonIcons.logo_linkedin),
  instagram('Instagram', IonIcons.logo_instagram),
  youtube('Youtube', IonIcons.logo_youtube),
  behance('Behance', IonIcons.logo_behance),
  twitter('Twitter', IonIcons.logo_twitter),
  tiktok('TikTok', IonIcons.logo_tiktok),
  github('Github', IonIcons.logo_github),
  whatsapp('Whatsapp', IonIcons.logo_whatsapp),
  snapchat('Snapchat', IonIcons.logo_snapchat),
  twitch('Twitch', IonIcons.logo_twitch),
  discord('Discord', IonIcons.logo_discord),
  gmail('Gmail', IonIcons.logo_google);

  const SocialDropdownEnum(this.message, this.icon);
  final String message;
  final IconData icon;
}

final TextEditingController linkedInController = TextEditingController(text: 'linkeid');
final TextEditingController facebookController = TextEditingController(text: 'facebook');
final TextEditingController instagramController = TextEditingController(text: 'instagram');
final TextEditingController youtubeController = TextEditingController();
final TextEditingController behanceController = TextEditingController(text: 'behnace');
final TextEditingController twitterController = TextEditingController();
final TextEditingController tiktokController = TextEditingController();
final TextEditingController gmailController = TextEditingController();
final TextEditingController whatsappController = TextEditingController();
final TextEditingController snapchatController = TextEditingController();
final TextEditingController discordController = TextEditingController();
final TextEditingController twitchController = TextEditingController();
final TextEditingController githubController = TextEditingController();

extension GetTextEditingControllerExtension on SocialDropdownEnum {
  TextEditingController get textEditingController {
    switch (this) {
      case SocialDropdownEnum.linkedIn:
        return linkedInController;
      case SocialDropdownEnum.facebook:
        return facebookController;
      case SocialDropdownEnum.instagram:
        return instagramController;
      case SocialDropdownEnum.youtube:
        return youtubeController;
      case SocialDropdownEnum.behance:
        return behanceController;
      case SocialDropdownEnum.twitter:
        return twitterController;
      case SocialDropdownEnum.tiktok:
        return tiktokController;
      case SocialDropdownEnum.gmail:
        return gmailController;
      case SocialDropdownEnum.whatsapp:
        return whatsappController;
      case SocialDropdownEnum.snapchat:
        return snapchatController;
      case SocialDropdownEnum.discord:
        return discordController;
      case SocialDropdownEnum.twitch:
        return twitchController;
      case SocialDropdownEnum.github:
        return githubController;
      default:
        return TextEditingController();
    }
  }
}
