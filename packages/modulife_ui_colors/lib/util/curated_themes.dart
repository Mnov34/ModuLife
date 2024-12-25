import 'package:flutter/material.dart';
import 'package:modulife_ui_colors/modulife_ui_colors.dart';

/// A set of curated themes using `ThemeModel`.
final List<ThemeModel> curatedThemes = [
  ThemeModel(
    id: '1',
    name: 'Custom Green Theme',
    themeData: ThemeData(
      primaryColor: UiColors.primaryColor,
      scaffoldBackgroundColor: UiColors.background,
      brightness: Brightness.light,
    ),
  ),
  ThemeModel(
    id: '2',
    name: 'Light Theme',
    themeData: ThemeData(
      primarySwatch: Colors.green,
      brightness: Brightness.light,
    ),
  ),
  ThemeModel(
    id: '3',
    name: 'Dark Theme',
    themeData: ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.dark,
    ),
  ),
];
