// ignore_for_file: inference_failure_on_instance_creation, inference_failure_on_function_invocationx, lines_longer_than_80_chars

import 'dart:async';
import 'dart:ui';

import 'package:connect_me/app.dart';

//pushNamed
Future<void> pushNamed(BuildContext context, String routeName,
    {Object? args, required WidgetRef ref}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));
  return Navigator.pushNamed(context, routeName, arguments: args);
}

//push
Future<T?> push<T>(BuildContext context, Widget child,
    {required WidgetRef ref, required String routeName}) async {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));
  return Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => child));
}

//push_as_void
void pushAsVoid(BuildContext context, Widget child,
    {required WidgetRef ref, required String routeName}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));

  Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));
}

//pop and push
void popAndPushNamed(BuildContext context, String routeName, {required WidgetRef ref}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));
  Navigator.of(context).popAndPushNamed(routeName);
}

//
void popAndPush(BuildContext context, Widget child,
    {required WidgetRef ref, required String routeName}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));

  pop(context);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));
}

//push_replacement
void pushReplacement(BuildContext context, Widget child,
    {required WidgetRef ref, required String routeName}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));

  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => child));
}

//push_replacement_named
void pushReplaceNamed(
  BuildContext context,
  String routeName, {
  Object? args,
  required WidgetRef ref,
}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));

  Navigator.pushReplacementNamed(context, routeName);
}

//pop until main
void popToMain(BuildContext context, {required WidgetRef ref, required String routeName}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));

  Navigator.of(context).popUntil((route) => route.isFirst);
}

//.ofContext POP
void pop(BuildContext context) => Navigator.of(context).pop();
//.oFContext with rootNavigator POP

void popRootNavigatorTrue(BuildContext context) => Navigator.of(context, rootNavigator: true).pop();

//.ofContext PUSH with root navigator == true
void pushReplacementOnRootNav(BuildContext context, Widget child,
    {required WidgetRef ref, required String routeName}) {
  unawaited(ref.read(analyticsImplProvider).setScreenName(screenName: routeName));

  Navigator.of(context, rootNavigator: true)
      .pushReplacement(MaterialPageRoute(builder: (context) => child));
}

// void navBarPush({
//   required BuildContext context,
//   required Widget child,
//   required bool withNavBar,
// }) =>
//     // ignore: inference_failure_on_function_invocation
//     PersistentNavBarNavigator.pushNewScreen(
//       context,
//       screen: child,
//       withNavBar: withNavBar,
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
// );

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({
    required this.builder,
    this.backgroundColor,
  }) : super();

  final WidgetBuilder builder;
  final Color? backgroundColor;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(
        milliseconds: 500,
      );

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => backgroundColor ?? Colors.black12;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.bounceInOut,
        reverseCurve: Curves.easeIn,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: child,
      ),
    );
  }

  @override
  Widget buildPage(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String? get barrierLabel => "";
}
