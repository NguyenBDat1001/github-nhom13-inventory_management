import 'package:InventorPlus/ui/add_dialog_box.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/screens/bottombar_screens/export_screen.dart';
import 'package:InventorPlus/screens/bottombar_screens/home_screen.dart';
import 'package:InventorPlus/screens/bottombar_screens/import_screen.dart';
import 'package:InventorPlus/screens/bottombar_screens/user_screen.dart';
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
    " ",
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

  Future<void> _showDiaLog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return MyDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    Color _changeCol = _isDark ? Colors.white : Colors.amber.shade700;
    return Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48.0),
        child: AppBar(
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/IP(97).png',
                  width: 72,
                  height: 70,
                ),
                Text('InventorPlus',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  IconlyBroken.timeCircle,
                  color: _changeCol,
                  size: 26,
                ))
          ],
          backgroundColor: const Color.fromARGB(0, 255, 162, 0),
          elevation: 0,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(color: Colors.grey, height: 1),
          ),
        ),
      ),
      body: _page[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 0.11,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
            backgroundColor:
                _isDark ? Theme.of(context).cardColor : Colors.white,
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
             const BottomNavigationBarItem(
                  icon: Icon(null), activeIcon: null, label: ""),
              BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 3
                      ? IconlyBold.arrowUpSquare
                      : IconlyLight.arrowUpSquare),
                  label: "Xuất kho"),
              BottomNavigationBarItem(
                  icon: Icon(_selectedIndex == 4
                      ? IconlyBold.profile
                      : IconlyLight.profile),
                  label: "Tài khoản")
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            onPressed: () {
              _showDiaLog(context);
            },
            hoverElevation: 15,
            splashColor: Colors.grey,
            backgroundColor: Colors.amber.shade700,
            tooltip: "Thêm mới đơn hàng",
            elevation: 6,
            child: Icon(
              Icons.add,
              color: _isDark ? Colors.white : Colors.black,
              size: 32,
            )),
      ),
    );
  }
}
