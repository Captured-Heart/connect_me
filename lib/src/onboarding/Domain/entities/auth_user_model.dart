import 'package:equatable/equatable.dart';

class AuthUserModel extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? docId;

  const AuthUserModel({this.name, this.email, this.phone, this.docId});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        docId: json['docId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'docId': docId,
      };

  AuthUserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? docId,
  }) {
    return AuthUserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      docId: docId ?? this.docId,
    );
  }

  @override
  List<Object?> get props => [name, email, phone, docId];
}
