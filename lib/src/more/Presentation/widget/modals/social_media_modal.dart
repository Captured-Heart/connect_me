// EDUCATION MODEL

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

class SocialMediaBody extends ConsumerStatefulWidget {
  const SocialMediaBody({
    super.key,
  });

  @override
  ConsumerState<SocialMediaBody> createState() => _SocialMediaBodyState();
}

class _SocialMediaBodyState extends ConsumerState<SocialMediaBody> {
  final List<SocialClass> textEditingControllerList = [SocialClass(title: '', link: '')];
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
    final infoState = ref.watch(addSocialMediaProvider);

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
                            return TextConstant.required;
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
                        return TextConstant.required;
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
            label: const Text(TextConstant.addNew),
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
                  ref
                      .read(addSocialMediaProvider.notifier)
                      .addSocialMediaMethod(map: result)
                      .whenComplete(() => ref.invalidate(fetchProfileProvider));
                }
              },
              child: infoState.isLoading == true
                  ? SizedBox(
                      height: 20,
                      width: 30,
                      child: CircularProgressIndicator(
                        backgroundColor: context.colorScheme.surface,
                      ),
                    )
                  : const Text(TextConstant.save),
            ),
          ),
          infoState.value == null || infoState.hasError
              ? const SizedBox.shrink()
              : Text(
                  infoState.hasError
                      ? infoState.error.toString()
                      : infoState.valueOrNull.toString(),
                  style: AppTextStyle.bodyMedium.copyWith(
                      color: infoState.hasError ? Colors.red : AppThemeColorDark.successColor),
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

IconData socialIconsSwitch(SocialDropdownEnum? socialDropdownEnum) {
  // SocialDropdownEnum socialDropdownEnum = SocialDropdownEnum.behance;
  switch (socialDropdownEnum) {
    case SocialDropdownEnum.facebook:
      return SocialDropdownEnum.facebook.icon;
    case SocialDropdownEnum.linkedIn:
      return SocialDropdownEnum.linkedIn.icon;
    case SocialDropdownEnum.instagram:
      return SocialDropdownEnum.instagram.icon;
    case SocialDropdownEnum.youtube:
      return SocialDropdownEnum.youtube.icon;
    case SocialDropdownEnum.behance:
      return SocialDropdownEnum.behance.icon;
    case SocialDropdownEnum.twitter:
      return SocialDropdownEnum.twitter.icon;
    case SocialDropdownEnum.tiktok:
      return SocialDropdownEnum.tiktok.icon;
    case SocialDropdownEnum.github:
      return SocialDropdownEnum.github.icon;
    case SocialDropdownEnum.whatsapp:
      return SocialDropdownEnum.whatsapp.icon;
    case SocialDropdownEnum.snapchat:
      return SocialDropdownEnum.snapchat.icon;
    case SocialDropdownEnum.twitch:
      return SocialDropdownEnum.twitch.icon;
    case SocialDropdownEnum.discord:
      return SocialDropdownEnum.discord.icon;
    case SocialDropdownEnum.gmail:
      return SocialDropdownEnum.gmail.icon;

    default:
      return SocialDropdownEnum.behance.icon;
  }
}


// //
