import 'package:connect_me/app.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../analytics_mock.dart';

void initializeFirebaseForTest() {
  setupFirebaseAnalyticsMocks();
  setUpAll(() async => await Firebase.initializeApp());
}

Widget createAppRoot({
  required Widget child,
  GlobalKey<NavigatorState>? navigatorKey,
}) {
  // final container = ProviderContainer(
  //   observers: <ProviderObserver>[AppProviderObserver()],
  // );

  return ProviderScope(
    // container: container,
    child: MaterialApp(
      home: child,
      navigatorKey: navigatorKey,
    ),
  );
}

class CreateAppRoot extends StatefulWidget {
  const CreateAppRoot({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<CreateAppRoot> createState() => _CreateAppRootState();
}

class _CreateAppRootState extends State<CreateAppRoot> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(home: widget.child),
    );
  }
}

// Extensions

extension FinderExtension on Finder {
  Finder descendantOf(Finder of) {
    return find.descendant(of: of, matching: this);
  }
}
