import 'package:connect_me/app.dart';

class ProfileScreen1 extends ConsumerWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchProfileProvider);
    var socialIcons = profile.valueOrNull?.socialMediaHandles?.keys
        .map((e) => SocialDropdownEnum.values.firstWhere((element) => element.message == e))
        .toList();

    var socialIconMap = profile.valueOrNull?.socialMediaHandles?.entries
        .where((element) => element.key.contains(SocialDropdownEnum.values
            .firstWhere((elemen) => elemen.message == element.key)
            .message))
        .toList();

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image:
                  DecorationImage(image: AssetImage(ImagesConstant.qrCodeBG2), fit: BoxFit.cover),
            ),
          ),
          //
          Positioned(
            top: 50,
            width: context.sizeWidth(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const BackButton(
                  color: Colors.white,
                ),
                Text(
                  'Profile',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Chip(
                    backgroundColor: context.colorScheme.inversePrimary.withOpacity(0.4),
                    label: const Icon(shareIcon),
                    shape: const CircleBorder(),
                    side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          ),

          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                clipBehavior: Clip.none,
                height: context.sizeHeight(0.75),
                decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: profile.when(
                  data: (data) {
                    var addInfo = data.additionalDetails;
                    return ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                        children: [
                          CustomListTileWidget(
                            title: '${data.fname?.toTitleCase()} ${data.lname?.toTitleCase()}',
                            // subtitle: data.website,
                            subtitle: data.username,
                            showAtsign: true,
                            isSubtitleUrl: data.website,
                          ),
                          // Padding(
                          //   padding:  EdgeInsets.zero,
                          //   child: TextButton.icon(
                          //     onPressed: () {},
                          //     icon: Icon(HeroIcons.pencil_square),
                          //     label: Text(TextConstant.editProfile),
                          //   ),
                          // ),
                          //? SOCIAL MEDIA LINKS
                          SizedBox(
                            height: 40,
                            // width: context.sizeWidth(1),
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: socialIcons?.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var icons = socialIconsSwitch(socialIcons?[index]);
                                  var link = socialIconMap?[index].value;

                                  return CircleChipButton(
                                    iconData: icons,
                                    onTap: () {
                                      log('the link clicked is $link');
                                      UrlOptions.launchWeb(link).onError((error, stackTrace) {
                                        showScaffoldSnackBarMessage(error.toString(),
                                            isError: true);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),

                          //! bio section
                          Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                Text(
                                  data.bio ?? '',
                                  textScaleFactor: 0.9,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    data.phone?.isEmpty == true || data.phone == null
                                        ? const SizedBox.shrink()
                                        : IconAndTextWidget(
                                            text: '${data.phonePrefix}-${data.phone}',
                                            iconData: Icons.call_outlined,
                                            color: AppThemeColorDark.textButton,
                                            onTap: () {
                                              UrlOptions.makePhoneCall(
                                                  '${data.phonePrefix}${data.phone}');
                                            },
                                          ).padAll(10),
                                    data.email?.isEmpty == true || data.email == null
                                        ? const SizedBox.shrink()
                                        : Expanded(
                                            child: IconAndTextWidget(
                                              iconData: mailIcon,
                                              text: '${data.email}',
                                              color: AppThemeColorDark.textButton,
                                              onTap: () {
                                                UrlOptions.sendEmail(data.email ?? '');
                                              },
                                            ).padAll(10),
                                          ),
                                  ],
                                )
                              ],
                            ).padOnly(left: 10, right: 10, top: 10),
                          ),

                          Card(
                            elevation: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  TextConstant.additionalDetails,
                                ),
                                addInfo?.country?.isEmpty == true
                                    ? const SizedBox.shrink()
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AdditionalInfoListTileWidget(
                                            keys: FirebaseDocsFieldEnums.country.name.toTitleCase(),
                                            values: addInfo?.country ?? '',
                                          ),
                                          AdditionalInfoListTileWidget(
                                            keys: FirebaseDocsFieldEnums.state.name.toTitleCase(),
                                            values: addInfo?.state ?? '',
                                          ),
                                          AdditionalInfoListTileWidget(
                                            keys: FirebaseDocsFieldEnums.city.name.toTitleCase(),
                                            values: addInfo?.city ?? '',
                                          ),
                                        ].columnInPadding(3),
                                      ).padOnly(top: 8),
                                Column(
                                    children: [
                                  AdditionalInfoListTileWidget(
                                    keys: TextConstant.dateOfBirth,
                                    values: addInfo?.dateOfBirth ?? '',
                                  ),
                                  AdditionalInfoListTileWidget(
                                    keys: TextConstant.placeOfBirth,
                                    values: addInfo?.placeOfBirth ?? '',
                                  ),
                                  AdditionalInfoListTileWidget(
                                    keys: TextConstant.postalCode,
                                    values: addInfo?.postalCode ?? '',
                                  ),
                                  AdditionalInfoListTileWidget(
                                    keys: TextConstant.driverLicenseNo,
                                    values: addInfo?.driverLicenseNo ?? '',
                                  ),
                                ].columnInPadding(3)),
                              ],
                            ).padAll(12),
                          ),
                        ].columnInPadding(8));
                  },
                  error: (error, _) {
                    return Center(
                      child: Text(error.toString()),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),

              // the profile picture
              Positioned(
                top: -70,
                left: context.sizeWidth(0.15),
                right: context.sizeWidth(0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                profile.valueOrNull?.imgUrl ??
                                    ImagesConstant.noImagePlaceholderHttp,
                              ),
                            ),
                            border:
                                Border.all(color: context.theme.scaffoldBackgroundColor, width: 3),
                          ),
                          child: profile.valueOrNull?.imgUrl?.isEmpty == true ||
                                  profile.valueOrNull?.imgUrl == null
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : null,
                          // child: CachedNetworkImageWidget(imgUrl: profile.valueOrNull?.imgUrl, height: 100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AdditionalInfoListTileWidget extends StatelessWidget {
  const AdditionalInfoListTileWidget({
    super.key,
    required this.keys,
    required this.values,
  });

  final String keys, values;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$keys: ',
          textScaleFactor: 0.9,
        ),
        Expanded(
          child: AutoSizeText(
            values,
            style: context.textTheme.labelMedium,
            textScaleFactor: 0.9,
          ),
        ),
      ],
    );
  }
}

class IconAndTextWidget extends StatelessWidget {
  const IconAndTextWidget({
    super.key,
    required this.iconData,
    required this.text,
    this.color,
    this.onTap,
  });

  final String text;
  final IconData iconData;
  final Color? color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color ?? context.theme.iconTheme.color,
            size: 17,
          ),
          Flexible(
            child: AutoSizeText(
              text,
              maxLines: 1,
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: color ?? context.colorScheme.onBackground, fontSize: 11),
              minFontSize: 10,
              maxFontSize: 12,
              textScaleFactor: 0.9,
              // textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ].rowInPadding(10),
      ),
    );
  }
}
