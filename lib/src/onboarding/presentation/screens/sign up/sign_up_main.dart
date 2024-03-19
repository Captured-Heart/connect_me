import 'package:connect_me/app.dart';

class SignUpMainScreen extends ConsumerStatefulWidget {
  const SignUpMainScreen({super.key});

  @override
  ConsumerState<SignUpMainScreen> createState() => _SignUpMainScreenState();
}

class _SignUpMainScreenState extends ConsumerState<SignUpMainScreen> {
  @override
  Widget build(BuildContext context) {
    final authUserData = ref.watch(fetchProfileProvider).valueOrNull;
    final education = ref.watch(fetchEducationListProvider('')).valueOrNull;
    final workExperience = ref.watch(fetchWorkListProvider('')).valueOrNull;
    // inspect(education);
    log('''education $authUserData,       work_experience: $workExperience''');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(' Complete '.hardCodedString + TextConstant.signUp),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTileWidget(
                    title: 'To complete your sign up: '.hardCodedString,
                    subtitle:
                        '*The following sections needs to be filled up. \n\n*Account information is compulsory to complete registration while others are optional.'
                            .hardCodedString,
                    subtitleTextAlign: TextAlign.start,
                    subtitleMaxLines: 4,
                  ),
                  Column(
                      children: [
                    Card(
                      elevation: 2,
                      child: MoreCustomListTileWidget(
                        title: TextConstant.accountInformation,
                        trailingWidget: authUserData?.completedSignUp == true
                            ? const Icon(
                                checkCircleIcon,
                                color: AppThemeColorDark.successColor,
                              )
                            : null,
                        onTap: authUserData?.completedSignUp == true
                            ? () {
                                showScaffoldSnackBarMessage(
                                  '"Account information" is completed and can only be edited when logged in'
                                      .hardCodedString,
                                  duration: 5,
                                  isError: true,
                                );
                              }
                            : () {
                                push(
                                  context,
                                  const AccountInformationSignUpScreen(),
                                  ref: ref,
                                  routeName: ScreenName.accountInformationSignUpScreen,
                                );
                              },
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: MoreCustomListTileWidget(
                        title: TextConstant.education,
                        trailingWidget: education?.isEmpty == true || education == null
                            ? null
                            : const Icon(
                                checkCircleIcon,
                                color: AppThemeColorDark.successColor,
                              ),
                        onTap: education?.isEmpty == true || education == null
                            ? () {
                                pushAsVoid(
                                  context,
                                  const EducationInfoSignUpScreen(),
                                  ref: ref,
                                  routeName: ScreenName.educationInfoSignUpScreen,
                                );
                              }
                            : () {
                                showScaffoldSnackBarMessage(
                                  '"Education" is completed and can only be edited on logged in',
                                  duration: 5,
                                  isError: true,
                                );
                              },
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: MoreCustomListTileWidget(
                        title: TextConstant.workExperience,
                        trailingWidget: workExperience?.isEmpty == true || workExperience == null
                            ? null
                            : const Icon(
                                checkCircleIcon,
                                color: AppThemeColorDark.successColor,
                              ),
                        onTap: workExperience?.isEmpty == true || workExperience == null
                            ? () {
                                push(
                                  context,
                                  const WorkExperienceSignUpScreen(),
                                  ref: ref,
                                  routeName: ScreenName.workExperienceSignUpScreen,
                                );
                              }
                            : () {
                                showScaffoldSnackBarMessage(
                                  '"Work experience" is completed and can only be edited when logged in'
                                      .hardCodedString,
                                  duration: 5,
                                  isError: true,
                                );
                              },
                      ),
                    ),
                    Card(
                      elevation: 2,
                      child: MoreCustomListTileWidget(
                          title: TextConstant.socialMediaHandles,
                          trailingWidget: authUserData?.socialMediaHandles?.isEmpty == true ||
                                  authUserData?.socialMediaHandles == null
                              ? null
                              : const Icon(
                                  checkCircleIcon,
                                  color: AppThemeColorDark.successColor,
                                ),
                          onTap: authUserData?.socialMediaHandles?.isEmpty == true ||
                                  authUserData?.socialMediaHandles == null
                              ? () {
                                  pushAsVoid(
                                    context,
                                    const SocialMediaSignUpScreen(),
                                    ref: ref,
                                    routeName: ScreenName.socialMediaSignUpScreen,
                                  );
                                }
                              : () {
                                  showScaffoldSnackBarMessage(
                                    '"Social Media handles" is completed and can only be edited when logged in'
                                        .hardCodedString,
                                    duration: 5,
                                    isError: true,
                                  );
                                }),
                    ),
                  ].columnInPadding(10)),
                ].columnInPadding(20),
              ).padAll(20),
            ),

            //! THE BUTTONS
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //skip button
                authUserData?.completedSignUp == false
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        onPressed: () {
                          pushReplacement(
                            context,
                            const MainScreen(),
                            ref: ref,
                            routeName: ScreenName.mainScreen,
                          );
                        },
                        child: Text('Skip'.hardCodedString),
                      ),

                //complete button
                ElevatedButton(
                  onPressed: authUserData?.completedSignUp == true &&
                          (education?.isNotEmpty == true || education != null) &&
                          (workExperience?.isNotEmpty == true || workExperience != null) &&
                          (authUserData?.socialMediaHandles?.isNotEmpty == true ||
                              authUserData?.socialMediaHandles != null)
                      ? () {
                          pushReplacement(
                            context,
                            const MainScreen(),
                            ref: ref,
                            routeName: ScreenName.mainScreen,
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemeColorDark.successColor,
                    foregroundColor: AppThemeColorDark.textDark,
                  ),
                  child: Text(
                    'Complete'.hardCodedString,
                    // style: context.textTheme.bodyLarge?.copyWith(
                    //   color: AppThemeColorDark.textDark,
                    // ),
                  ),
                ),
              ].columnInPadding(10),
            ).padSymmetric(vertical: 20, horizontal: 20)
          ],
        ),
      ),
    );
  }
}
