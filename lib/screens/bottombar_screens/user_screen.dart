import 'package:InventorPlus/ui/logout_dialog.dart';
import 'package:InventorPlus/ui/widgets/animated_dialog_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/screens/bottombar_screens/home_screen.dart';
import 'package:InventorPlus/screens/user_screens/setting_screen.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
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
    return ListTile(
      title: TextWidget(
        text: title,
        textSize: 21,
        color: null,
      ),
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

  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return LogoutDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color _changeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                  "assets/images/photo-1633332755192-727a05c4013d.png"),
              radius: 72,
            ),
            const SizedBox(
              height: 18,
            ),
            RichText(
                text: TextSpan(
                    text: "Xin chào, ",
                    style: TextStyle(
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                    children: <TextSpan>[
                  TextSpan(
                      text: "User1",
                      style: TextStyle(
                          color: _changeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 23),
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
              height: 10,
            ),
            const Divider(
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(7),
              child: Column(
                children: [
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
                      onPressed: () {
                        _showLogoutDialog();
                      }),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextWidget(
                        text: "Phiên bản: v1.0.0",
                        color: Colors.amber.shade700,
                        textSize: 13),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
