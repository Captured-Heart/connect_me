// ignore_for_file: inference_failure_on_instance_creation, inference_failure_on_function_invocationx, lines_longer_than_80_chars

import 'package:flutter/material.dart';

//pushNamed
void pushNamed(BuildContext context, String routeName, {Object? args}) =>
    Navigator.pushNamed(context, routeName, arguments: args);

//push
Future<T?> push<T>(BuildContext context, Widget child) =>
    Navigator.of(context).push<T>(MaterialPageRoute(builder: (_) => child));

//push_as_void
void pushAsVoid(BuildContext context, Widget child) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));

//pop and push
void popAndPushNamed(BuildContext context, String routeName) =>
    Navigator.of(context).popAndPushNamed(routeName);
void popAndPush(BuildContext context, Widget child) {
  pop(context);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => child));
}

//push_replacement
void pushReplacement(BuildContext context, Widget child) =>
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => child));
//push_replacement_named
void pushReplaceNamed(BuildContext context, String routeName, {Object? args}) =>
    Navigator.pushReplacementNamed(context, routeName);
//pop until main
void popToMain(BuildContext context) => Navigator.of(context).popUntil((route) => route.isFirst);

//.ofContext POP
void pop(BuildContext context) => Navigator.of(context).pop();
//.oFContext with rootNavigator POP
void popRootNavigatorTrue(BuildContext context) => Navigator.of(context, rootNavigator: true).pop();

//.ofContext PUSH with root navigator == true
void pushReplacementOnRootNav(BuildContext context, Widget child) =>
    Navigator.of(context, rootNavigator: true)
        .pushReplacement(MaterialPageRoute(builder: (context) => child));

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
