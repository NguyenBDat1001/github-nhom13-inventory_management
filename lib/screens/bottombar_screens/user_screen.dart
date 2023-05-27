import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/screens/bottombar_screens/home_screen.dart';
import 'package:inventory_management/screens/user_screens/setting_screen.dart';
import 'package:inventory_management/ui/bottom_bar.dart';
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
        return AlertDialog(
          title: Container(
            padding: EdgeInsets.all(8),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(201, 74, 74, 74),
                  width: 1.7,         // Độ dày của đường viền
                ),
              ),
            ),
            child: Row(children: const [
              Icon(
                IconlyBroken.danger,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Đăng xuất",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
          ),
          content: const Text("Bạn có chắc muốn đăng xuất không?"),
          actions: [
            TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: Container(
                  padding:
                     const EdgeInsets.only(bottom: 10,top: 10, left: 18, right: 18),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(156, 84, 84, 84),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: TextWidget(
                    text: "Không",
                    textSize: 18,
                    isBold: true,
                    color: null,
                  ),
                )),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => _showScreen(context, const BottomBar()),
                child: Container(
                  padding:
                      const EdgeInsets.only(bottom: 10,top: 10, left: 18, right: 18),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(156, 84, 84, 84),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6)),
                  child: TextWidget(
                    text: "Có",
                    color: Colors.red,
                    textSize: 18,
                    isBold: true,
                  ),
                )),
          ],
        );
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(
                      "assets/images/photo-1633332755192-727a05c4013d.png"),
                  radius: 68,
                ),
                const SizedBox(
                  height: 20,
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
                    onPressed: () {
                      _showLogoutDialog();
                    }),
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
