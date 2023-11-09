import 'package:connect_me/app.dart';

Widget shimmerWidget({required Widget child}) {
  return Shimmer.fromColors(
    baseColor: AppThemeColorDark.indicatorActiveColor.withOpacity(0.2),
    highlightColor: AppThemeColorDark.indicatorInactiveColor,
    period: const Duration(milliseconds: 3000),
    child: child,
  );
}
