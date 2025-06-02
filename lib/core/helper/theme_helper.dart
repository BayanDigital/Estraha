// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:booking_box/core/helper/shared_preference_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:booking_box/core/utils/my_color.dart';

/// Light Mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(surface: MyColor.colorWhite),
  scaffoldBackgroundColor: MyColor.colorWhite,
  cardColor: MyColor.colorWhite,
  primaryColor: MyColor.colorBlack,
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColor.colorWhite,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: MyColor.colorWhite,
      statusBarIconBrightness: Brightness.dark, // Icons in status bar
      statusBarBrightness: Brightness.light, // For iOS
    ),
  ),
);

/// Dark Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(surface: MyColor.darkModeColor),
  scaffoldBackgroundColor: MyColor.darkModeColor,
  cardColor: MyColor.colorBlack.withOpacity(0.60),
  primaryColor: MyColor.colorWhite,
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColor.darkModeColor,
    iconTheme: IconThemeData(
      color: MyColor.colorWhite,
    ),
    titleTextStyle: TextStyle(color: MyColor.colorWhite, fontSize: 18),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: MyColor.darkModeColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  ),
);

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData;
  bool _isDark = false;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDark;

  Future<void> _loadTheme() async {
    _isDark = SharedPreferenceHelper.getBool(key: 'isDark') ?? false;
    _themeData = _isDark ? darkMode : lightMode;
    notifyListeners();
  }

  void toggleTheme() {
    _isDark = !_isDark;
    _themeData = _isDark ? darkMode : lightMode;
    SharedPreferenceHelper.saveBool(key: 'isDark', value: _isDark);
    notifyListeners();
  }
}
