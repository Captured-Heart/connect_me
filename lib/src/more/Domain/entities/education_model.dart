import 'package:connect_me/app.dart';
import 'package:equatable/equatable.dart';

class EducationModel extends Equatable {
  final String? school;
  final String? degree;
  final StartDateModel? startDate;
  final EndDateModel? endDate;
  final String? grade;
  final String? award;
  final String? activities;
  final String? docId;
  final String? createdAt;

  const EducationModel({
    this.school,
    this.degree,
    this.startDate,
    this.endDate,
    this.grade,
    this.award,
    this.activities,
    this.docId,
    this.createdAt,
  });

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(
      school: json['school'] as String?,
      degree: json['degree'] as String?,
      startDate: json['startDate'] == null
          ? null
          : StartDateModel.fromJson(json['startDate'] as Map<String, dynamic>),
      endDate: json['EndDate'] == null
          ? null
          : EndDateModel.fromJson(json['EndDate'] as Map<String, dynamic>),
      grade: json['grade'] as String?,
      award: json['award'] as String?,
      activities: json['activities'] as String?,
      docId: json['docId'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'school': school,
        'degree': degree,
        'startDate': startDate?.toJson(),
        'EndDate': endDate?.toJson(),
        'grade': grade,
        'award': award,
        'activities': activities,
        'docId': docId,
        'createdAt': createdAt,
      };

  EducationModel copyWith({
    String? school,
    String? degree,
    StartDateModel? startDate,
    EndDateModel? endDate,
    String? grade,
    String? award,
    String? activities,
    String? docId,
    String? createdAt,
  }) {
    return EducationModel(
      school: school ?? this.school,
      degree: degree ?? this.degree,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      grade: grade ?? this.grade,
      award: award ?? this.award,
      activities: activities ?? this.activities,
      docId: docId ?? this.docId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      school,
      degree,
      startDate,
      endDate,
      grade,
      award,
      activities,
      docId,
      createdAt,
    ];
  }
}
