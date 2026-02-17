import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

enum AppThemeType { light, dark }

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  AppThemeType _currentThemeType = AppThemeType.light;

  ThemeMode get themeMode => _themeMode;
  AppThemeType get currentThemeType => _currentThemeType;

  void setThemeType(AppThemeType type) {
    _currentThemeType = type;
    if (type == AppThemeType.light) {
      _themeMode = ThemeMode.light;
    } else {
      _themeMode = ThemeMode.dark;
    }
    notifyListeners();
  }

  ThemeData get lightTheme => AppTheme.light;

  ThemeData get darkTheme => AppTheme.dark;
}
