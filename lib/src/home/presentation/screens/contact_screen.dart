import 'dart:math' hide log;

import 'package:flutter/services.dart';

import '../../../../app.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({
    super.key,
  });

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> with TickerProviderStateMixin {
  final ValueNotifier<bool> gridLayout =
      ValueNotifier<bool>(SharedPreferencesHelper.getBoolPref(SharedKeys.myConnectLayout.name));

  final ValueNotifier<bool> switchConnects = ValueNotifier<bool>(false);
  final ValueNotifier<int> slidableIndex = ValueNotifier<int>(0);

  late Animation<double> animation;
  late AnimationController controller;
  late SlidableController slidableController;
  bool isPermmited = true;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    initializeContact();
    slidableController = SlidableController(this);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  void initializeContact() async {
    isPermmited = await FetchDeviceContactRepository.initalizeContact();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // Map<String, List<Contact>> contactsByLetter = {};

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(fetchContactsProvider.select((_) => _));
    final contactLists = ref.watch(getContactListProvider);
    log('this is the connects number: ${contacts.valueOrNull?.where((element) => element.phone?.isNotEmpty == true).map((e) => e.phoneWithPrefix).toList()}');
    //
    // log('this is mapLetter: ${contactsByLetter.values.toList().indexWhere((element) => element.first.displayName.startsWith('H'))}');

    var listOfConnects = contacts.valueOrNull
        ?.where((element) => element.phone?.isNotEmpty == true)
        .map((e) => e.phoneWithPrefix)
        .toList();
    // log('this is the number in my device: ${contactLists.valueOrNull?.map((e) => e.phones.map((e) => e.normalizedNumber)).toList()}');
    return ListenableBuilder(
        listenable: Listenable.merge([gridLayout, switchConnects, slidableIndex]),
        builder: (context, _) {
          return Scaffold(
            appBar: switchConnects.value == true
                ? null
                : AppBar(
                    backgroundColor: context.theme.scaffoldBackgroundColor,
                    title: const Text(TextConstant.deviceContact),
                    actions: [
                      CircleChipButton(
                        iconData: Icons.add,
                        tooltip: 'Add contacts',
                        backgroundColor: AppThemeColorDark.successColor.withOpacity(0.2),
                        iconColor: AppThemeColorDark.successColor,
                        onTap: () => push(
                          context,
                          AddEditContactScreen(contact: Contact()),
                          ref: ref,
                          routeName: 'add/edit contact screen',
                        ),
                      ),
                      CircleChipButton(
                        iconData: Icons.switch_left_rounded,
                        tooltip: 'Switch contacts',
                        onTap: () {
                          switchConnects.value = !switchConnects.value;
                        },
                      ),
                    ].rowInPadding(10),
                  ),
            body: switchConnects.value == true
                ? ConnectGridAndListTileWidget(
                    gridLayout: gridLayout,
                    controller: controller,
                    animation: animation,
                    contacts: contacts,
                    ref: ref,
                    onTapSwitch: () {
                      switchConnects.value = !switchConnects.value;
                    },
                  )
                : Column(
                    children: [
                      //search and more button
                      SizedBox(
                        width: context.sizeWidth(1),
                        child: AuthTextFieldWidget(
                          hintText: 'Search Contacts'.hardCodedString,
                        ).padSymmetric(horizontal: 10),
                      ),

                      //Frequent Contacts
                      const FrequentContactsWidget().padOnly(top: 10, left: 10),

                      //the contacts
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isPermmited == false)
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Permission denied! \nAccept to view device contacts'
                                          .hardCodedString,
                                      textAlign: TextAlign.center,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        initializeContact();

                                        ref.invalidate(getContactListProvider);
                                        setState(() {});
                                      },
                                      child: Text('Accept Permission'.hardCodedString),
                                    ),
                                  ].columnInPadding(20),
                                ).padAll(20),
                              ),
                            Expanded(
                              child: contactLists.when(
                                data: (data) {
                                  if (isPermmited == false) {
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Permission denied! \nAccept to view device contacts'
                                                .hardCodedString,
                                            textAlign: TextAlign.center,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              initializeContact();

                                              ref.invalidate(getContactListProvider);
                                              setState(() {});
                                            },
                                            child: Text('Accept Permission'.hardCodedString),
                                          ),
                                        ].columnInPadding(20),
                                      ).padAll(20),
                                    );
                                  } else if (isPermmited == true) {
                                    if (data.isEmpty) {
                                      return const Center(
                                          child: CircularProgressIndicator.adaptive());
                                    }
                                  } else if (data.isEmpty) {
                                    return const Center(child: Text('No contacts'));
                                  }

                                  return ListView.builder(
                                    itemCount: data.keys.length,
                                    controller: scrollController,
                                    shrinkWrap: true,
                                    padding: AppEdgeInsets.eH8,
                                    itemBuilder: (context, sectionIndex) {
                                      String letter = data.keys.elementAt(sectionIndex);
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Category text
                                          Card(
                                            elevation: 2,
                                            child: SizedBox(
                                              width: context.sizeWidth(1),
                                              child: Text(
                                                letter,
                                                style: context.textTheme.titleLarge
                                                    ?.copyWith(fontSize: 18),
                                                textAlign: TextAlign.left,
                                              ).padOnly(left: 10),
                                            ),
                                          ).padSymmetric(vertical: 8),

                                          // the list of contacts by category

                                          ...List.generate(data[letter]?.length ?? 0, (index) {
                                            var contactInfo = data[letter]![index];
                                            bool isLastContact =
                                                data[letter]?.last == data[letter]![index];
                                            bool isFirstContact =
                                                data[letter]?.first == data[letter]![index];

                                            return Slidable(
                                              controller: index == slidableIndex.value
                                                  ? slidableController
                                                  : null,
                                              key: UniqueKey(),
                                              startActionPane: ActionPane(
                                                motion: const DrawerMotion(),
                                                children: [
                                                  const SlidableAction(
                                                    //edit contact action
                                                    flex: 2,
                                                    onPressed: null,
                                                    spacing: 4,
                                                    padding: EdgeInsets.zero,
                                                    backgroundColor: AppThemeColorDark.skyBlue,
                                                    foregroundColor: Colors.white,
                                                    icon: Icons.edit,
                                                    label: TextConstant.edit,
                                                  ),
                                                  SlidableAction(
                                                    //delete contact action
                                                    flex: 3,
                                                    onPressed: (_) {},
                                                    backgroundColor: AppThemeColorDark.textError,
                                                    foregroundColor: Colors.white,
                                                    icon: Icons.delete,
                                                    label: TextConstant.delete,
                                                  ),
                                                ],
                                              ),
                                              endActionPane: ActionPane(
                                                extentRatio: 0.45,
                                                motion: const DrawerMotion(),
                                                children: [
                                                  SlidableAction(
                                                    //send sms action
                                                    onPressed: (_) {
                                                      UrlOptions.sendSms(
                                                        contactInfo.phones.first.normalizedNumber
                                                                .isNotEmpty
                                                            ? contactInfo
                                                                .phones.first.normalizedNumber
                                                            : contactInfo.phones.first.number,
                                                      );
                                                    },
                                                    spacing: 4,
                                                    padding: EdgeInsets.zero,
                                                    backgroundColor: AppThemeColorDark.skyBlue,
                                                    foregroundColor: Colors.white,
                                                    icon: Icons.save,
                                                    label: TextConstant.sms.toTitleCase(),
                                                  ),
                                                  SlidableAction(
                                                    //make call action
                                                    onPressed: (_) {
                                                      UrlOptions.makePhoneCall(
                                                        contactInfo.phones.first.normalizedNumber
                                                                .isNotEmpty
                                                            ? contactInfo
                                                                .phones.first.normalizedNumber
                                                            : contactInfo.phones.first.number,
                                                      );
                                                    },
                                                    backgroundColor: AppThemeColorDark.successColor,
                                                    foregroundColor: Colors.white,
                                                    icon: Icons.call,
                                                    label: TextConstant.call,
                                                  ),
                                                ],
                                              ),
                                              child: DeviceContactListTile(
                                                  isLastContact: isLastContact,
                                                  isFirstContact: isFirstContact,
                                                  contactInfo: contactInfo,
                                                  listOfConnects: listOfConnects ?? [],
                                                  onTap: () {
                                                    slidableIndex.value = index;
                                                    slidableController.openEndActionPane();
                                                  },
                                                  onLongTap: () => push(
                                                        context,
                                                        AddEditContactScreen(
                                                          contact: contactInfo,
                                                        ),
                                                        ref: ref,
                                                        routeName: 'Add/Edit contact screen',
                                                      )

                                                  //  WoltModalSheet.show(
                                                  //   context: context,
                                                  //   pageListBuilder: (context) {
                                                  //     return [
                                                  //       themesModal(
                                                  //         modalSheetContext: context,
                                                  //         appDataModel: const AppDataModel(),
                                                  //       ),
                                                  //     ];
                                                  //   },
                                                  // ),
                                                  ),
                                            );
                                          }),
                                        ],
                                      );
                                    },
                                    // ),
                                  );
                                },
                                error: (error, _) => Center(
                                  child: Text(error.toString()),
                                ),
                                loading: () => const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: SizedBox(
                                height: context.sizeHeight(0.8),
                                child: AlphabetScrollbar(
                                  leftSidedOrTop: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                                  onLetterChange: (p0) {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}

class ConnectGridAndListTileWidget extends StatelessWidget {
  const ConnectGridAndListTileWidget({
    super.key,
    required this.gridLayout,
    required this.controller,
    required this.animation,
    required this.contacts,
    required this.ref,
    required this.onTapSwitch,
  });

  final ValueNotifier<bool> gridLayout;
  final AnimationController controller;
  final Animation<double> animation;
  final AsyncValue<List<AuthUserModel>> contacts;
  final WidgetRef ref;
  final VoidCallback onTapSwitch;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gridLayout,
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: const Text(TextConstant.myConnect),
            actions: [
              GestureDetector(
                onTap: () {
                  if (controller.status == AnimationStatus.completed) {
                    gridLayout.value = true;

                    controller.reverse();
                    SharedPreferencesHelper.setBoolPref(
                      SharedKeys.myConnectLayout.name,
                      value: !value,
                    );
                  } else {
                    gridLayout.value = false;

                    controller.forward();
                    SharedPreferencesHelper.setBoolPref(
                      SharedKeys.myConnectLayout.name,
                      value: !value,
                    );
                  }
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.list_view,
                  progress: animation,
                  size: 22.0,
                  semanticLabel: 'Show menu',
                ),
              ).padOnly(right: 5),
              CircleChipButton(
                iconData: Icons.switch_left_rounded,
                tooltip: 'Switch contacts',
                onTap: onTapSwitch,
                // () {
                //   switchConnects.value = !switchConnects.value;
                // },
              ),
            ].rowInPadding(10),
          ),

          // ContactListTile(contacts: contacts),

          body: contacts.when(
            data: (data) {
              return gridLayout.value == false
                  ? ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      padding: AppEdgeInsets.eH8,
                      itemBuilder: (context, index) {
                        return ContactListTile(
                          contacts: data[index],
                          onTap: () {
                            pushAsVoid(
                              context,
                              ref: ref,
                              routeName: ScreenName.profileOthersScreen,
                              ProfileScreenOthers(
                                users: data[index],
                                uuid: data[index].docId,
                              ),
                            );
                          },

                          // on call method
                          onCall: () {
                            if (data[index].phone?.isNotEmpty == true) {
                              UrlOptions.makePhoneCall(
                                '${data[index].phonePrefix}${data[index].phone!}',
                              );
                            } else {
                              showScaffoldSnackBarMessage(
                                'phone is not available',
                                isError: true,
                              );
                            }
                          },

                          //on show QR dialog
                          onViewQR: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Container(
                                    width: context.sizeWidth(0.75),
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.surface,
                                      borderRadius: AppBorderRadius.c12,
                                    ),
                                    child: PortraitQrCodeWidget(
                                      authUserModel: data[index],
                                      isStaticTheme: false,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  : GridView.count(
                      crossAxisCount: 3,
                      // shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) {
                          var contacts = data[index];

                          return GestureDetector(
                            onTap: () async {
                              pushAsVoid(
                                context,
                                ref: ref,
                                routeName: ScreenName.profileOthersScreen,
                                ProfileScreenOthers(
                                  users: contacts,
                                  uuid: contacts.docId,
                                ),
                              );
                            },
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ProfilePicWidget(
                                    withoutBorder: true,
                                    authUserModel: data[index],
                                    enlargeDP: false,
                                  ),
                                  AutoSizeText(
                                    contacts.fullname.toTitleCase(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    textScaleFactor: 0.9,
                                    textAlign: TextAlign.center,
                                  )
                                ].columnInPadding(3)),
                          );
                        },
                      ),
                    );
            },
            error: (error, _) {
              return const Center(child: Text(TextConstant.noUserFound));
            },
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      },
    );
  }
}

