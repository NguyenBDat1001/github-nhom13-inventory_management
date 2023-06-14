import 'package:InventorPlus/screens/bottombar_screens/user_screen.dart';
import 'package:InventorPlus/screens/landing_page.dart';
import 'package:InventorPlus/screens/user/login_screen.dart';
import 'package:InventorPlus/screens/user/register_screen.dart';
import 'package:InventorPlus/screens/user_screens/user-info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:InventorPlus/consts/theme_data.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/screens/intro_page.dart';
import 'package:InventorPlus/screens/user_screens/setting_screen.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'screens/user/forget_pass.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(initialization);
  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  // Load resources
  await Future.delayed(Duration(seconds: 1));
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

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: Text("Đã xảy ra lỗi!")),
              ),
            );
          }
          return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) {
                    return themeChangeProvider;
                  },
                ),
                ChangeNotifierProvider(
                  create: (_) => DarkThemeProvider(),
                ),
            
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeProvider, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'InventorPlus application',
                  theme: Styles.themeData(themeProvider.getDarkTheme, context),
                  home: const UserScreen(),
                  routes: {
                    RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                    LoginScreen.routeName: (ctx) => const LoginScreen(),
                    ForgetPasswordScreen.routeName: (ctx) =>
                        const ForgetPasswordScreen(),
                    LandingPage.routeName: (ctx) => const LandingPage(),
                  },
                );
              }));
        });
  }
}
