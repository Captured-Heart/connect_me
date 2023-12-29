import 'package:equatable/equatable.dart';

class SocialMediaModel extends Equatable {
  final String? facebook;
  final String? linkedIn;
  final String? instagram;
  final String? youtube;
  final String? behance;
  final String? twitter;
  final String? tiktok;
  final String? github;
  final String? whatsapp;
  final String? snapchat;
  final String? twitch;
  final String? discord;
  final String? gmail;
  final String? createdAt;

  const SocialMediaModel({
    this.facebook,
    this.linkedIn,
    this.instagram,
    this.youtube,
    this.behance,
    this.twitter,
    this.tiktok,
    this.github,
    this.whatsapp,
    this.snapchat,
    this.twitch,
    this.discord,
    this.gmail,
    this.createdAt,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      facebook: json['facebook'] as String?,
      linkedIn: json['linkedIn'] as String?,
      instagram: json['instagram'] as String?,
      youtube: json['youtube'] as String?,
      behance: json['behance'] as String?,
      twitter: json['twitter'] as String?,
      tiktok: json['tiktok'] as String?,
      github: json['github'] as String?,
      whatsapp: json['whatsapp'] as String?,
      snapchat: json['snapchat'] as String?,
      twitch: json['twitch'] as String?,
      discord: json['discord'] as String?,
      gmail: json['gmail'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'facebook': facebook,
        'linkedIn': linkedIn,
        'instagram': instagram,
        'youtube': youtube,
        'behance': behance,
        'twitter': twitter,
        'tiktok': tiktok,
        'github': github,
        'whatsapp': whatsapp,
        'snapchat': snapchat,
        'twitch': twitch,
        'discord': discord,
        'gmail': gmail,
        'createdAt': createdAt,
      };

  SocialMediaModel copyWith({
    String? facebook,
    String? linkedIn,
    String? instagram,
    String? youtube,
    String? behance,
    String? twitter,
    String? tiktok,
    String? github,
    String? whatsapp,
    String? snapchat,
    String? twitch,
    String? discord,
    String? gmail,
    String? createdAt,
  }) {
    return SocialMediaModel(
      facebook: facebook ?? this.facebook,
      linkedIn: linkedIn ?? this.linkedIn,
      instagram: instagram ?? this.instagram,
      youtube: youtube ?? this.youtube,
      behance: behance ?? this.behance,
      twitter: twitter ?? this.twitter,
      tiktok: tiktok ?? this.tiktok,
      github: github ?? this.github,
      whatsapp: whatsapp ?? this.whatsapp,
      snapchat: snapchat ?? this.snapchat,
      twitch: twitch ?? this.twitch,
      discord: discord ?? this.discord,
      gmail: gmail ?? this.gmail,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      facebook,
      linkedIn,
      instagram,
      youtube,
      behance,
      twitter,
      tiktok,
      github,
      whatsapp,
      snapchat,
      twitch,
      discord,
      gmail,
      createdAt,
    ];
  }
}
