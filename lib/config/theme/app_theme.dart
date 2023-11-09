// ignore_for_file: avoid_field_initializers_in_const_classes, omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

const Color _kPrimaryLightColor = Color(0xFF097cea);
const Color _kPrimaryDarkColor = Color(0xFF0905f7);
const Color _kBackgroundDarkColor = Color(0xFF070707);
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

  const OutlineInputBorder textFieldBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
  );
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
    primaryColor: _kPrimaryDarkColor,
    iconTheme: defaultTheme.iconTheme.copyWith(size: _kIconSize),
    primaryIconTheme: defaultTheme.primaryIconTheme.copyWith(size: _kIconSize),
    textTheme: GoogleFonts.solwayTextTheme().copyWith(
      bodyLarge: GoogleFonts.solway(color: colorScheme.onSurface),
      bodyMedium: GoogleFonts.solway(color: colorScheme.onSurface),
      bodySmall: GoogleFonts.solway(color: colorScheme.onSurface),
      titleSmall: GoogleFonts.solway(color: colorScheme.onSurface),
      titleMedium: GoogleFonts.solway(color: colorScheme.onSurface),
      titleLarge: GoogleFonts.solway(color: colorScheme.onSurface),
      labelSmall: GoogleFonts.solway(color: colorScheme.onSurface),
      labelMedium: GoogleFonts.solway(color: colorScheme.onSurface),
      labelLarge: GoogleFonts.solway(color: colorScheme.onSurface),
      headlineSmall: GoogleFonts.solway(color: colorScheme.onSurface),
      headlineMedium: GoogleFonts.solway(color: colorScheme.onSurface),
      headlineLarge: GoogleFonts.solway(color: colorScheme.onSurface),
      displayLarge: GoogleFonts.solway(color: colorScheme.onSurface),
      displayMedium: GoogleFonts.solway(color: colorScheme.onSurface),
      displaySmall: GoogleFonts.solway(color: colorScheme.onSurface),
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
      contentPadding: const EdgeInsets.all(12),
      filled: true,
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
