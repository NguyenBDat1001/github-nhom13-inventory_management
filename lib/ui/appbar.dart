import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/ui/widgets/text_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;

    return AppBar(
      title: TextWidget(
          text: title,
          textSize: 24,
          color: _isDark ? Colors.white : Colors.amber.shade700),
      backgroundColor: const Color.fromARGB(0, 255, 162, 0),
      elevation: 0,
      centerTitle: true,
      bottom: const PreferredSize(
          child: Divider(
            color: Colors.grey,
            height: 1,
          ),
          preferredSize: Size.fromHeight(1)),
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            IconlyBroken.arrowLeft2,
            color: _isDark ? Colors.white : Colors.black,
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
