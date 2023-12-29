import 'package:connect_me/app.dart';

class NewProfileScreen extends ConsumerWidget {
  const NewProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.cardTheme.color,
        title: const Text(TextConstant.profile),
      ),
    );
  }
}
