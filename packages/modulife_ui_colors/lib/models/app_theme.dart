import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:modulife_ui_colors/util/utils.dart';

class AppTheme extends Equatable {
  final String id;
  final String themeKey;
  final String? profileId;

  final Color backgroundColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color accentColor3;

  AppTheme({
    String? id,
    required this.themeKey,
    this.profileId,
    required this.backgroundColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor3,
  }) : id = id ?? const Uuid().v4();

  AppTheme copyWith({
    String? id,
    String? themeKey,
    String? profileId,
    Color? backgroundColor,
    Color? accentColor1,
    Color? accentColor2,
    Color? accentColor3,
  }) {
    return AppTheme(
      id: id ?? this.id,
      themeKey: themeKey ?? this.themeKey,
      profileId: profileId ?? this.profileId,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primaryColor: accentColor1 ?? this.primaryColor,
      secondaryColor: accentColor2 ?? this.secondaryColor,
      accentColor3: accentColor3 ?? this.accentColor3,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'themeKey': themeKey,
      'profileId': profileId,
      'backgroundColor': backgroundColor,
      'accentColor1': primaryColor,
      'accentColor2': secondaryColor,
      'accentColor3': accentColor3,
    };
  }

  factory AppTheme.fromMap(Map<String, dynamic> map) {
    return AppTheme(
      id: map['id'] ?? const Uuid().v4(),
      themeKey: map['themeKey'],
      profileId: map['profileId'],
      backgroundColor: map['backgroundColor'] ?? UiColors.background,
      primaryColor: map['accentColor1'] ?? UiColors.primaryColor,
      secondaryColor: map['accentColor2'] ?? UiColors.secondaryColor,
      accentColor3: map['accentColor3'] ?? UiColors.accentColor,
    );
  }

  ThemeData toThemeData() {
    return ThemeData(
      colorScheme: ColorScheme(
        surface: backgroundColor,
        onSurface: Colors.white,

        primary: primaryColor,
        onPrimary: Colors.black,

        secondary: secondaryColor,
        onSecondary: Colors.black,

        error: UiColors.dangerRed,
        onError: Colors.white,

        brightness: Brightness.light,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
    );
  }

  @override
  List<Object?> get props => [
        id,
        themeKey,
        profileId,
        backgroundColor,
        primaryColor,
        secondaryColor,
        accentColor3,
      ];
}

class Themes {
  static final AppTheme darkTheme = AppTheme(
    themeKey: 'dark',
    backgroundColor: UiColors.background,
    primaryColor: UiColors.primaryColor,
    secondaryColor: UiColors.secondaryColor,
    accentColor3: UiColors.accentColor,
  );

  static final AppTheme pinkTheme = AppTheme(
    themeKey: 'pink',
    backgroundColor: UiColors.backgroundPink,
    primaryColor: UiColors.primaryColorPink,
    secondaryColor: UiColors.secondaryColorPink,
    accentColor3: UiColors.primacyColorYellow,
  );

  static final AppTheme yellowTheme = AppTheme(
    themeKey: 'yellow',
    backgroundColor: UiColors.background,
    primaryColor: UiColors.primacyColorYellow,
    secondaryColor: UiColors.primaryColorYellow,
    accentColor3: UiColors.dangerRed,
  );
}
