
import '../../../../app.dart';

class WorkExperienceModel extends Equatable {
  final String? title;
  final String? employmentType;

  final String? companyName;
  final String? location;
  final String? locationType;
  final String? docId;
  // final String? userId;
  final StartDateModel? startDate;
  final EndDateModel? endDate;
  final String? createdAt;
  final String? formTitle;

  const WorkExperienceModel({
    this.title,
    this.employmentType,
    this.companyName,
    this.location,
    this.locationType,
    this.docId,
    // this.userId,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.formTitle,
  });

  // String get startMonthYearToString => '${startDate?.month} ${startDate?.year}';
  // String get endDateMonthYearToString => endDate?.endMonth?.isEmpty == true || endDate?.endMonth == null ? TextConstant.present : '${endDate?.endMonth} ${endDate?.endYear}';

  factory WorkExperienceModel.fromJson(Map<String, dynamic> json) {
    return WorkExperienceModel(
      title: json['title'] as String?,
      employmentType: json['employmentType'] as String?,
      companyName: json['companyName'] as String?,
      location: json['location'] as String?,
      locationType: json['locationType'] as String?,
      docId: json['docId'] as String?,
      // userId: json['userId'] as String?,
      startDate: json['startDate'] != null ? StartDateModel.fromJson(json['startDate']) : null,
      endDate: json['endDate'] != null ? EndDateModel.fromJson(json['endDate']) : null,
      createdAt: json['createdAt'] as String?,
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
        // 'userId': userId,
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
    // String? userId,
    StartDateModel? startDate,
    EndDateModel? endDate,
    String? createdAt,
    String? formTitle,
  }) {
    return WorkExperienceModel(
      title: title ?? this.title,
      employmentType: employmentType ?? this.employmentType,
      companyName: companyName ?? this.companyName,
      location: location ?? this.location,
      locationType: locationType ?? this.locationType,
      docId: docId ?? this.docId,
      // userId: userId ?? this.userId,
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
      // userId,
      startDate,
      endDate,
      createdAt,
      formTitle,
    ];
  }
}

// class WorkExperienceModelType extends Equatable {
//   final WorkExperienceModel? workExperience;

//   const WorkExperienceModelType({
//     this.workExperience,
//   });

//   factory WorkExperienceModelType.fromJson(Map<String, dynamic> json) {
//     return WorkExperienceModelType(
//       workExperience: json['workExperience'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'workExperience': workExperience,
//       };

//   @override
//   List<Object?> get props {
//     return [workExperience];
//   }
// }
