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

  const AppDataModel({
    this.whatsappSupport,
    this.twitterSupport,
    this.emailSupport,
    this.docId,
    this.devEmail,
    this.devTwitter,
    this.buyMeCoffee,
    this.btcAddress,
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
    ];
  }
}
