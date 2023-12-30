import 'package:connect_me/app.dart';

Widget createAppRoot({
  required Widget child,
}) {
  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );
  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(home: child),
  );
}
