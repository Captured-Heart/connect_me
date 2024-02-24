// ignore_for_file: avoid_field_initializers_in_const_classes, omit_local_variable_types

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

const Color _kPrimaryLightColor = Color(0xFFE57373); //New: 0xFFE57373  //prev: 0xFF00aff0
const Color _kPrimaryDarkColor = Color(0xffffffff);
// Color.fromARGB(255, 232, 234, 237); // prev: 0xFF0905f7 //like1: 0xFFE8ECED
const Color _kBackgroundDarkColor = Color(0xFF000000); //prev: 0xFF070707
// ignore: prefer_int_literals
const double _kIconSize = 20.0;

class AppColorTheme {
  const AppColorTheme._();

  final Color success = const Color(0xFF239f77);
  final Color onSuccess = const Color(0xFFFFFFFF);

  final Color danger = const Color(0xFFEB5757);
  final Color onDanger = const Color(0xFFFFFFFF);
}

ThemeData themeBuilder({
  required ThemeData defaultTheme,
}) {
  final Brightness brightness = defaultTheme.brightness;
  final bool isDark = brightness == Brightness.dark;

  final ColorScheme colorScheme = ColorScheme.fromSeed(
    seedColor: isDark ? _kPrimaryDarkColor : _kPrimaryLightColor,
    brightness: brightness,
  );
  final Color scaffoldBackgroundColor = isDark ? _kBackgroundDarkColor : colorScheme.background;

  OutlineInputBorder textFieldBorder =
      OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10));
  final OutlineInputBorder textFieldErrorBorder = textFieldBorder.copyWith(
    borderSide: BorderSide(color: colorScheme.error),
  );

  final TextTheme textTheme = defaultTheme.textTheme;

  final TextStyle? buttonTextStyle = textTheme.labelMedium?.copyWith(
    fontWeight: AppFontWeight.w400,
  );

  final ButtonStyle textButtonStyle = TextButton.styleFrom(
    textStyle: buttonTextStyle,
    padding: EdgeInsets.zero,
    visualDensity: VisualDensity.compact,
    foregroundColor: AppThemeColorDark.textButton,
  );

  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    // textStyle: buttonTextStyle,
    elevation: 3,
    foregroundColor: colorScheme.background,
    backgroundColor: colorScheme.onBackground,
    shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.c8),
  );

  //dark mode
  return ThemeData(
    useMaterial3: true,
    primaryColor: colorScheme.primary,
    iconTheme: defaultTheme.iconTheme.copyWith(size: _kIconSize),
    primaryIconTheme: defaultTheme.primaryIconTheme.copyWith(size: _kIconSize),
    textTheme: TextTheme(
      /// ListTile [TITLE]
      bodyLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: AppFontWeight.w500,
        fontFamily: solwayFamily,
      ),

      /// [SUBTITLE] and [BODY TEXT]
      bodyMedium: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      bodySmall: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      titleSmall: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: AppFontWeight.w700,
        fontFamily: solwayFamily,
      ),

      titleMedium: AppTextStyle.listTileSubTitle.copyWith(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),

      // APP BAR TITLE
      titleLarge: AppTextStyle.listTileTitle.copyWith(
        color: colorScheme.onSurface,
        fontWeight: AppFontWeight.w600,
        fontSize: 22,

      ),
      labelSmall: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      labelMedium: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      labelLarge: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      headlineSmall: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      headlineMedium: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      headlineLarge: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      displayLarge: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      displayMedium: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
      displaySmall: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: solwayFamily,
      ),
    ),
    // defaultTheme.textTheme.merge(textTheme),
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    shadowColor: colorScheme.scrim,
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: elevatedButtonStyle),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: colorScheme.secondaryContainer,
      foregroundColor: colorScheme.onSecondaryContainer,
    ),
    colorScheme: colorScheme,
    inputDecorationTheme: InputDecorationTheme(
      border: textFieldBorder,
      focusedBorder: textFieldBorder,
      enabledBorder: textFieldBorder,
      errorBorder: textFieldErrorBorder,
      focusedErrorBorder: textFieldErrorBorder,
      contentPadding: EdgeInsets.zero,
      //  const EdgeInsets.all(12),
      filled: true,
      // isDense: true,
    ),
  );
}

extension BuildContextThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
}

extension BuildContextTextTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension DarkMode on BuildContext {
  /// is dark mode currently enabled?
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;

    return brightness == Brightness.dark;
  }
}
