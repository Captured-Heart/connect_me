import 'package:equatable/equatable.dart';

class StartDateModel extends Equatable {
  final String? month;
  final String? year;

  const StartDateModel({this.month, this.year});

  factory StartDateModel.fromJson(Map<String, dynamic> json) {
    return StartDateModel(
      month: json['month'] as String?,
      year: json['year'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'month': month,
        'year': year,
      };

  StartDateModel copyWith({
    String? month,
    String? year,
  }) {
    return StartDateModel(
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  String get startMonthYearToString => '$month $year';
  @override
  List<Object?> get props => [month, year];
}
