import 'package:flutter/material.dart';
import 'package:inventory_management/services/dark_theme_prefs.dart';
/*
Định nghĩa một class DarkThemeProvider dùng để quản lý trạng thái chủ đề tối của ứng dụng.
Class DarkThemeProvider kế thừa từ ChangeNotifier là một lớp được cung cấp bởi Flutter 
cho phép giao tiếp giữa các thành phần của ứng dụng.
Với việc sử dụng ChangeNotifier và Provider, các thành phần khác của ứng dụng có thể lắng nghe 
sự thay đổi trạng thái chủ đề tối thông qua class DarkThemeProvider và tự động cập nhật UI tương ứng.*/
class DarkThemeProvider with ChangeNotifier {
  DarkThemePrefs darkThemePrefs = DarkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePrefs.setDarkTheme(value);
    notifyListeners();
  }
}
