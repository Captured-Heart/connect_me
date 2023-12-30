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
      padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(
          top: BorderSide(width: 0.15, color: context.colorScheme.onSurface),
          bottom: BorderSide(width: 0.1, color: context.colorScheme.onSurface),
        ),
      ),
      child: TabBar(
        isScrollable: false,
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

class CustomTabBar2 extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar2({
    super.key,
    required this.tabs,
  });
  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      // margin: EdgeInsets.only(top: 14),
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      // padding: const EdgeInsets.only(bottom: 5, top: 5, left: 10),
      // padding: EdgeInsets.zero,
      // decoration: BoxDecoration(
      //   color: context.colorScheme.surface,
      //   // border: Border(
      //   //   top: BorderSide(width: 0.15, color: context.colorScheme.onSurface),
      //   //   bottom: BorderSide(width: 0.1, color: context.colorScheme.onSurface),
      //   // ),
      // ),
      child: TabBar(
        isScrollable: false,
        labelStyle: context.textTheme.labelLarge?.copyWith(
          fontWeight: AppFontWeight.w500,
          // fontSize: 12,
          color: context.colorScheme.onBackground,
        ),
        labelPadding: AppEdgeInsets.eA12,
        unselectedLabelStyle:
            context.textTheme.labelLarge?.copyWith(color: context.colorScheme.onSurface),

        labelColor: context.colorScheme.onBackground,
        dividerColor: Colors.transparent,
        // indicatorWeight: 15,
        // automaticIndicatorColorAdjustment: true,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          // borderRadius: AppBorderRadius.c12
        ),

        // UnderlineTabIndicator(
        //   borderSide:
        //       BorderSide(color: context.colorScheme.onBackground, width: 2),
        // ),
        splashBorderRadius: BorderRadius.circular(40),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => states.contains(MaterialState.selected) ? null : Colors.transparent,
        ),

        tabs: tabs,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(30);
}
