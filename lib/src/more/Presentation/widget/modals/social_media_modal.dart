// ignore_for_file: public_member_api_docs, sort_constructors_first
// EDUCATION MODEL

import 'dart:convert';

import 'package:connect_me/app.dart';

SliverWoltModalSheetPage socialMediaModal(
  BuildContext modalSheetContext, {
  required MapDynamicString? socialMediaModel,
}) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.socialMediaHandles, style: modalSheetContext.textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: SocialMediaBody(
      socialMediaModel: socialMediaModel,
      onSubmitSuccessful: Navigator.of(modalSheetContext).pop,
    ).padAll(15),
  );
}

//

class SocialClass {
  String title;
  String link;

  SocialClass({
    required this.title,
    required this.link,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'link': link,
    };
  }

  factory SocialClass.fromMap(Map<String, dynamic> map) {
    return SocialClass(
      title: map['title'] as String,
      link: map['link'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocialClass.fromJson(String source) => SocialClass.fromMap(json.decode(source) as Map<String, dynamic>);
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
