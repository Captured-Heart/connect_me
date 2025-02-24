

import '../../../../app.dart';

class GradientLongBTN extends StatelessWidget {
  const GradientLongBTN({
    super.key,
    this.width,
  });
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: orangeGradient(context: context),
        borderRadius: AppBorderRadius.c12,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          'Connect',
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: AppFontWeight.w600,
            color: AppThemeColorDark.textDark,
          ),
        ),
      ),
    );
  }
}
