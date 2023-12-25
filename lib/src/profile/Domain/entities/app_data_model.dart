import 'package:equatable/equatable.dart';

class AppDataModel extends Equatable {
  final String? whatsappSupport;
  final String? twitterSupport;
  final String? emailSupport;
  final String? docId;

  const AppDataModel({
    this.whatsappSupport,
    this.twitterSupport,
    this.emailSupport,
    this.docId,
  });

  factory AppDataModel.fromJson(Map<String, dynamic> json) => AppDataModel(
        whatsappSupport: json['whatsappSupport'] as String?,
        twitterSupport: json['twitterSupport'] as String?,
        emailSupport: json['emailSupport'] as String?,
        docId: json['docId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'whatsappSupport': whatsappSupport,
        'twitterSupport': twitterSupport,
        'emailSupport': emailSupport,
        'docId': docId,
      };

  AppDataModel copyWith({
    String? whatsappSupport,
    String? twitterSupport,
    String? emailSupport,
    String? docId,
  }) {
    return AppDataModel(
      whatsappSupport: whatsappSupport ?? this.whatsappSupport,
      twitterSupport: twitterSupport ?? this.twitterSupport,
      emailSupport: emailSupport ?? this.emailSupport,
      docId: docId ?? this.docId,
    );
  }

  @override
  List<Object?> get props {
    return [
      whatsappSupport,
      twitterSupport,
      emailSupport,
      docId,
    ];
  }
}
