// EDUCATION MODEL

import 'package:connect_me/app.dart';

SliverWoltModalSheetPage socialMediaModal(
    BuildContext modalSheetContext, TextTheme textTheme) {
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
  final List<SocialClass> textEditingControllerList = [
    SocialClass(title: '', link: '')
  ];
  final GlobalKey<FormState> socialKey = GlobalKey<FormState>();

  final List<String> items = [
    SocialDropdownEnum.facebook.message,
    SocialDropdownEnum.linkedIn.message,
    SocialDropdownEnum.instagram.message,
    SocialDropdownEnum.youtube.message,
    SocialDropdownEnum.behance.message,
    SocialDropdownEnum.twitter.message,
    SocialDropdownEnum.tiktok.message,
    SocialDropdownEnum.github.message,
    SocialDropdownEnum.whatsapp.message,
    SocialDropdownEnum.snapchat.message,
    SocialDropdownEnum.twitch.message,
    SocialDropdownEnum.discord.message,
    SocialDropdownEnum.gmail.message,
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: socialKey,
      child: Column(
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
                      child: MyCustomDropWidgetWithStrings(
                        items: items,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (title) {
                          controller.title = title;
                          items.remove(title);
                        },
                      ),
                      // DropDownWithLabelWidget(),
                    )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 5,
                  child: AuthTextFieldWidget(
                    contentPadding: AppEdgeInsets.eA18,
                    controller: TextEditingController(text: controller.link),
                    onChanged: (link) {
                      controller.link = link;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*';
                      } else {
                        return null;
                      }
                    },
                    hintText: 'Link',
                  ),
                ),
              ],
            ),
          TextButton.icon(
            onPressed: () {
              textEditingControllerList.add(
                SocialClass(title: '', link: ''),
              );

              setState(() {});
            },
            icon: const Icon(addIcon),
            label: const Text('Add new'),
          ),
          // SAVE BUTTON
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                Map<String, String> result = {};
                for (var value in textEditingControllerList) {
                  result[value.title] = value.link;
                }
                if (socialKey.currentState!.validate()) {
                  inspect(result);
                }
              },
              child: const Text(TextConstant.save),
            ),
          ),
        ].columnInPadding(15),
      ),
    );
  }
}

class SocialClass {
  String title;
  String link;

  SocialClass({
    required this.title,
    required this.link,
  });
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

//
