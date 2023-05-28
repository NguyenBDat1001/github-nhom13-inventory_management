import 'package:flutter/material.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class TextWidget extends StatelessWidget {
  TextWidget({
    super.key,
    required this.text,
    required this.textSize,
    this.isBold = false,
    this.maxLines = 10,
    required this.color,
  });
  final String text;
  final Color? color;
  final double textSize;
  bool isBold;
  int maxLines = 10;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color _changeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: color == null ? _changeColor : color,
          fontSize: textSize,
          fontWeight: isBold == false ? FontWeight.normal : FontWeight.bold),
    );
  }
}
