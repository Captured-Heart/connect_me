import 'package:connect_me/app.dart';

class ProfileScreen1 extends ConsumerWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(fetchProfileProvider);
    var socialIcons = profile.valueOrNull?.socialMediaHandles?.keys
        .map((e) => SocialDropdownEnum.values
            .firstWhere((element) => element.message == e))
        .toList();

    var socialIconMap = profile.valueOrNull?.socialMediaHandles?.entries
        .where((element) => element.key.contains(SocialDropdownEnum.values
            .firstWhere((elemen) => elemen.message == element.key)
            .message))
        .toList();
    final workExperience = ref.watch(fetchWorkListProvider('')).valueOrNull;
    final educationExperience =
        ref.watch(fetchEducationListProvider('')).valueOrNull;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImagesConstant.qrCodeBG2),
                  fit: BoxFit.cover),
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
                    backgroundColor:
                        context.colorScheme.inversePrimary.withOpacity(0.4),
                    label: const Icon(shareIcon),
                    shape: const CircleBorder(),
                    side: BorderSide(
                        width: 0.5, color: context.colorScheme.onSurface),
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
                height: context.sizeHeight(0.68),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 55, horizontal: 20),
                      children: [
                        CustomListTileWidget(
                          title:
                              '${data.fname?.toTitleCase()} ${data.lname?.toTitleCase()}',
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
                        socialIcons?.isEmpty == true  ? const SizedBox.shrink():
                        SizedBox(
                          height: 60,
                          // width: context.sizeWidth(1),
                          child: Center(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: socialIcons?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var icons =
                                    socialIconsSwitch(socialIcons?[index]);
                                var link = socialIconMap?[index].value;

                                return CircleChipButton(
                                  iconData: icons,
                                  tooltip: socialIcons?[index].message ?? '',
                                  onTap: () {
                                    log('the link clicked is $link');
                                    UrlOptions.launchWeb(link,
                                            launchModeEXT: true)
                                        .onError((error, stackTrace) {
                                      showScaffoldSnackBarMessage(
                                          error.toString(),
                                          isError: true);
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),

                        //! Bio details widget
                        BioDetailsWidget(users: profile.valueOrNull),

                        //! additional details

                        addInfo == null
                            ? const SizedBox.shrink()
                            : AdditionalDetailsCardWidget(addInfo: addInfo),

                        workExperience == null
                            ? const SizedBox.shrink()
                            : WorkDetailsCardWidget(
                                workExperienceModel: workExperience),
                        educationExperience == null ||
                                educationExperience.isEmpty
                            ? const SizedBox.shrink()
                            : EdiucationDetailsCardWidget(
                                educationModel: educationExperience),
                      ],
                    );
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
                top: -60,
                left: context.sizeWidth(0.15),
                right: context.sizeWidth(0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                profile.valueOrNull?.imgUrl ??
                                    ImagesConstant.noImagePlaceholderHttp,
                              ),
                            ),
                            border: Border.all(
                                color: context.colorScheme.primaryContainer,
                                width: 3),
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
