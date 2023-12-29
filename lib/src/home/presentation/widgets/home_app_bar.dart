import 'package:connect_me/app.dart';

class HomeScreenAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({
    super.key,
    this.hideTitle = false,
    required this.authUserModel,
  });
  final bool hideTitle;
  final AuthUserModel? authUserModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectsList = ref.watch(
        fetchProfileProvider('').select((value) => value.value?.connects));
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      centerTitle: true,
      // leading in appbar
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: () {
          if (connectsList != null) {
            pushAsVoid(
              context,
              ContactScreen(
                connectsList: connectsList,
              ),
            );
          } else {
            showScaffoldSnackBarMessageNoColor(
              AuthErrors.networkFailure.errorMessage,
              context: context,
              isError: true,
            );
          }
        },
        child: Chip(
          label: Swing(
            infinite: true,
            duration: const Duration(seconds: 5),
            child: Image.asset(
              ImagesConstant.appLogoBrown,
              fit: BoxFit.contain,
              height: 35,
              width: 40,
              scale: 0.8,
              // height: 80,
            ),
          ),
          padding: const EdgeInsets.all(5),
          labelPadding: EdgeInsets.zero,
          shape: const CircleBorder(),
          side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
        ),
      ),
      automaticallyImplyLeading: false,
      title: hideTitle == true
          ? null
          : Text(
              TextConstant.connect,
              style: context.textTheme.titleLarge?.copyWith(
                fontWeight: AppFontWeight.w600,
              ),
            ),
      actions: [
        //share screen
        GestureDetector(
          onTap: () {
            if (authUserModel != null) {
              pushAsVoid(
                context,
                ShareQrCodeScreen(
                  authUserModel: authUserModel!,
                ),
              );
            } else {
              showScaffoldSnackBarMessageNoColor(
                AuthErrors.networkFailure.errorMessage,
                context: context,
              );
            }
          },
          child: Chip(
            backgroundColor:
                context.colorScheme.inversePrimary.withOpacity(0.4),
            label: const Icon(shareIcon),
            shape: const CircleBorder(),
            side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
          ),
        ),

        //camera
        GestureDetector(
          onTap: () {
            pushAsVoid(
              context,
              const QrCodeScreen(),
            );
          },
          child: Chip(
            backgroundColor:
                context.colorScheme.inversePrimary.withOpacity(0.4),
            label: const Icon(cameraIcon),
            shape: const CircleBorder(),
            side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.2);
}
