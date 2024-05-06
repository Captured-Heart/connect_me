import 'package:connect_me/app.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class FetchDeviceContactRepository {
  // See installation notes below regarding AndroidManifest.xml and Info.plist
  var permission = FlutterContacts.requestPermission();
  // late Future<bool> permission;

  static Future<bool> initalizeContact() async {
    var permission = await FlutterContacts.requestPermission();
    if (permission == true) {
      await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
    }
    return permission;
  }

  Future<List<Contact>> getContactsList() async {
    if (await permission == true) {
      List<Contact> contacts =
          await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
      return contacts;
    }
    return [];
  }

  Future<Contact?> getContact(Contact contacts) async {
    if (await permission == true) {
      Contact? contact = await FlutterContacts.getContact(contacts.id);
      return contact;
    }
    return null;
  }

  Future<Contact> addNewContact(Contact newContact) async {
    return await newContact.insert();
  }

  Future<Contact> updateContact(Contact newContact) async {
    return await newContact.update();
  }

  void listenToContactsDBChanges() =>
      FlutterContacts.addListener(() => print('Contact DB changed'));

  // Open external contact app to view/edit/pick/insert contacts.
  // await FlutterContacts.openExternalView(contact.id);
  // await FlutterContacts.openExternalEdit(contact.id);
  // final contact = await FlutterContacts.openExternalPick();
  // final contact = await FlutterContacts.openExternalInsert();
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
