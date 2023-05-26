import 'package:flutter/material.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/ui/appbar.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
        appBar: CustomAppBar(title: "Cài đặt") /* PreferredSize(
          preferredSize: const Size.fromHeight(42.0),
          child: AppBar(
            title: Text(
              'Cài đặt',
              style: TextStyle(
                  color: _isDark
                      ?  Colors.white
                      : Colors.black87),
            ),
            backgroundColor: Colors.amber.shade700,
            centerTitle: true,
          ),
        )*/, 
        body: Container(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Center(
                  child: SwitchListTile(
                    title: _isDark ? const Text("Nền tối") : const Text("Nền sáng"),
                    secondary: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                    value: themeState.getDarkTheme,
                    onChanged: (bool value) {
                      setState(() {
                        themeState.setDarkTheme = value;
                      });
                    },
                  ),
                ),
              ],
            )));
  }
}
