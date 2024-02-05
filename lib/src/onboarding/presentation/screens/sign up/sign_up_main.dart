import 'package:connect_me/app.dart';

class SignUpMainScreen extends ConsumerWidget {
  const SignUpMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUserData = ref.watch(fetchProfileProvider).valueOrNull;
    final education = ref.watch(fetchEducationListProvider('')).valueOrNull;
    final workExperience = ref.watch(fetchWorkListProvider('')).valueOrNull;
    // inspect(education);
    // log('''education $education,       work_experience: $workExperience''');

    return Scaffold(
      appBar: AppBar(
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
                        'The following sections needs to be filled up, \n*Account information is compulsory to complete registration while others are mandatory.'
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
                        onTap: () {
                          pushAsVoid(context, const AccountInformationSignUpScreen());
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
                        onTap: () {
                          pushAsVoid(context, const EducationInfoSignUpScreen());
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
                        onTap: () {
                          pushAsVoid(
                            context,
                            const WorkExperienceSignUpScreen(),
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
                        onTap: () {
                          pushAsVoid(
                            context,
                            const SocialMediaSignUpScreen(),
                          );
                        },
                      ),
                    ),
                  ].columnInPadding(10)),
                ].columnInPadding(20),
              ).padAll(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //skip button
                authUserData?.completedSignUp == false
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        onPressed: () {
                          pushReplacement(context, const MainScreen());
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
                          pushReplacement(context, const MainScreen());
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
