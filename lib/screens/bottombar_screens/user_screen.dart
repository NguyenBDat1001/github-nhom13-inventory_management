
import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/screens/user_screens/user-info_screen.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/logout_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/screens/user_screens/setting_screen.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
   String? _name;
   String? _email;
   bool _isLoading = false;
   final User? user = authInstance.currentUser;
@override
  void initState() {
    getUserData();
    super.initState();
  }

   Future<void>  getUserData() async {
     setState(() {
      _isLoading = true;
    });
     if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
  void _showScreen(BuildContext context, var screen) {
    Navigator.push(
        context,
        PageTransition(
            child: screen, type: PageTransitionType.leftToRightWithFade));
  }
  Future<void> _showLogoutDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return const LogoutDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    Color _changeColor = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                    "assets/images/photo-1633332755192-727a05c4013d.png"),
                radius: 70,
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                  text: TextSpan(
                      text: "Xin chào, ",
                      style: TextStyle(
                          color: Colors.amber.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                      children: <TextSpan>[
                    TextSpan(
                        text:  _name == null ? 'User' : _name,
                        style: TextStyle(
                            color: _changeColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 25),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("My name is ");
                          })
                  ])),
              const SizedBox(
                height: 3,
              ),
              TextWidget(
                  text:  _email == null ? 'Email' : _email!, color: Colors.amber.shade700, textSize: 15),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(7),
                child: Column(
                  children: [
                    _listTiles(
                        title: "Thông tin người dùng",
                        subtitle:  _name == null ? 'User' : _name,
                        icon: IconlyBroken.editSquare,
                        onPressed:  () =>
                            _showScreen(context, const UserInfoScreen())),
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
      ),
    );
  }
}
