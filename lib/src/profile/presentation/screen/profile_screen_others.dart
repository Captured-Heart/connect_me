import 'dart:async';

import 'package:connect_me/app.dart';

class ProfileScreenOthers extends ConsumerStatefulWidget {
  const ProfileScreenOthers({
    super.key,
    this.users,
    this.uuid,
    this.fromScanScreen = false,
    this.tabController,
  });
  final AuthUserModel? users;
  final String? uuid;
  final bool fromScanScreen;
  final TabController? tabController;

  @override
  ConsumerState<ProfileScreenOthers> createState() => _ProfileScreenOthersState();
}

class _ProfileScreenOthersState extends ConsumerState<ProfileScreenOthers> {
  @override
  void initState() {
    super.initState();
    if (widget.fromScanScreen == true) {
      showDialogOnFirstTime(users: widget.users);
    }
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(fetchOthersProfileProvider(widget.uuid)).valueOrNull;
    final workExperience = ref.watch(fetchWorkListProvider(widget.uuid)).valueOrNull;
    final educationExperience = ref.watch(fetchEducationListProvider(widget.uuid)).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        toolbarHeight: kToolbarHeight * 0.8,
      ),

      //! body
      body: users == null
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : ListView(
              shrinkWrap: true,
              padding: AppEdgeInsets.eV12,
              children: [
                //! profile header
                ProfileScreenHeaderWidget(
                  users: widget.uuid?.isEmpty == true ? widget.users : users,
                ),

//! bio details
                (users.bio?.isEmpty == true || users.bio == null) &&
                        (users.email?.isEmpty == true || users.email == null) &&
                        (users.phone?.isEmpty == true || users.phone == null)
                    ? const SizedBox.shrink()
                    : BioDetailsWidget(users: users),
//! work experience
                workExperience == null || workExperience.isEmpty
                    ? const SizedBox.shrink()
                    : WorkDetailsCardWidget(workExperienceModel: workExperience),
//! education experience
                educationExperience == null || educationExperience.isEmpty
                    ? const SizedBox.shrink()
                    : EdiucationDetailsCardWidget(educationModel: educationExperience),
              ],
            ).padSymmetric(horizontal: 20),
    );
  }

  void showDialogOnFirstTime({required AuthUserModel? users}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.tabController?.animateTo(0);

      //analytics for profile visits
      unawaited(ref
          .read(analyticsImplProvider)
          .profileVisit(authUserModel: widget.users ?? const AuthUserModel()));
      var docId = const Uuid().v4();
      Future.delayed(const Duration(milliseconds: 1400), () {
        showDialog(
          context: context,
          builder: (context) {
            return AppCustomDialogWarning(
              dialogModel: DialogModel(
                content: RichText(
                  text: TextSpan(
                    text: 'Add ',
                    children: [
                      TextSpan(
                        text: users?.fullname,
                        style: context.textTheme.titleSmall,
                      ),
                      const TextSpan(text: ' to contacts?')
                    ],
                    style: context.textTheme.titleMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
                postiveActionText: TextConstant.ok,
                // negativeActionText: TextConstant.cancel,
                onPostiveAction: () {
                  ref.read(addUsersToContactNotifierProvider.notifier).addUsersToContactsMethod(
                        docId: docId,
                        map: ContactsModel(
                          docId: docId,
                          connectTo: users?.docId,
                          userId: ref.read(currentUUIDProvider),
                        ).toJson(),
                      );
                  pop(context);
                },
              ),
            );
          },
        );
      });
    });
  }
}
