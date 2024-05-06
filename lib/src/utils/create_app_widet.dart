import '../../app.dart';

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
  void initState() {
    initializeFirebase();
    super.initState();
  }

  Future<void> initializeFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    log('i am in the initstate of createAPProot');
  }

  final container = ProviderContainer(
    observers: <ProviderObserver>[AppProviderObserver()],
  );

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp(home: widget.child),
    );
  }
}
