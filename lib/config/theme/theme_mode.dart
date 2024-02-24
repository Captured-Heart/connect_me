// Theme mode enum
import 'package:connect_me/app.dart';

// enum ThemeMode { light, dark, system }

// Theme notifier class
class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);
  // getThemeMode();

  void setThemeMode(ThemeMode mode) {
    SharedPreferencesHelper.setStringPref(SharedPrefKeys.themeMode.name, mode.name);
    state = mode;
  }

  void loadCurrentThemeMode() {
    String themeSaved = SharedPreferencesHelper.getStringPref(SharedPrefKeys.themeMode.name) ??
        ThemeMode.system.name;

    state = ThemeMode.values.where((element) => element.name == themeSaved).single;
    // if (themeSaved == ThemeMode.system.name) {
    //   return ThemeMode.system;
    // } else if (themeSaved == ThemeMode.light.name) {

    //   return ThemeMode.light;
    // } else {

    //   return ThemeMode.dark;
    // }
  }
  //
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

// ThemeMode getThemeMode() {
//   String themeSaved =
//       SharedPreferencesHelper.getStringPref(SharedPrefKeys.themeMode.name) ?? ThemeMode.system.name;
//   if (themeSaved == ThemeMode.system.name) {
//     return ThemeMode.system;
//   } else if (themeSaved == ThemeMode.light.name) {
//     return ThemeMode.light;
//   } else {
//     return ThemeMode.dark;
//   }
// }
