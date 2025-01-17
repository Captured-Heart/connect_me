import '../../../../app.dart';

final educationIndexNotifier = StateProvider<int>((ref) {
  return 0;
});

final workExpIndexNotifier = StateProvider<int>((ref) {
  return 0;
});

class MoreScreen extends ConsumerStatefulWidget {
  const MoreScreen({super.key});

  @override
  ConsumerState<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends ConsumerState<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    final appdata = ref.watch(fetchAppDataProvider);
    final authUserData = ref.watch(fetchProfileProvider).valueOrNull;
    final educationList = ref.watch(fetchEducationListProvider('')).valueOrNull;
    final workExpList = ref.watch(fetchWorkListProvider('')).valueOrNull;

    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: [
              // MY ACCOUNT
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(TextConstant.yourAccount),
                  ),
                ],
              ),
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: accountCircleIcon,
                      title: TextConstant.accountInformation,
                      subtitle: TextConstant.nameDisplayPicture,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              accountInformationModal(context, context.textTheme, authUserData),
                            ];
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              // DottedLineDividerWidget(),

//! ADDITIONAL DETAILS
              const Text(TextConstant.otherInformation),

              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: additionalDetailsIcon,
                      title: TextConstant.additionalDetails,
                      subtitle: TextConstant.addressCareerEtc,
                      trailingWidget: authUserData?.isAdditionalDetailsEmpty == true
                          ? Icon(
                              warningIcon,
                              color: context.colorScheme.tertiary,
                            )
                          : null,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              additionalInfoModal(context, authUserData),
                            ];
                          },
                        );
                      },
                    ),

                    // EDUCATION
                    MoreCustomListTileWidget(
                      icon: educationCapIcon,
                      title: TextConstant.education,
                      trailingWidget: educationList == null || educationList.isEmpty
                          ? Icon(
                              warningIcon,
                              color: context.colorScheme.tertiary,
                            )
                          : null,
                      onTap: () {
                        ValueNotifier<int>? pageIndexNotifier = ValueNotifier<int>(0);

                        WoltModalSheet.show(
                          context: context,
                          pageIndexNotifier: pageIndexNotifier,
                          pageListBuilder: (context) {
                            // ValueNotifier<int> educationIndexNotifier = ValueNotifier<int>(0);

                            return [
                              educationList?.isNotEmpty == true
                                  ? educationListTile(
                                      context,
                                      // educationList: educationList,
                                      pageIndexNotifier: pageIndexNotifier,
                                    )
                                  : educationModal(
                                      context,
                                      context.textTheme,
                                      pageIndexNotifier: pageIndexNotifier,
                                    ),

                              // [Page 2], this is the modal with data from firebase
                              educationModal(
                                context,
                                context.textTheme,
                                pageIndexNotifier: pageIndexNotifier,
                                // educationModel: educationList,
                                onPop: () {
                                  pageIndexNotifier.value = pageIndexNotifier.value - 1;
                                },
                              ),
                              // this is the modal without the data from firebase, [page3]
                              educationModal(
                                context,
                                context.textTheme,
                                isEditMode: true,
                                pageIndexNotifier: pageIndexNotifier,
                                onPop: () {
                                  pageIndexNotifier.value = pageIndexNotifier.value - 2;
                                },
                              ),
                            ];
                          },
                        );
                      },
                    ),

                    // WORK EXPERIENCE
                    MoreCustomListTileWidget(
                      icon: workExperienceIcon,
                      title: TextConstant.workExperience,
                      trailingWidget: workExpList == null || workExpList.isEmpty
                          ? Icon(
                              warningIcon,
                              color: context.colorScheme.tertiary,
                            )
                          : null,
                      onTap: () {
                        ValueNotifier<int>? pageIndexNotifier = ValueNotifier<int>(0);

                        WoltModalSheet.show(
                          context: context,
                          pageIndexNotifier: pageIndexNotifier,
                          pageListBuilder: (context) {
                            return [
                              workExpList?.isNotEmpty == true
                                  ? workExperienceListTile(
                                      context,
                                      pageIndexNotifier: pageIndexNotifier,
                                    )
                                  : workExperienceModal(
                                      context,
                                      context.textTheme,
                                      pageIndexNotifier: pageIndexNotifier,
                                    ),

                              // [Page 2], this is the modal with data from firebase
                              workExperienceModal(
                                context,
                                context.textTheme,
                                pageIndexNotifier: pageIndexNotifier,
                                onPop: () {
                                  pageIndexNotifier.value = pageIndexNotifier.value - 1;
                                },
                              ),
                              //this is the modal without the data from firebase, [page3]
                              workExperienceModal(
                                context,
                                context.textTheme,
                                pageIndexNotifier: pageIndexNotifier,
                                isEditMode: true,
                                onPop: () {
                                  pageIndexNotifier.value = pageIndexNotifier.value - 2;
                                },
                              )
                            ];
                          },
                        );
                      },
                    ),

                    //SOCIAL MEDIA EXPERIENCE
                    MoreCustomListTileWidget(
                      icon: socialMediaIcon,
                      title: TextConstant.socialMediaHandles,
                      trailingWidget: authUserData?.isSocialMediaEmpty == true
                          ? Icon(
                              warningIcon,
                              color: context.colorScheme.tertiary,
                            )
                          : null,
                      onTap: () {
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              socialMediaModal(
                                context,
                                socialMediaModel: authUserData?.socialMediaHandles,
                              ),
                            ];
                          },
                        );
                      },
                    ),
                  ],
                ).padOnly(bottom: 7),
              ),
              // DottedLineDividerWidget(),

