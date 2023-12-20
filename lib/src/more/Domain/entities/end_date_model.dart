import 'package:equatable/equatable.dart';

class EndDateModel extends Equatable {
  final String? month;
  final String? year;

  const EndDateModel({this.month, this.year});

  factory EndDateModel.fromJson(Map<String, dynamic> json) => EndDateModel(
        month: json['month'] as String?,
        year: json['year'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'month': month,
        'year': year,
      };

  EndDateModel copyWith({
    String? month,
    String? year,
  }) {
    return EndDateModel(
      month: month ?? this.month,
      year: year ?? this.year,
    );
  }

  @override
  List<Object?> get props => [month, year];
}
