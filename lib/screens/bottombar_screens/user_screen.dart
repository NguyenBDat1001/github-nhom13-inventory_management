import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/screens/appbar/setting_screen.dart';
import 'package:inventory_management/ui/widgets/text_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  void _showScreen(BuildContext context, var screen) {
    Navigator.push(
        context,
        PageTransition(
            child: screen, type: PageTransitionType.leftToRightWithFade));
  }

  Widget _listTiles(
      {String? subtitle,
      required String title,
      required IconData icon,
      required Function onPressed}) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color _changeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    return ListTile(
      title: TextWidget(text: title, color: _changeColor, textSize: 21),
      subtitle: TextWidget(
          text: subtitle == null ? "" : subtitle,
          color: Colors.amber.shade700,
          textSize: 14),
      leading: Icon(icon),
      trailing: const Icon(IconlyBroken.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color _changeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 55,
                ),
                RichText(
                    text: TextSpan(
                        text: "Xin chào,  ",
                        style: TextStyle(
                            color: Colors.amber.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                        children: <TextSpan>[
                      TextSpan(
                          text: "User 1",
                          style: TextStyle(
                              color: _changeColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 22),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("My name is ");
                            })
                    ])),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                    text: "nguyendat20018@gmail.com",
                    color: Colors.amber.shade700,
                    textSize: 15),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 2,
                ),
                const SizedBox(
                  height: 20,
                ),
                _listTiles(
                    title: "Chỉnh sửa thông tin",
                    subtitle: "User1",
                    icon: IconlyBroken.editSquare,
                    onPressed: () {}),
                _listTiles(
                    title: "Cài đặt",
                    icon: IconlyBroken.setting,
                    onPressed: () =>
                        _showScreen(context, const SettingScreen())),
                _listTiles(
                    title: "Góp ý, hỗ trợ",
                    icon: IconlyBroken.send,
                    onPressed: () {}),
                _listTiles(
                    title: "Đăng xuất",
                    icon: IconlyBroken.logout,
                    onPressed: () {}),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextWidget(
                      text: "Phiên bản: v1.0.0",
                      color: Colors.amber.shade700,
                      textSize: 13),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
