import 'package:connect_me/app.dart';

final bottomNavBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});
  Widget bodyWidget({required int currentIndex}) {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return const ProfileScreen();
      case 2:
        return const ContactScreen();

      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavBarIndexProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(bottomNavBarIndexProvider.notifier).update((state) => value);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(homeIcon),
            label: TextConstant.home,
            tooltip: TextConstant.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(connectIcon),
            label: TextConstant.profile,
            tooltip: TextConstant.profile,
          ),
          BottomNavigationBarItem(
            icon: Icon(IonIcons.ellipsis_horizontal_circle_sharp),
            label: TextConstant.more,
            tooltip: TextConstant.more,
          ),
        ],
      ),
      body: bodyWidget(currentIndex: currentIndex),
    );
  }
}
