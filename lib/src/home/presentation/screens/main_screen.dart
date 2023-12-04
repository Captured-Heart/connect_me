import 'package:connect_me/app.dart';

final bottomNavBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavBarIndexProvider);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        // height: kBottomNavigationBarHeight * 1.5,
        child: BottomNavigationBar(
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
          ],
        ),
      ),
      body: currentIndex < 1 ? HomeScreen() : ProfileScreen(),
    );
  }
}
