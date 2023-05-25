import 'package:flutter/material.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
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
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
          backgroundColor: Colors.amber.shade700,
          elevation: 5,
          centerTitle: true,
        ),
        drawer: Drawer(),
        body: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Center(
                  child: SwitchListTile(
                    title: const Text("Nền tối"),
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
