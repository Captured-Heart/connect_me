import 'package:connect_me/app.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
    required this.iconData,
    required this.text,
    this.onTap,
    this.elevation,
    this.isDense = false,
    this.color,
    this.textColor,
    this.noBorder = false,
    this.isLoading = false,
  });

  final IconData iconData;
  final String text;
  final VoidCallback? onTap;
  final double? elevation;
  final bool isDense, isLoading;
  final Color? color, textColor;
  final bool noBorder;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: noBorder == true
            ? null
            : RoundedRectangleBorder(
                side: BorderSide(
                  color: context.colorScheme.onSurface,
                  width: 0.3,
                ),
                borderRadius: BorderRadius.circular(isDense == true ? 10 : 15),
              ),
        elevation: elevation ?? 3,
        child: isLoading == true
            ? const Center(
                child: SizedBox(
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppThemeColorDark.textDark,
                  ),
                ),
              ).padAll(10)
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: textColor ?? context.theme.iconTheme.color,
                  ),
                  Flexible(
                    child: AutoSizeText(
                      text,
                      maxLines: 1,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: textColor ?? context.colorScheme.onBackground,
                      ),
                    ),
                  ),
                ].rowInPadding(10),
              ).padAll(isDense == true ? 5 : 10),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.color,
    this.textColor,
    this.isDense = false,
    this.elevation,
    required this.iconData,
    this.onTap,
  });
  final Color? color, textColor;
  final bool isDense;
  final double? elevation;
  final IconData iconData;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: context.colorScheme.onSurface,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(isDense == true ? 10 : 15),
        ),
        elevation: elevation ?? 3,
        child: Icon(
          iconData,
          color: textColor ?? context.theme.iconTheme.color,
        ).padAll(isDense == true ? 5 : 8),
      ),
    );
  }
}
