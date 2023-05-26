import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/screens/bottombar_screens/export_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/home_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/import_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/user_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  final List _page = [
    const HomeScreen(),
    const ImportScreen(),
    const ExportScreen(),
    const UserScreen()
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
      PageTransition(
          child: _page[_selectedIndex], type: PageTransitionType.fade);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    Color _changeCol = _isDark ? Colors.white : Colors.amber.shade700;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(43.0),
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 40),
              Image.asset(
                'assets/images/IP(97).png',
                width: 72,
                height: 70,
              ),
              Text('InventorPlus',
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  IconlyBroken.arrowDownCircle,
                  color: _changeCol,size: 25,
                ))
          ],
          backgroundColor: const Color.fromARGB(0, 255, 162, 0),
          elevation: 0,
        ),
      ),
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          onTap: _selectedPage,
          currentIndex: _selectedIndex,
          unselectedItemColor: _changeCol,
          selectedItemColor: _changeCol,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Trang chủ",
            ),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.arrowDownSquare
                    : IconlyLight.arrowDownSquare),
                label: "Nhập kho"),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 2
                    ? IconlyBold.arrowUpSquare
                    : IconlyLight.arrowUpSquare),
                label: "Xuất kho"),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 3
                    ? IconlyBold.profile
                    : IconlyLight.profile),
                label: "Tài khoản")
          ]),
    );
  }
}
