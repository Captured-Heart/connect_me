import 'package:connect_me/app.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({
    super.key,
    this.hideTitle = false,
  });
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      centerTitle: true,
      // leading in appbar
      leadingWidth: 80,
      leading: GestureDetector(
        onTap: () {
          pushAsVoid(
            context,
            const ContactScreen(),
          );
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
        GestureDetector(
          onTap: () {
            pushAsVoid(
              context,
              const QrCodeScreen(),
            );
          },
          child: Chip(
            label: const Icon(notificationIcon),
            shape: const CircleBorder(),
            side: BorderSide(width: 0.5, color: context.colorScheme.onSurface),
          ),
        ),
      ].rowInPadding(10),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 1.2);
}
