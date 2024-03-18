import 'package:connect_me/app.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({
    super.key,
  });

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> with SingleTickerProviderStateMixin {
  final ValueNotifier<bool> gridLayout =
      ValueNotifier<bool>(SharedPreferencesHelper.getBoolPref(SharedKeys.myConnectLayout.name));
  late Animation<double> animation;
  late AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ref.watch(fetchContactsProvider.select((_) => _));

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
                    controller.reverse();
                    gridLayout.value = true;
                    SharedPreferencesHelper.setBoolPref(
                      SharedKeys.myConnectLayout.name,
                      value: !value,
                    );
                  } else {
                    controller.forward();
                    gridLayout.value = false;
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
              ).padOnly(right: 20),
            ],
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
