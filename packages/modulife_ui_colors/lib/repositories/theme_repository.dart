import 'package:modulife_ui_colors/models/theme_model.dart';
import 'package:modulife_utils/modulife_utils.dart';

class ThemeRepository {
  final StorageUtils _prefs = StorageUtils();

  /// Generates the key for storing a profile's selected theme
  String _generateSelectedThemeKey(String profileId) {
    return 'profile_${profileId}_selected_theme';
  }

  /// Generates the key for storing a profile's custom themes
  String _generateCustomThemesKey(String profileId) {
    return 'profile_${profileId}_custom_themes';
  }

  /// Save the selected theme for a given profile
  Future<void> saveSelectedTheme(String profileId, String themeId) async {
    final String key = _generateSelectedThemeKey(profileId);
    await _prefs.saveString(key, themeId);
  }

  /// Get the selected theme for a given profile
  Future<ThemeModel?> getSelectedTheme(
      String profileId, List<ThemeModel> curatedThemes) async {
    final String key = _generateSelectedThemeKey(profileId);
    String? selectedId = _prefs.getString(key);

    if (selectedId != null) {
      return curatedThemes.firstWhere(
          (ThemeModel theme) => theme.id == selectedId,
          orElse: () => curatedThemes[0]);
    }
    return curatedThemes[0];
  }

  /// Save a custom theme for a given profile
  Future<void> saveCustomTheme(String profileId, ThemeModel theme) async {
    final key = _generateCustomThemesKey(profileId);
    List<String> customThemes = _prefs.getStringList(key) ?? [];

    if (!customThemes.contains(theme.id)) {
      customThemes.add(theme.id);
      await _prefs.saveStringList(key, customThemes);
    }
  }

  /// Remove a custom saved theme for a given profile
  Future<void> removeCustomTheme(String profileId, ThemeModel theme) async {
    final String key = _generateCustomThemesKey(profileId);
    List<String> customThemes = _prefs.getStringList(key) ?? [];

    if (customThemes.contains(theme.id)) await _prefs.remove(key);
  }

  /// Get a list of custom themes for a given profile
  Future<List<String>> getCustomThemes(String profileId) async {
    final key = _generateCustomThemesKey(profileId);
    return _prefs.getStringList(key) ?? [];
  }
}
