import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/screens/bottombar_screens/export_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/history_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/home_screen.dart';
import 'package:inventory_management/screens/bottombar_screens/import_screen.dart';
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
    const HistoryScreen()
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          onTap: _selectedPage,
          currentIndex: _selectedIndex,
          unselectedItemColor: _isDark ? Colors.white : Colors.amber.shade700,
          selectedItemColor: _isDark ? Colors.white : Colors.amber.shade700,
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
                    ? IconlyBold.timeCircle
                    : IconlyLight.timeCircle),
                label: "Lịch sử")
          ]),
    );
  }
}
