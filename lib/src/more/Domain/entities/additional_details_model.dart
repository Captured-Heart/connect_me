import 'package:connect_me/app.dart';
import 'package:equatable/equatable.dart';

class AdditionalDetailsModel extends Equatable {
  final String? dateOfBirth;
  final String? placeOfBirth;
  final String? country;
  final String? state;
  final String? city;
  final String? street;
  final String? driverLicenseNo;
  final String? postalCode;
  final String? docId;
  final Timestamp? createdAt;

  const AdditionalDetailsModel({
    this.dateOfBirth,
    this.placeOfBirth,
    this.country,
    this.state,
    this.city,
    this.street,
    this.driverLicenseNo,
    this.postalCode,
    this.docId,
    this.createdAt,
  });

  factory AdditionalDetailsModel.fromJson(Map<String, dynamic> json) {
    return AdditionalDetailsModel(
      dateOfBirth: json['dateOfBirth'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      country: json['country'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      driverLicenseNo: json['driverLicenseNo'] as String?,
      postalCode: json['postalCode'] as String?,
      docId: json['docId'] as String?,
      createdAt: json['createdAt'] as Timestamp?,
    );
  }

  Map<String, dynamic> toJson() => {
        'dateOfBirth': dateOfBirth,
        'placeOfBirth': placeOfBirth,
        'country': country,
        'state': state,
        'city': city,
        'street': street,
        'driverLicenseNo': driverLicenseNo,
        'postalCode': postalCode,
        'docId': docId,
        'createdAt': Timestamp.now(),
      };

  AdditionalDetailsModel copyWith({
    String? dateOfBirth,
    String? placeOfBirth,
    String? country,
    String? state,
    String? city,
    String? street,
    String? driverLicenseNo,
    String? postalCode,
    String? docId,
    Timestamp? createdAt,
  }) {
    return AdditionalDetailsModel(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      street: street ?? this.street,
      driverLicenseNo: driverLicenseNo ?? this.driverLicenseNo,
      postalCode: postalCode ?? this.postalCode,
      docId: docId ?? this.docId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      dateOfBirth,
      placeOfBirth,
      country,
      state,
      city,
      street,
      driverLicenseNo,
      postalCode,
      docId,
      createdAt,
    ];
  }
}
