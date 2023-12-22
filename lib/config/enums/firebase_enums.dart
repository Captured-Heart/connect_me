enum FirebaseCollectionEnums {
  users('Users'),
  accountInfo('Account info');

  const FirebaseCollectionEnums(this.value);
  final String value;
}

enum FirebaseDocsFieldEnums {
  deleted,
  docId,
  dateCreated,
  subtitle,
  title,
}
