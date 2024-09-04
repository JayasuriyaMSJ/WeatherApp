import 'package:flutter/material.dart';
import 'package:intern_weather/core/colors/app_color_palette.dart';

class AppTheme extends ChangeNotifier {
  static final _themeInstance = AppTheme._();
  final ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  String fontStyle = "";

  AppTheme._();

  factory AppTheme() {
    return _themeInstance;
  }

  static _border(Color colour) => OutlineInputBorder(
        borderSide: BorderSide(
          color: colour,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
      );

  ThemeData get lighttheme => ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColorPalette.lightBackground,
        appBarTheme:
            const AppBarTheme(backgroundColor: AppColorPalette.lightBackground),
        iconTheme: const IconThemeData(color: AppColorPalette.black),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 16,
              color: AppColorPalette.lightText,
              fontFamily: fontStyle),
          bodyMedium: TextStyle(
              fontSize: 16,
              color: AppColorPalette.lightText,
              fontFamily: fontStyle),
          bodySmall: TextStyle(
              fontSize: 16,
              color: AppColorPalette.lightText,
              fontFamily: fontStyle),
          titleLarge: TextStyle(
            fontSize: 24,
            color: AppColorPalette.black,
            fontFamily: fontStyle,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            color: AppColorPalette.black,
            fontFamily: fontStyle,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: AppColorPalette.black,
            fontFamily: fontStyle,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: _border(AppColorPalette.lightBorderColor),
          focusedBorder: _border(AppColorPalette.teal),
        ),
      );

  ThemeData get darktheme => ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColorPalette.darkBackground,
        appBarTheme:
            const AppBarTheme(backgroundColor: AppColorPalette.darkBackground),
        iconTheme: const IconThemeData(color: AppColorPalette.white),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              fontSize: 16,
              color: AppColorPalette.white,
              fontFamily: fontStyle),
          bodyMedium: TextStyle(
              fontSize: 16,
              color: AppColorPalette.white,
              fontFamily: fontStyle),
          bodySmall: TextStyle(
              fontSize: 16,
              color: AppColorPalette.white,
              fontFamily: fontStyle),
          titleLarge: TextStyle(
            fontSize: 24,
            color: AppColorPalette.white,
            fontFamily: fontStyle,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            color: AppColorPalette.white,
            fontFamily: fontStyle,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            color: AppColorPalette.white,
            fontFamily: fontStyle,
            fontWeight: FontWeight.bold,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: _border(AppColorPalette.darkBorderColor),
          focusedBorder: _border(AppColorPalette.buttonGradientStart),
        ),
      );
}
