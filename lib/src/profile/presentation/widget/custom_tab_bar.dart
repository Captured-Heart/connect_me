import 'package:connect_me/app.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(width: 0.15, color: context.colorScheme.onSurface),
          bottom: BorderSide(width: 0.1, color: context.colorScheme.onSurface),
        ),
      ),
      child: TabBar(
        isScrollable: true,
        indicatorColor: Colors.transparent,
        padding: AppEdgeInsets.eA1,
        labelStyle: context.textTheme.bodyLarge?.copyWith(
          fontWeight: AppFontWeight.w500,
          fontSize: 12,
        ),
        labelColor: context.colorScheme.onBackground,
        dividerColor: Colors.transparent,
        indicatorWeight: 1,
        indicatorSize: TabBarIndicatorSize.label,

        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: context.colorScheme.onBackground, width: 2),
        ),
        splashBorderRadius: BorderRadius.circular(40),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => states.contains(MaterialState.selected) ? null : Colors.transparent,
        ),
        // onTap: (value) {
        //   log(value.toString());
        // },
        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
