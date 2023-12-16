import 'package:connect_me/app.dart';

class GradientShortBTN extends StatelessWidget {
  const GradientShortBTN({
    super.key,
    this.child,
    this.height,
    this.width,
    this.iconData,
    this.iconSize,
    this.isWhiteGradient = false,
    this.isThinBorder = false,
    this.onTap,
    this.elevation,
    required this.tooltip,
  });
  final Widget? child;
  final double? height, width, iconSize;
  final IconData? iconData;
  final bool isWhiteGradient;
  final bool isThinBorder;
  final VoidCallback? onTap;
  final double? elevation;
  final String tooltip;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            gradient: isWhiteGradient == true
                ? whiteGradient(context: context)
                : orangeGradient(isLongBTN: true),
            borderRadius: AppBorderRadius.c12,
          ),
          child: child ??
              SizedBox(
                height: height ?? 50,
                width: width ?? 50,
                child: Card(
                  elevation: elevation ?? 5,
                  margin: isThinBorder == true ? AppEdgeInsets.eA1 : AppEdgeInsets.eA2,
                  child: Icon(
                    iconData ?? notificationIcon,
                    size: iconSize ?? 25,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
