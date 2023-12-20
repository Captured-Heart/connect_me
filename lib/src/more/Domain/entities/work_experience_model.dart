import 'package:connect_me/app.dart';
import 'package:equatable/equatable.dart';

class WorkExperienceModel extends Equatable {
  final String? title;
  final String? employmentType;

  final String? companyName;
  final String? location;
  final String? locationType;
  final String? docId;
  final String? userId;
  final StartDateModel? startDate;
  final EndDateModel? endDate;
  final Timestamp? createdAt;
  final String? formTitle;

  const WorkExperienceModel({
    this.title,
    this.employmentType,
    this.companyName,
    this.location,
    this.locationType,
    this.docId,
    this.userId,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.formTitle,
  });

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      title: json['title'] as String?,
      employmentType: json['employmentType'] as String?,
      companyName: json['companyName'] as String?,
      location: json['location'] as String?,
      locationType: json['locationType'] as String?,
      docId: json['docId'] as String?,
      userId: json['userId'] as String?,
      startDate: json['startDate'] as StartDateModel?,
      endDate: json['endDate'] as EndDateModel?,
      createdAt: json['createdAt'] as Timestamp?,
      formTitle: json['formTitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'employmentType': employmentType,
        'companyName': companyName,
        'location': location,
        'locationType': locationType,
        'docId': docId,
        'userId': userId,
        'startDate': startDate,
        'endDate': endDate,
        'createdAt': Timestamp.now(),
        'formTitle': 'Work Experience',
      };

  WorkExperienceModel copyWith({
    String? title,
    String? employmentType,
    String? companyName,
    String? location,
    String? locationType,
    String? docId,
    String? userId,
    StartDateModel? startDate,
    EndDateModel? endDate,
    Timestamp? createdAt,
    String? formTitle,
  }) {
    return WorkExperienceModel(
      title: title ?? this.title,
      employmentType: employmentType ?? this.employmentType,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      locationType: locationType ?? this.locationType,
      docId: docId ?? this.docId,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      formTitle: formTitle ?? this.formTitle,
    );
  }

  @override
  List<Object?> get props {
    return [
      title,
      employmentType,
      companyName,
      location,
      locationType,
      docId,
      userId,
      startDate,
      endDate,
      createdAt,
      formTitle,
    ];
  }
}
