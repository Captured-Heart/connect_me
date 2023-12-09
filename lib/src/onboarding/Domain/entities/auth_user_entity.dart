import 'package:connect_me/app.dart';
import 'package:equatable/equatable.dart';

class AuthUserModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? docId;
  final String? imgUrl;
  final bool? isGoogleSigned;
  final Timestamp? date;

  const AuthUserModel({
    this.name,
    this.email,
    this.phone,
    this.docId,
    this.imgUrl,
    this.isGoogleSigned,
    this.date,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        docId: json['docId'] as String?,
        imgUrl: json['imgUrl'] as String?,
        isGoogleSigned: json['isGoogleSigned'] as bool?,
        date: json['date'] as Timestamp?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'docId': docId,
        'imgUrl': imgUrl,
        'isGoogleSigned': isGoogleSigned,
        'date': Timestamp.now(),
      };

  AuthUserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? docId,
    String? imgUrl,
    bool? isGoogleSigned,
    Timestamp? date,
  }) {
    return AuthUserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      docId: docId ?? this.docId,
      imgUrl: imgUrl ?? this.imgUrl,
      isGoogleSigned: isGoogleSigned ?? this.isGoogleSigned,
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        docId,
        imgUrl,
        isGoogleSigned,
        date,
      ];
}
