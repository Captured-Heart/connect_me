import 'package:connect_me/app.dart';
import 'package:connect_me/src/more/Presentation/screens/more_screens.dart';
import 'package:flutter_svg/flutter_svg.dart';

final bottomNavBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});

final hideBottomNavBarProvider = StateProvider<bool>((ref) {
  return false;
});

enum NavBarItems {
  home(
    TextConstant.home,
    IconConstants.homeIconSVGunselected,
  ),
  connect(
    TextConstant.connect,
    IconConstants.connectIconSVGunselected,
  ),
  profile(
    TextConstant.profile,
    IconConstants.profileIconSVGunselected,
  ),
  more(
    TextConstant.more,
    IconConstants.moreIconSVGunselected,
  );

  const NavBarItems(
    this.label,
    this.icon,
  );
  final String label;
  final String icon;
}

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
  });
  Widget bodyWidget({required int currentIndex}) {
    switch (currentIndex) {
      case 0:
        return const HomeScreen2();
      case 1:
        return const ContactScreen();
      case 2:
        return const ProfileScreen1();
      case 3:
        return const MoreScreen();

      default:
        return const HomeScreen2();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavBarIndexProvider);
    final hideNavBar = ref.watch(hideBottomNavBarProvider);
    return Scaffold(
      bottomNavigationBar: hideNavBar == true
          ? const SizedBox.shrink()
          : FadeInUp(
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: currentIndex,
                onTap: (value) {
                  ref.read(bottomNavBarIndexProvider.notifier).update((state) => value);
                },
                items: List.generate(
                  4,
                  (index) {
                    return BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        NavBarItems.values[index].icon,
                        fit: BoxFit.fill,
                        height: 30,
                        color: index == currentIndex
                            ? context.colorScheme.primary
                            : context.colorScheme.outline,
                      ),
                      label: NavBarItems.values[index].label,
                      tooltip: NavBarItems.values[index].label,
                    );
                  },
                )),
          ),
      body: bodyWidget(currentIndex: currentIndex),
    );
  }
}
