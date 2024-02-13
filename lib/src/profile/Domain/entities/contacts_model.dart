import 'package:equatable/equatable.dart';

class ContactsModel extends Equatable {
  final String? docId;
  final String? userId;
  final String? connectTo;
  final String? createdAt;

  const ContactsModel({
    this.docId,
    this.userId,
    this.connectTo,
    this.createdAt,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) => ContactsModel(
        docId: json['docId'] as String?,
        userId: json['userId'] as String?,
        connectTo: json['connectTo'] as String?,
        createdAt: json['createdAt'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'userId': userId,
        'connectTo': connectTo,
        'createdAt': DateTime.now().toIso8601String(),
      };

  ContactsModel copyWith({
    String? docId,
    String? userId,
    String? connectTo,
    String? createdAt,
  }) {
    return ContactsModel(
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      connectTo: connectTo ?? this.connectTo,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [docId, userId, connectTo, createdAt];
}
