enum FirebaseCollectionEnums {
  users('Users'),
  appData('appData'),
  accountInfo('account_information'),
  additionalDetails('additional_details'),
  connects('connects');

  const FirebaseCollectionEnums(this.value);
  final String value;
}

enum FirebaseDocsFieldEnums {
  deleted,
  docId,
  dateCreated,
  subtitle,
  title,
  username,
  email,
  website,
  phone,
  phonePrefix,
  imgUrl,
  isGoogleSigned,
  date,
  connects,
  posts,
  socials,
  bio,
  fname,
  lname,
  dateOfBirth,
  placeOfBirth,
  country,
  state,
  city,
  street,
  driverLicenseNo,
  postalCode,
  createdAt,
  additionalDetails,
}
