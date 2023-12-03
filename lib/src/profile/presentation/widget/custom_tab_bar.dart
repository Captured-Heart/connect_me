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
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: whiteGradient(context: context),
        borderRadius: BorderRadius.circular(15),
      ),
      // shape: RoundedRectangleBorder(
      //   side: BorderSide(width: 0.3, color: context.theme.primaryColor),
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.3, color: context.theme.primaryColor),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TabBar(
          isScrollable: false,
          indicatorColor: Colors.transparent,
          padding: AppEdgeInsets.eA1,
          labelStyle: context.textTheme.bodyLarge?.copyWith(
            fontWeight: AppFontWeight.w700,
          ),
          labelColor: AppThemeColorDark.textDark,
          dividerColor: Colors.transparent,
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: context.theme.indicatorColor),
            gradient: orangeGradient(),
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
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
