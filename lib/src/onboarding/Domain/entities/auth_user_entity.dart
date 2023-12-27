import 'package:connect_me/app.dart';
import 'package:equatable/equatable.dart';

class AuthUserModel extends Equatable {
  final String? username;
  final String? email;
  final String? website;

  final String? phone;
  final String? docId;
  final String? imgUrl;
  final String? bio;
  final String? phonePrefix;

  final String? fname;

  final String? lname;
  final bool? isGoogleSigned;
  final Timestamp? date;
  final List<dynamic>? connects;
  final List<dynamic>? posts;
  final Map<String, dynamic>? socials;
  final AdditionalDetailsModel? additionalDetails;

  // final String? placeOfBirth;
  // final String? country;
  // final String? state;
  // final String? city;
  // final String? street;
  // final String? driverLicenseNo;
  // final String? postalCode;

  const AuthUserModel({
    this.username,
    this.email,
    this.website,
    this.phone,
    this.docId,
    this.imgUrl,
    this.isGoogleSigned,
    this.date,
    this.connects,
    this.posts,
    this.socials,
    this.bio,
    this.fname,
    this.lname,
    this.phonePrefix,

    // this.placeOfBirth,
    // this.country,
    // this.state,
    // this.city,
    // this.street,
    // this.driverLicenseNo,
    // this.postalCode,
    this.additionalDetails,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => AuthUserModel(
        username: json['username'] as String?,
        fname: json['fname'] as String?,
        lname: json['lname'] as String?,
        email: json['email'] as String?,
        website: json['website'] as String?,
        phone: json['phone'] as String?,
        phonePrefix: json['phonePrefix'] as String?,
        docId: json['docId'] as String?,
        imgUrl: json['imgUrl'] as String?,
        bio: json['bio'] as String?,
        isGoogleSigned: json['isGoogleSigned'] as bool?,
        date: json['date'] as Timestamp?,
        connects: json['connects'] as List<dynamic>?,
        posts: json['posts'] as List<dynamic>?,
        socials: json['socials'] as Map<String, dynamic>?,
        // placeOfBirth: json['placeOfBirth'] as String?,
        // country: json['country'] as String?,
        // state: json['state'] as String?,
        // city: json['city'] as String?,
        // street: json['street'] as String?,
        // driverLicenseNo: json['driverLicenseNo'] as String?,
        // postalCode: json['postalCode'] as String?,
        additionalDetails: json['additionalDetails'] != null ? AdditionalDetailsModel.fromJson(json['additionalDetails']) : null,
      );

  Map<String, dynamic> toJson() => {
        'username': username ?? '',
        'email': email ?? '',
        'phone': phone ?? '',
        'docId': docId,
        'imgUrl': imgUrl,
        'isGoogleSigned': isGoogleSigned,
        'date': Timestamp.now(),
        'posts': posts,
        'connects': connects,
        'socials': socials,
        'bio': bio,
        'fname': fname,
        'lname': lname,
        'website': website,
        'phonePrefix': phonePrefix,
        // 'placeOfBirth': placeOfBirth,
        // 'country': country,
        // 'state': state,
        // 'city': city,
        // 'street': street,
        // 'driverLicenseNo': driverLicenseNo,
        // 'postalCode': postalCode,
        'additionalDetails': additionalDetails,
      };

  AuthUserModel copyWith({
    String? username,
    String? email,
    String? fname,
    String? lname,
    String? website,
    String? phone,
    String? phonePrefix,
    String? docId,
    String? imgUrl,
    String? bio,
    bool? isGoogleSigned,
    Timestamp? date,
    List<dynamic>? posts,
    List<dynamic>? connects,
    Map<String, dynamic>? socials,
    // String? placeOfBirth,
    // String? country,
    // String? state,
    // String? city,
    // String? street,
    // String? driverLicenseNo,
    // String? postalCode,
    AdditionalDetailsModel? additionalDetails,
  }) {
    return AuthUserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        docId: docId ?? this.docId,
        imgUrl: imgUrl ?? this.imgUrl,
        isGoogleSigned: isGoogleSigned ?? this.isGoogleSigned,
        date: date ?? this.date,
        connects: connects ?? this.connects,
        posts: posts ?? this.posts,
        socials: socials ?? this.socials,
        bio: bio ?? this.bio,
        fname: fname ?? this.fname,
        lname: lname ?? this.lname,
        website: website ?? this.website,
        phonePrefix: phonePrefix ?? this.phonePrefix,
        // placeOfBirth: placeOfBirth ?? this.placeOfBirth,
        // country: country ?? this.country,
        // state: state ?? this.state,
        // city: city ?? this.city,
        // street: street ?? this.street,
        // driverLicenseNo: driverLicenseNo ?? this.driverLicenseNo,
        // postalCode: postalCode ?? this.postalCode,
        additionalDetails: additionalDetails ?? this.additionalDetails);
  }

  @override
  List<Object?> get props => [
        username,
        email,
        phone,
        docId,
        imgUrl,
        isGoogleSigned,
        date,
        connects,
        posts,
        socials,
        bio,
        lname,
        fname,
        website,
        phonePrefix,
        // placeOfBirth,
        // country,
        // state,
        // city,
        // street,
        // driverLicenseNo,
        // postalCode,
        additionalDetails
      ];
}