class FrequentContactsWidget extends StatelessWidget {
  const FrequentContactsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      height: 130,
      width: context.sizeWidth(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Frequent Contacts'.hardCodedString,
          ).padOnly(bottom: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var contactTrial = Contact(
                  displayName: 'okafor Johnson magnus fdtyudfudtut yufyufyku',
                  phones: [
                    Phone('a24534646'),
                  ],
                );
                return SizedBox(
                  // height: 150,
                  width: 120,
                  child: Card(
                    margin: AppEdgeInsets.eA4,
                    color: context.theme.cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: deviceContactImgLeadingWidget(
                            context,
                            contactInfo: contactTrial,
                            size: 0.8,
                          ).padOnly(left: 3, top: 2),
                        ),
                        Flexible(
                          child: AutoSizeText(
                            contactTrial.displayName,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 12,
                            maxFontSize: 15,
                            maxLines: 1,
                          ).padOnly(left: 7, top: 3),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleChipButton(
                              iconData: Icons.phone,
                              tooltip: 'Call'.hardCodedString,
                              padding: const EdgeInsets.all(5),
                              iconSize: 12,
                            ),
                            CircleChipButton(
                              iconData: Icons.phone,
                              tooltip: 'Call'.hardCodedString,
                              padding: const EdgeInsets.all(5),
                              iconSize: 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceContactListTile extends StatelessWidget {
  const DeviceContactListTile({
    super.key,
    required this.isLastContact,
    required this.contactInfo,
    required this.isFirstContact,
    required this.listOfConnects,
    this.onTap,
    this.onLongTap,
  });

  final bool isLastContact;
  final bool isFirstContact;
  final VoidCallback? onTap, onLongTap;

  final Contact contactInfo;
  final List<String?> listOfConnects;
  BorderRadius isFirstOrLastBorderRadius() {
    if (isFirstContact) {
      return const BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      );
    } else if (isLastContact) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      );
    } else {
      return BorderRadius.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: UnderlineInputBorder(
        borderRadius: isFirstOrLastBorderRadius(),
        borderSide: BorderSide(
          color: isLastContact ? Colors.transparent : context.colorScheme.onSurface,
          width: 0.5,
        ),
      ),
      color: context.theme.cardColor,
      child: ListTile(
        onTap: onTap,
        onLongPress: onLongTap,
        isThreeLine: false,
        dense: true,
        leading: deviceContactImgLeadingWidget(
          context,
          photoOrThumbnail: contactInfo.photoOrThumbnail,
          contactInfo: contactInfo,
        ),
        title: AutoSizeText(
          contactInfo.displayName,
          maxLines: 1,
          style: context.textTheme.bodyMedium?.copyWith(
              // fontWeight: AppFontWeight.w700,
              ),
        ),
        subtitle: AutoSizeText(
          contactInfo.phones.first.normalizedNumber.isNotEmpty
              ? contactInfo.phones.first.normalizedNumber
              : contactInfo.phones.first.number,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: 12,
            fontWeight: AppFontWeight.w700,
          ),
        ),
        trailing: listOfConnects.contains(contactInfo.phones.first.normalizedNumber) == false
            ? null
            : CircleAvatar(
                radius: 12,
                child: Center(
                  child: Image.asset(
                    ImagesConstant.appLogoBrown,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
      ),
    );
  }
}

Widget deviceContactImgLeadingWidget(
  BuildContext context, {
  Uint8List? photoOrThumbnail,
  required Contact contactInfo,
  double size = 1,
}) {
  return photoOrThumbnail != null
      ? Image.memory(
          contactInfo.photoOrThumbnail!,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => Container(
            height: 40 * size,
            width: 40 * size,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: child,
            // child: ui.Image.memory(data),
          ),
        )
      : CircleAvatar(
          backgroundColor: Colors.primaries.map((e) => e.shade100).toList()[Random().nextInt(14)],
          radius: 20 * size,
          child: Text(
            contactInfo.displayName[0],
            style: context.textTheme.titleLarge?.copyWith(
              color: Colors.black,
              fontWeight: AppFontWeight.w300,
            ),
          ),
        );
}

class ContactListTile extends StatelessWidget {
  const ContactListTile({
    super.key,
    required this.contacts,
    this.onTap,
    this.onCall,
    this.onViewQR,
  });

  final AuthUserModel contacts;
  final VoidCallback? onTap, onCall, onViewQR;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: AppEdgeInsets.eA8,
      child: ListTile(
        dense: true,
        onTap: onTap,
        contentPadding: const EdgeInsets.only(left: 10),
        leading: SizedBox(
          width: 45,
          height: 50,
          child: Hero(
            tag: contacts.imgUrl ?? 'imgUrl',
            child: CircleCacheNetworkImage(
              height: 50,
              width: 45,
              imgUrl: contacts.imgUrl ?? ImagesConstant.noImagePlaceholderHttp,
            ),
          ),
        ),
        title: AutoSizeText(contacts.fullname.toTitleCase()),
        subtitle: AutoSizeText(
          contacts.bio ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          minFontSize: 10,
        ),
        trailing: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleChipButton(
              iconData: Icons.call,
              onTap: onCall,
              tooltip: 'Call'.hardCodedString,
            ),
            CircleChipButton(
              iconData: Icons.qr_code_2,
              onTap: onViewQR,
              tooltip: 'View QR code',
            ),
          ],
        ),
      ),
    );
  }
}