// ! FEEDBACKS
              const Text(TextConstant.helpCenter247),
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: twitterIcon,
                      title: '${TextConstant.twitter} (X)',
                      subtitle: TextConstant.tellUsHowWeCanHelpYouOnX,
                      onTap: () {
                        ref
                            .read(helpCenterImplProvider)
                            .contactTwitter(appdata.valueOrNull?.twitterSupport ?? '')
                            .onError((error, stackTrace) {
                          showScaffoldSnackBarMessageNoColor(
                            TextConstant.currentlyUnavailable,
                            context: context,
                            isError: true,
                            appearsBottom: false,
                          );
                        });
                      },
                    ),

                    MoreCustomListTileWidget(
                      icon: whatsappIcon,
                      title: TextConstant.whatsapp,
                      subtitle: TextConstant.chatWithUsOnWhatsapp,
                      onTap: () {
                        ref
                            .read(helpCenterImplProvider)
                            .contactWhatsapp(appdata.valueOrNull?.whatsappSupport ?? '')
                            .onError((error, stackTrace) {
                          showScaffoldSnackBarMessageNoColor(
                            TextConstant.currentlyUnavailable,
                            context: context,
                            isError: true,
                            appearsBottom: false,
                          );
                        });
                      },
                    ),

                    //

                    MoreCustomListTileWidget(
                      icon: mailIcon,
                      title: TextConstant.email,
                      subtitle: TextConstant.getYourSolutionsViaEmail,
                      onTap: () {
                        ref
                            .read(helpCenterImplProvider)
                            .contactEmail(appdata.valueOrNull?.emailSupport ?? '')
                            .onError((error, stackTrace) {
                          showScaffoldSnackBarMessageNoColor(
                            TextConstant.currentlyUnavailable,
                            context: context,
                            isError: true,
                            appearsBottom: false,
                          );
                        });
                      },
                    ),
                  ],
                ).padOnly(bottom: 7, top: 4),
              ),

              //! CONTACT DEVELOPER
              const Text(TextConstant.contactDev),
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //? CONTACT DEV EMAIL
                    MoreCustomListTileWidget(
                      icon: mailIcon,
                      title: TextConstant.emailToDeveloper,
                      subtitle: TextConstant.sendMailToDev,
                      onTap: () {
                        ref
                            .read(helpCenterImplProvider)
                            .contactEmail(appdata.valueOrNull?.devEmail ?? '')
                            .onError((error, stackTrace) {
                          showScaffoldSnackBarMessageNoColor(
                            TextConstant.currentlyUnavailable,
                            context: context,
                            isError: true,
                            appearsBottom: false,
                          );
                        });
                      },
                    ),

                    //? CONTACT DEV TWITTER
                    MoreCustomListTileWidget(
                      icon: twitterIcon,
                      title: TextConstant.developerOnTwitter,
                      subtitle: "@${TextConstant.capturedHeart}",
                      onTap: () {
                        ref
                            .read(helpCenterImplProvider)
                            .contactDevTwitter(appdata.valueOrNull?.devTwitter ?? '')
                            .onError((error, stackTrace) {
                          showScaffoldSnackBarMessageNoColor(
                            TextConstant.currentlyUnavailable,
                            context: context,
                            isError: true,
                            appearsBottom: false,
                          );
                        });
                      },
                    ),
                  ],
                ).padOnly(bottom: 7, top: 4),
              ),
              //

              //! SETTINGS
              const Text('Settings'),
              Card(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: privacyIcon,
                      title: 'Account Privacy',
                      onTap: () {
                        ref
                            .read(helpCenterImplProvider)
                            .viewPrivacyPolicy(appdata.valueOrNull?.privacyPolicyLink ?? '')
                            .onError((error, stackTrace) {
                          showScaffoldSnackBarMessageNoColor(
                            TextConstant.currentlyUnavailable,
                            context: context,
                            isError: true,
                            appearsBottom: false,
                          );
                        });
                      },
                    ),
                    //

                    appdata.value?.allowDonate == false
                        ? const SizedBox.shrink()
                        : MoreCustomListTileWidget(
                            icon: supportMoneyIcon,
                            title: TextConstant.donate,
                            onTap: () {
                              WoltModalSheet.show(
                                context: context,
                                pageListBuilder: (context) {
                                  return [
                                    supportModal(
                                      modalSheetContext: context,
                                      appDataModel: appdata.valueOrNull,
                                    ),
                                  ];
                                },
                              );
                            },
                          ),
                    MoreCustomListTileWidget(
                      icon: licensesIcon,
                      title: 'Licenses'.hardCodedString,
                      onTap: () {
                        showLicensePage(
                          context: context,
                          applicationVersion: 'v${appdata.valueOrNull?.appVersionNumber}',
                          applicationIcon: Image.asset(
                            ImagesConstant.appLogoBrown,
                            height: 50,
                          ),
                        );
                      },
                    ),
                    MoreCustomListTileWidget(
                      icon: Icons.sunny,
                      title: TextConstant.theme,
                      onTap: () {
                        // ref.read(themeProvider(context).notifier).setThemeMode(ThemeMode.dark);
                        WoltModalSheet.show(
                          context: context,
                          pageListBuilder: (context) {
                            return [
                              themesModal(
                                modalSheetContext: context,
                                appDataModel: appdata.valueOrNull,
                              ),
                            ];
                          },
                        );
                      },
                    ),
                  ],
                ).padOnly(bottom: 7, top: 4),
              ),

              const Text(TextConstant.logOut),
              Card(
                // color: context.colorScheme.primaryContainer,
                elevation: 2,
                child: MoreCustomListTileWidget(
                  icon: logOutIcon,
                  title: TextConstant.logOut,
                  color: Colors.transparent,
                  // foregroundColor: AppThemeColorDark.textDark,
                  onTap: () {
                    warningDialogs(
                      context: context,
                      dialogModel: DialogModel(
                        title: 'Are you sure you want to log out?'.hardCodedString,
                        content: null,
                        onPostiveAction: () {
                          pop(context);
                          ref.read(logOutNotifierProvider.notifier).signOutUsers();
                        },
                      ),
                    );
                  },
                ),
              ),
// delete account
              Card(
                color: AppThemeColorDark.textError,
                elevation: 2,
                child: MoreCustomListTileWidget(
                  icon: deleteIcon,
                  title: TextConstant.deleteAccount,
                  color: Colors.transparent,
                  foregroundColor: AppThemeColorDark.textDark,
                  onTap: () {
                    WoltModalSheet.show(
                      context: context,
                      pageListBuilder: (context) {
                        return [
                          deleteAccountModal(
                            modalSheetContext: context,
                            authUserModel: authUserData,
                            //   onDeleteBTN: () {
                            // ref.read(deleteAccountInfoProvider.notifier).deleteAccountPermanently(email: authUserData.email , uuid: uuid)
                            //   },
                          ),
                        ];
                      },
                    );
                  },
                ),
              ),
              Center(child: Text('Version ${appdata.valueOrNull?.appVersionNumber ?? ''}'))
              // DottedLineDividerWidget(),
            ].columnInPadding(10)),
      ),
    );
  }
}
