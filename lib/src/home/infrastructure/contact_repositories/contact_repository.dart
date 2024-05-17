import '../../../../app.dart';

class FetchDeviceContactRepository {
  // See installation notes below regarding AndroidManifest.xml and Info.plist
  var permission = FlutterContacts.requestPermission();
  // late Future<bool> permission;

  static Future<bool> initalizeContact() async {
    var permission = await FlutterContacts.requestPermission();
    if (permission == true) {
      await FlutterContacts.getContacts(withProperties: true, withPhoto: true, withAccounts: true);
    }
    return permission;
  }

  Future<List<Contact>> getContactsList() async {
    if (await permission == true) {
      List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true, withAccounts: true);
      return contacts;
    }
    return [];
  }

  Future<Contact?> getContact(Contact contacts) async {
    if (await permission == true) {
      Contact? contact = await FlutterContacts.getContact(contacts.id, withAccounts: true);
      return contact;
    }
    return null;
  }

  Future<Contact> addNewContact(Contact newContact) async {
    try {
      return await newContact.insert();
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<Contact> updateContact(Contact newContact) async {
    try {
      return await newContact.update(withGroups: true);
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<void> deleteContact(Contact newContact) async {
    try {
      return await newContact.delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void listenToContactsDBChanges() =>
      FlutterContacts.addListener(() => print('Contact DB changed'));
}

final getContactFromDeviceProvider = Provider<FetchDeviceContactRepository>((ref) {
  return FetchDeviceContactRepository();
});

final getContactListProvider = FutureProvider<Map<String, List<Contact>>>(
  (ref) async {
    Map<String, List<Contact>> contactsByLetter = {};
    var contactLists = await FetchDeviceContactRepository().getContactsList();
    for (var contact in contactLists
        .where((element) => element.displayName.isNotEmpty && element.phones.isNotEmpty)) {
      String? firstLetter;
      for (var rune in contact.displayName.runes) {
        try {
          firstLetter = String.fromCharCode(rune).toUpperCase();
          break;
        } catch (e) {
          // If the character is not a well-formed UTF-16 character,
          // continue to the next character.
          continue;
        }
      }

      if (firstLetter != null && firstLetter.isNotEmpty) {
        if (contactsByLetter.containsKey(firstLetter)) {
          contactsByLetter[firstLetter]?.add(contact);
        } else {
          contactsByLetter[firstLetter] = [contact];
        }
      }
    }

    return contactsByLetter;
  },
  name: 'Get Device Contacts Provider',
);

class AddEditNotifier extends AutoDisposeNotifier<AsyncValue> {
  late FetchDeviceContactRepository fetchDeviceContactRepository;

  @override
  AsyncValue build() {
    fetchDeviceContactRepository = ref.read(getContactFromDeviceProvider);
    return state = const AsyncValue.data(null);
  }

  Future<void> addContact(Contact newContact) async {
    state = const AsyncValue.loading();
    var contact =
        await fetchDeviceContactRepository.addNewContact(newContact).onError((error, stackTrace) {
      throw state = AsyncValue.error(error!, stackTrace);
    });

    state = AsyncValue.data(contact);
  }

  //edit contact
  Future<void> updateContact(Contact newContact) async {
    state = const AsyncValue.loading();
    var contact =
        await fetchDeviceContactRepository.updateContact(newContact).onError((error, stackTrace) {
      throw state = AsyncValue.error(error!, stackTrace);
    });
    state = AsyncValue.data(contact);
  }

//delete contact
  Future<void> deleteContact(Contact newContact) async {
    state = const AsyncValue.loading();
    await fetchDeviceContactRepository.deleteContact(newContact).onError((error, stackTrace) {
      throw state = AsyncValue.error(error!, stackTrace);
    });
    state = const AsyncValue.data('Deleted sucessfully');
  }
}

final addEditNotifierProvider =
    AutoDisposeNotifierProvider<AddEditNotifier, AsyncValue>(AddEditNotifier.new);
