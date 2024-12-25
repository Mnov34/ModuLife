import 'package:flutter/material.dart';

class CuratedThemeColors {
  // Default App Theme
  static const Color kBackground = Color.fromRGBO(47, 47, 47, 1);
  static const Color kPrimaryColor = Color.fromRGBO(186, 242, 187, 1);
  static const Color kSecondaryColor = Color.fromRGBO(77, 122, 77, 1);

  // Define the Default App Theme
  static final ThemeData defaultTheme = ThemeData(
    scaffoldBackgroundColor: kBackground,
    primaryColor: kPrimaryColor,
    colorScheme: ColorScheme(
      primary: kPrimaryColor,
      onPrimary: kBackground,
      secondary: kSecondaryColor,
      onSecondary: kBackground,
      surface: kBackground,
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.black,
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: kSecondaryColor,
      foregroundColor: kBackground,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: kPrimaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
  );

  static final ThemeData greenTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
  );

  static String getThemeName(ThemeData theme) {
    if (theme == defaultTheme) return "Default Theme";
    if (theme == lightTheme) return "Light Theme";
    if (theme == darkTheme) return "Dark Theme";
    if (theme == greenTheme) return "Green Theme";
    return "Custom Theme";
  }

  static List<ThemeData> get curatedThemes =>
      [defaultTheme, lightTheme, darkTheme, greenTheme];
}
