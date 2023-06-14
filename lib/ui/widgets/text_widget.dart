import 'package:flutter/material.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class TextWidget extends StatelessWidget {
  TextWidget(
      {super.key,
      required this.text,
      required this.textSize,
      this.textWeight,
      this.maxLines = 10,
      required this.color,
      this.textStyle,
      this.letterSpacing});
  final String text;
  final Color? color;
  final double textSize;
  final FontStyle? textStyle;
  final double? letterSpacing;
  final FontWeight? textWeight;
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
          fontWeight: textWeight,
          fontStyle: textStyle,
          letterSpacing: letterSpacing),
    );
  }
}
