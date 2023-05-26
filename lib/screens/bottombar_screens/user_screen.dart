import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/screens/appbar/setting_screen.dart';
import 'package:page_transition/page_transition.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}
class _UserScreenState extends State<UserScreen> {
  void _showScreen(BuildContext context, var screen){
Navigator.pushReplacement(context, PageTransition(child: screen, type: PageTransitionType.leftToRightWithFade));
}
  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 21,
        ),
      ),
      subtitle: Text(subtitle == null ? "" : subtitle),
      leading: Icon(icon),
      trailing: const Icon(IconlyBroken.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _listTiles(
                title: "Chỉnh sửa thông tin",
                subtitle: "nguyenbadat20018@gmail.com",
                icon: IconlyBroken.editSquare,
                onPressed: () {}),
            _listTiles(
                title: "Cài đặt", icon: IconlyBroken.setting, onPressed: () => _showScreen(context, const SettingScreen())),
            _listTiles(
                title: "Góp ý, Khiếu nại",
                icon: IconlyBroken.danger,
                onPressed: () {}),
            _listTiles(
                title: "Đăng xuất",
                icon: IconlyBroken.logout,
                onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
