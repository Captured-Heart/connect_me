enum FirebaseCollectionEnums {
  users('Users'),
  appData('appData'),
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
