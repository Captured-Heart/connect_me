import 'package:connect_me/app.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppThemeColorDark.indicatorActiveColor.withOpacity(0.2),
      highlightColor: AppThemeColorDark.indicatorInactiveColor,
      period: const Duration(milliseconds: 3000),
      child: child,
    );
  }
}
