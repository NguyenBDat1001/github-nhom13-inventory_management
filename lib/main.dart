import 'package:flutter/material.dart';
import 'package:inventory_management/consts/theme_data.dart';
import 'package:inventory_management/provider/dark_theme_provider.dart';
import 'package:inventory_management/screens/intro_screen.dart';
import 'package:inventory_management/screens/sidebar_screens/setting_screen.dart';
import 'package:inventory_management/ui/bottom_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) {
              return themeChangeProvider;
            },
          )
        ],
        child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: const SettingScreen());
        }));
  }
}
