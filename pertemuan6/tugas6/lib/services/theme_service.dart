import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const String darkModeKey = 'isDarkMode';
  static const String colorIndexKey = 'colorIndex';

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(darkModeKey) ?? false;
  }

  static Future<int> getColorIndex() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(colorIndexKey) ?? 0;
  }

  static Future<void> saveDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(darkModeKey, value);
  }

  static Future<void> saveColorIndex(int index) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(colorIndexKey, index);
  }
}
