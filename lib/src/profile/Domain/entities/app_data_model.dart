import 'package:equatable/equatable.dart';

class AppDataModel extends Equatable {
  final String? whatsappSupport;
  final String? twitterSupport;
  final String? emailSupport;
  final String? docId;
  final String? devEmail;
  final String? devTwitter;
  final String? buyMeCoffee;
  final String? btcAddress;
  final String? iosAppLink;
  final String? androidAppLink;

  const AppDataModel({
    this.whatsappSupport,
    this.twitterSupport,
    this.emailSupport,
    this.docId,
    this.devEmail,
    this.devTwitter,
    this.buyMeCoffee,
    this.btcAddress,
    this.androidAppLink,
    this.iosAppLink,
  });

  factory AppDataModel.fromJson(Map<String, dynamic> json) => AppDataModel(
        whatsappSupport: json['whatsappSupport'] as String?,
        twitterSupport: json['twitterSupport'] as String?,
        emailSupport: json['emailSupport'] as String?,
        devEmail: json['devEmail'] as String?,
        devTwitter: json['devTwitter'] as String?,
        buyMeCoffee: json['buyMeCoffee'] as String?,
        btcAddress: json['btcAddress'] as String?,
        docId: json['docId'] as String?,
        androidAppLink: json['androidAppLink'] as String?,
        iosAppLink: json['iosAppLink'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'whatsappSupport': whatsappSupport,
        'twitterSupport': twitterSupport,
        'emailSupport': emailSupport,
        'devEmail': devEmail,
        'devTwitter': devTwitter,
        'buyMeCoffee': buyMeCoffee,
        'btcAddress': btcAddress,
        'docId': docId,
        'androidAppLink': androidAppLink,
        'iosAppLink': iosAppLink,
      };

  AppDataModel copyWith({
    String? whatsappSupport,
    String? twitterSupport,
    String? emailSupport,
    String? devEmail,
    String? devTwitter,
    String? buyMeCoffee,
    String? btcAddress,
    String? docId,
    String? androidAppLink,
    String? iosAppLink,
  }) {
    return AppDataModel(
      whatsappSupport: whatsappSupport ?? this.whatsappSupport,
      twitterSupport: twitterSupport ?? this.twitterSupport,
      emailSupport: emailSupport ?? this.emailSupport,
      devEmail: devEmail ?? this.devEmail,
      devTwitter: devTwitter ?? this.devTwitter,
      buyMeCoffee: buyMeCoffee ?? this.buyMeCoffee,
      btcAddress: btcAddress ?? this.btcAddress,
      docId: docId ?? this.docId,
      androidAppLink: androidAppLink ?? this.androidAppLink,
      iosAppLink: iosAppLink ?? this.iosAppLink,
    );
  }

  @override
  List<Object?> get props {
    return [
      whatsappSupport,
      twitterSupport,
      emailSupport,
      devEmail,
      devTwitter,
      buyMeCoffee,
      btcAddress,
      docId,
      androidAppLink,
      iosAppLink,
    ];
  }
}
