import 'dart:ui';

import '../../app.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({
    required this.child,
    required this.isLoading,
    super.key,
    this.loaderStyleWidget,
  });
  final Widget child;
  final bool isLoading;
  final Widget? loaderStyleWidget;
  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Opacity(
              opacity: 0.2,
              child: ModalBarrier(dismissible: false, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
        const Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ),

        //! add loader widget here
        // loaderStyleWidget
      ],
    );
  }
}
