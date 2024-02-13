import 'package:connect_me/app.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({
    super.key,
    this.uuid,
  });

  final String? uuid;
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(authStateChangesProvider, (previous, next) {
      if (next.value?.uid == null) {
        pushReplacement(context, const LoginScreen());
      }
    });
    final users = ref.watch(fetchProfileProvider).valueOrNull;
    final workExperience = ref.watch(fetchWorkListProvider('')).valueOrNull;
    final educationExperience =
        ref.watch(fetchEducationListProvider('')).valueOrNull;
    var addInfo = users?.additionalDetails;

    // inspect(users);
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: context.theme.scaffoldBackgroundColor,
      //   toolbarHeight: kToolbarHeight * 0.8,
      // ),

      //! body
      body: users == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SafeArea(
              child: ListView(
                shrinkWrap: true,
                padding: AppEdgeInsets.eV12,
                children: [
                  //! profile header
                  ProfileScreenHeaderWidget(
                    users: widget.uuid?.isEmpty == true ? users : users,
                  ),

                  //! bio details
                  (users.bio?.isEmpty == true || users.bio == null) &&
                          (users.email?.isEmpty == true ||
                              users.email == null) &&
                          (users.phone?.isEmpty == true || users.phone == null)
                      ? const SizedBox.shrink()
                      : BioDetailsWidget(users: users),

                  (users.additionalDetails == null)
                      ? const SizedBox.shrink()
                      :
                      // ! additional details card
                      AdditionalDetailsCardWidget(addInfo: addInfo),

                  workExperience == null || workExperience.isEmpty
                      ? const SizedBox.shrink()
                      : WorkDetailsCardWidget(
                          workExperienceModel: workExperience),

                  educationExperience == null || educationExperience.isEmpty
                      ? const SizedBox.shrink()
                      : EdiucationDetailsCardWidget(
                          educationModel: educationExperience),
                ],
              ).padSymmetric(horizontal: 20),
            ),
    );
  }
}
