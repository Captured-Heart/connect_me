// Theme mode enum

// Theme notifier class
import '../../app.dart';

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

    state = ThemeMode.values.where((element) => element.name == themeSaved).firstOrNull ?? ThemeMode.system;
  }
  //
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
