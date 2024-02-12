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
      facebook: json['Facebook'] as String?,
      linkedIn: json['LinkedIn'] as String?,
      instagram: json['Instagram'] as String?,
      youtube: json['Youtube'] as String?,
      behance: json['Behance'] as String?,
      twitter: json['Twitter'] as String?,
      tiktok: json['Tiktok'] as String?,
      github: json['Github'] as String?,
      whatsapp: json['Whatsapp'] as String?,
      snapchat: json['Snapchat'] as String?,
      twitch: json['Twitch'] as String?,
      discord: json['Discord'] as String?,
      gmail: json['Gmail'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'Facebook': facebook,
        'LinkedIn': linkedIn,
        'Instagram': instagram,
        'Youtube': youtube,
        'Behance': behance,
        'Twitter': twitter,
        'Tiktok': tiktok,
        'Github': github,
        'Whatsapp': whatsapp,
        'Snapchat': snapchat,
        'Twitch': twitch,
        'Discord': discord,
        'Gmail': gmail,
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
