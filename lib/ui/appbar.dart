import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;

    return PreferredSize(
      preferredSize: const Size.fromHeight(42.0),
      child: AppBar(
        title: Text(title,
            style: TextStyle(
              color: _isDark ? Colors.white :Colors.amber.shade700,
              fontSize: 22,
            )),
        backgroundColor:const Color.fromARGB(0, 255, 162, 0),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              IconlyBroken.arrowLeft2,
              color: _isDark ? Colors.white : Colors.black,
            )),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(42);
}