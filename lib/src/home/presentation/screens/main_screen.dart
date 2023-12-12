import 'package:connect_me/app.dart';
import 'package:connect_me/src/more/Presentation/screens/more_screens.dart';

final bottomNavBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});
  Widget bodyWidget({required int currentIndex}) {
    switch (currentIndex) {
      case 0:
        return HomeScreen2();
      case 1:
        return const MoreScreen();

      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavBarIndexProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: context.colorScheme.secondaryContainer,
        // selectedItemColor: context.colorScheme.onSecondaryContainer,
        // unselectedItemColor: context.colorScheme.onSecondaryContainer.withOpacity(0.6),
        // elevation: 10,

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
          // BottomNavigationBarItem(
          //   icon: Icon(connectIcon),
          //   label: TextConstant.profile,
          //   tooltip: TextConstant.profile,
          // ),
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
