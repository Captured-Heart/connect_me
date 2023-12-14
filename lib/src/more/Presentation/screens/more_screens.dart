import 'package:connect_me/app.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            children: const [
              // MY ACCOUNT
              Text('Your Account'),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Account Information',
                      subtitle: 'Name, display picture, website',
                    ),
                    // Text(
                    //   'Manage your connect experiences by updating your name, ',
                    //   style: context.textTheme.bodySmall?.copyWith(
                    //     color: context.colorScheme.onSurface.withOpacity(0.8),
                    //   ),
                    //   textScaleFactor: 0.8,
                    // ).padSymmetric(horizontal: 20)
                  ],
                ),
              ),
              // DottedLineDividerWidget(),
              Text('Other Information'),

              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Education',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Social Media Handles',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'My Portfolio',
                    ),
                  ],
                ),
              ),
              // DottedLineDividerWidget(),

              //CAREER
              Text('Career'),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Skills',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Accomplishment',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'My Portfolio',
                    ),
                  ],
                ),
              ),
              // DottedLineDividerWidget(),

              // SETTINGS
              Text('Settings'),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Account Privacy',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Feedbacks',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'About',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Support',
                    ),
                    MoreCustomListTileWidget(
                      icon: homeIcon,
                      title: 'Licenses',
                    ),
                  ],
                ),
              ),
              // DottedLineDividerWidget(),
            ].columnInPadding(10)),
      ),
    );
  }
}

class MoreCustomListTileWidget extends StatelessWidget {
  const MoreCustomListTileWidget({
    super.key,
    this.subtitle,
    this.icon,
    required this.title,
  });

  final String? subtitle;
  final String title;

  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: icon == null
          ? null
          : Icon(
              icon,
              size: 22,
            ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(
              subtitle ?? '',
              textScaleFactor: 0.85,
            )
          : null,
      trailing: const Icon(
        iosArrowForwardIcon,
        size: 17,
      ),
    ).padOnly();
  }
}

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
