/*
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:modulife_ui_colors/models/theme_model.dart';
import 'package:modulife_ui_colors/repositories/theme_repository.dart';
import 'package:modulife_ui_colors/util/curated_theme_colors.dart';

class ThemeCubit extends Cubit<ThemeModel> {
  final ThemeRepository _themeRepository;

  ThemeCubit(this._themeRepository)
      : super(ThemeModel(
            profileId: 'default',
            themeData: CuratedThemeColors.defaultTheme,
            isCurated: true));

  /// Load theme for the profile using a [profileId] String
  void loadTheme(String profileId) {
    final ThemeModel savedTheme =
        _themeRepository.getThemeForProfile(profileId);
    if (savedTheme != null) {
      emit(savedTheme);
    } else {
      emit(ThemeModel(
          profileId: profileId,
          themeData: CuratedThemeColors.defaultTheme,
          isCurated: true));
    }
  }

  /// Choose a curated theme using [profileId] String and [curatedTheme] ThemeData
  void chooseCuratedTheme(String profileId, ThemeData curatedTheme) {
    final ThemeModel themeModel = ThemeModel(
        profileId: profileId, themeData: curatedTheme, isCurated: true);
    _themeRepository.saveThemeForProfile(themeModel);
    emit(themeModel);
  }

  /// Update to a custom theme using [profileId] String and [customTheme] ThemeData
  void updateCustomTheme(String profileId, ThemeData customTheme) {
    final ThemeModel themeModel = ThemeModel(
        profileId: profileId, themeData: customTheme, isCurated: false);
    _themeRepository.saveThemeForProfile(themeModel);
    emit(themeModel);
  }

  /// Remove a profile's theme using [profileId] String, and reset to the default theme
  void removeTheme(String profileId) {
    _themeRepository.removeThemeForProfile(profileId);
    emit(ThemeModel(
        profileId: profileId,
        themeData: CuratedThemeColors.defaultTheme,
        isCurated: true));
  }
}
*/
