/* Trong Flutter, ThemeData là một lớp được sử dụng để định nghĩa các thông tin về giao diện, 
bao gồm các màu sắc, font chữ, padding, border radius, v.v. 
Một số thuộc tính của ThemeData bao gồm:

+ primaryColor: Màu sắc chính được sử dụng trong ứng dụng.
+ accentColor: Màu sắc phụ được sử dụng trong ứng dụng.
+ backgroundColor: Màu sắc nền chính của ứng dụng.
+ textTheme: Các kiểu chữ được sử dụng trong ứng dụng.
+ textTheme: Các kiểu chữ được sử dụng trong ứng dụng.
+ buttonTheme: Các thông tin về nút, bao gồm các màu, hình dạng, padding, v.v.
+cardTheme: Các thông tin về Card widget, bao gồm các màu, hình dạng, border radius, v.v. */
// VÍ DỤ:
/* MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.blue, // Thiết lập màu chính cho ứng dụng là màu xanh dương
    accentColor: Colors.red, // Thiết lập màu phụ cho ứng dụng là màu đỏ
    backgroundColor: Colors.white, // Thiết lập màu nền chính cho ứng dụng là màu trắng
    textTheme: TextTheme(
      bodyText2: TextStyle(fontSize: 16.0, color: Colors.black), // Thiết lập kiểu chữ cho body text
      headline6: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), // Thiết lập kiểu chữ cho tiêu đề
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, // Thiết lập màu nút là màu xanh dương
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // Thiết lập hình dạng của nút là rounded rectangle
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Thiết lập khoảng cách giữa các nút
    ),
    cardTheme: CardTheme(
      color: Colors.white, // Thiết lập màu nền cho Card widget là màu trắng
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)), // Thiết lập hình dạng của Card widget là rounded rectangle
      elevation: 5.0, // Thiết lập độ nổi của Card widget
    ),
  ),
  home: MyHomePage(),
);
 */

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.amber,
        scaffoldBackgroundColor:
            isDarkTheme ? const Color(0xFF00001a) : Color.fromARGB(255, 254, 251, 248),
        primaryColor: Colors.amber.shade700,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: isDarkTheme
                  ? const Color(0xFF1a1f3c)
                  : const Color(0xFFE8FDFD),
              brightness: isDarkTheme ? Brightness.dark : Brightness.light,
            ),
        cardColor:
            isDarkTheme ? const Color(0xFF0a0d2c) : const Color(0xFFE8FDFD),
        canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light()));
  }
}
