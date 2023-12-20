import 'package:connect_me/app.dart';

class DottedLineDividerWidget extends StatelessWidget {
  const DottedLineDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedLinePainter(
        context: context,
        strokeWidthDouble: 0.2,
        dashLength: context.sizeWidth(0.25),
      ),
    ).padSymmetric(vertical: 15);
  }
}

class DottedLinePainter extends CustomPainter {
  final BuildContext context;
  final double? dashSpacing;
  final double? dashLength;
  final double? strokeWidthDouble;

  DottedLinePainter({
    required this.context,
    this.dashSpacing,
    this.dashLength,
    this.strokeWidthDouble,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = context.colorScheme.onSurface.withOpacity(0.7)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidthDouble ?? 1.0;

    double dashWidth = dashLength ?? 5.0;
    double dashSpace = dashSpacing ?? 8.0;

    double currentX = 0.0;

    while (currentX < size.width) {
      canvas.drawLine(
        Offset(currentX, 0.0),
        Offset(currentX + dashWidth, 0.0),
        paint,
      );
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
