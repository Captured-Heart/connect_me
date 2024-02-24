import 'package:connect_me/app.dart';

String solwayFamily = 'Solway';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle headlineLarge = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w700,
    fontSize: 25,
  );

  static TextStyle headlineMedium = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w600,
    fontSize: 20,
  );

  static TextStyle listTileTitle = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w600,
    fontSize: 15,
  );
  static TextStyle listTileSubTitle = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w400,
    fontSize: 12,
  );
  static TextStyle bodySmall = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w600,
    fontSize: 13,
  );
  static TextStyle bodyMedium = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w500,
    fontSize: 15,
  );
  static TextStyle bodyLarge = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: AppFontWeight.w600,
    fontSize: 16,
  );
  static TextStyle errorTextstyle = TextStyle(
    fontFamily: solwayFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
  );
}

// light theme for text
TextTheme lightTextTheme(TextTheme base, {required Color color}) {
  return base.copyWith(
    // the display in showDatePicker
    // displayMedium: ,

    //default text in app
    bodyMedium: AppTextStyle.bodyMedium.copyWith(color: color),

    //normal titles in body text
    bodyLarge: AppTextStyle.bodyLarge.copyWith(),

    // the text in buttons
    labelLarge: AppTextStyle.bodyMedium.copyWith(),

    //for errors in textfield
    labelSmall: AppTextStyle.errorTextstyle.copyWith(),
    //
    labelMedium: AppTextStyle.bodyLarge.copyWith(),

    // the text in Appbar and dialogs
    titleLarge: AppTextStyle.bodyLarge.copyWith(),

    // the Title text in  ListTiles widget
    titleMedium: AppTextStyle.listTileTitle.copyWith(),

    //
    titleSmall: AppTextStyle.listTileSubTitle.copyWith(),
    // the text in [month, year] of showDatePicker

    headlineMedium: AppTextStyle.headlineMedium,
    headlineLarge: AppTextStyle.headlineLarge,

    //
  );
}

// light theme for text
TextTheme darkTextTheme(TextTheme base) {
  return base.copyWith(
    // the display in showDatePicker
    // displayMedium: ,

    //default text in app
    bodyMedium: AppTextStyle.bodyMedium.copyWith(),

    //normal titles in body text
    bodyLarge: AppTextStyle.bodyLarge.copyWith(),

    // the text in buttons
    labelLarge: AppTextStyle.bodyMedium.copyWith(),

    //for errors in textfield
    labelSmall: AppTextStyle.errorTextstyle.copyWith(),
    //
    labelMedium: AppTextStyle.bodyLarge.copyWith(),

    // the text in Appbar and dialogs
    titleLarge: AppTextStyle.bodyLarge.copyWith(),

    // the Title text in  ListTiles widget
    titleMedium: AppTextStyle.listTileTitle.copyWith(),

    //
    titleSmall: AppTextStyle.listTileSubTitle.copyWith(),
    // the text in [month, year] of showDatePicker
    // headlineSmall:
    headlineMedium: AppTextStyle.headlineMedium,
    headlineLarge: AppTextStyle.headlineLarge,

    //
  );
}
