import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      required this.textLabel,
      required this.textHint,
      required this.focusNode,
      required this.controller,
      required this.textType,
      required this.icon,
      this.isNumb});
  final String textLabel;
  final String textHint;
  final IconData icon;
  final TextInputType textType;
  bool? isNumb = false;
  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final bool _isDark = themeState.getDarkTheme;
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: () => FocusScope.of(context).requestFocus(focusNode),
      controller: controller,
      inputFormatters: isNumb == true ? [FilteringTextInputFormatter.digitsOnly] : null,
      keyboardType: textType,
      validator: (value) {
        if (value!.isEmpty || value == " ") {
          return "Không được bỏ trống";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        focusColor: Colors.amber.shade700,
        prefixIcon: Icon(icon, color: Colors.amber.shade700),
        labelText: textLabel,
        labelStyle: TextStyle(
          color: Colors.amber.shade700,
          fontSize: 19,
        ),
        hintText: textHint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: _isDark ? Colors.white : Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber.shade700),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
