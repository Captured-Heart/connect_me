import 'dart:ui';

import 'package:connect_me/app.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    required this.child,
    required this.isLoading,
    // required this.title,
    super.key,
    this.loaderStyleWidget,
  });
  final Widget child;
  final bool isLoading;
  // final String title;
  final Widget? loaderStyleWidget;
  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Stack(
      children: [
        child,
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Opacity(
            opacity: 0.2,
            child: ModalBarrier(dismissible: false, color: Theme.of(context).primaryColor),
          ),
        ),

        //! add loader widget here
        // loaderStyleWidget
      ],
    );
  }
}
