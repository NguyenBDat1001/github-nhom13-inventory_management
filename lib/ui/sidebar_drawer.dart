import 'package:flutter/material.dart';
import 'package:inventory_management/screens/appbar/setting_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/user_screen.dart';
import 'package:page_transition/page_transition.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({super.key});

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  void _showScreen(BuildContext context, var screen) {
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, PageTransition(child: screen, type: PageTransitionType.fade));
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepPurpleAccent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                 child: Icon(Icons.account_circle,size: 50,),radius: 35,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Customer Management",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet_outlined),
            title: const Text("User"),
            onTap: () => _showScreen(context, const UserScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Settings"),
            onTap: () => _showScreen(context, const SettingScreen()),
          ),
        ],
      ),
    );
  }
}