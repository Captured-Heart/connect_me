import 'package:connect_me/app.dart';

class EndDateModel extends Equatable {
  final String? endMonth;
  final String? endYear;
  String? get endDateMonthYearToString =>
      endMonth?.isEmpty == true || endMonth == null ? TextConstant.present : '$endMonth $endYear';

  const EndDateModel({this.endMonth, this.endYear});

  factory EndDateModel.fromJson(Map<String, dynamic> json) => EndDateModel(
        endMonth: json['endMonth'] as String?,
        endYear: json['endYear'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'endMonth': endMonth,
        'endYear': endYear,
      };

  EndDateModel copyWith({
    String? endMonth,
    String? endYear,
  }) {
    return EndDateModel(
      endMonth: endMonth ?? this.endMonth,
      endYear: endYear ?? this.endYear,
    );
  }

  @override
  List<Object?> get props => [endMonth, endYear];
}
