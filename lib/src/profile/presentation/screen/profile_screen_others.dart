import 'package:connect_me/app.dart';

class ProfileScreenOthers extends ConsumerStatefulWidget {
  const ProfileScreenOthers({super.key, this.users, this.scanController, this.uuid});
  final AuthUserModel? users;
  final QRViewController? scanController;
  final String? uuid;
  @override
  ConsumerState<ProfileScreenOthers> createState() => _ProfileScreenOthersState();
}

class _ProfileScreenOthersState extends ConsumerState<ProfileScreenOthers> {
  @override
  void dispose() {
    if (widget.scanController != null) {
      widget.scanController!.resumeCamera();
    }
    super.dispose();
  }

  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    ref.listen(authStateChangesProvider, (previous, next) {
      if (next.value?.uid == null) {
        // log('i popped off screen');
        pushReplacement(context, const LoginScreen());
      }
    });
    final users = ref.watch(fetchOthersProfileProvider(widget.uuid)).valueOrNull;
    final workExperience = ref.watch(fetchWorkListProvider(widget.uuid)).valueOrNull;
    final educationExperience = ref.watch(fetchEducationListProvider(widget.uuid)).valueOrNull;

    // inspect(workExperience);

    var addInfo = users?.additionalDetails;
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
                ProfileHeaderWidget(
                  users: widget.uuid?.isEmpty == true ? widget.users! : users,
                ),

//! bio details
                (users.bio?.isEmpty == true || users.bio == null) &&
                        (users.email?.isEmpty == true || users.email == null) &&
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
                    :
                WorkDetailsCardWidget(workExperienceModel: workExperience),

                educationExperience == null || educationExperience.isEmpty
                    ? const SizedBox.shrink()
                    : EdiucationDetailsCardWidget(educationModel: educationExperience),
              ],
            ).padSymmetric(horizontal: 20),
    );
  }
}

// class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
//   final PreferredSizeWidget _tabBar;

//   _SliverAppBarDelegate(this._tabBar);

//   @override
//   double get minExtent => _tabBar.preferredSize.height * 1.5;

//   @override
//   double get maxExtent => _tabBar.preferredSize.height * 1.5;

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return _tabBar;
//   }

//   @override
//   bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
//     return false;
//   }
// }
