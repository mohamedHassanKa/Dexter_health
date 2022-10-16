import 'package:flutter/material.dart';
import 'dart:async';
import '../utils/text_style.dart' as style;

enum switcherState { dayIdle, nightIdle, switchNight, switchDay }

class ThemeChanger with ChangeNotifier {
  static Color lightBackground = const Color(0xFFF6F6F6);
  static Color lightPrimary = const Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = const Color(0xff5563ff);
  static Color darkAccent = const Color(0xff5563ff);
  static Color lightBG = const Color(0xffffffff);
  static Color darkBG = Colors.black;
  static Color ratingBG = Colors.yellowAccent;
  static Color bleuDeFrence = const Color(0xFF2485EA);
  static Color skyBlue = const Color(0xFF35F2FB);
  static Color middleBlue = const Color(0xFF68D8D6);
  static Color primaryTwo = const Color(0xFF6A88E5);
  final ThemeData themeDark = ThemeData(
      textTheme: style.textTheme,
      backgroundColor: darkBG,
      brightness: Brightness.dark,
      primaryColor: bleuDeFrence,
      hintColor: Colors.white.withOpacity(0.7),
      scaffoldBackgroundColor: darkBG,
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: Colors.white,
        cursorColor: darkAccent,
      ));
  final ThemeData themeLight = ThemeData(
      textTheme: style.textTheme,
      backgroundColor: lightBG,
      brightness: Brightness.light,
      primaryColor: bleuDeFrence,
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      hintColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: lightAccent,
        selectionColor: Colors.black,
      ));
  ThemeData? _themeData;
  ThemeChanger() {
    _themeData = themeLight;
  }

  getTheme() => _themeData;
}
