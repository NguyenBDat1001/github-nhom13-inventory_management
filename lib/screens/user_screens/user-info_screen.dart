import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/ui/appbar.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/auth_button.dart';
import 'package:InventorPlus/ui/widgets/info_card.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  String? _email;
  String? _name;
  String? _warehouseAddress;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
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
        _warehouseAddress = userDoc.get('warehouse-address');
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

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      appBar: const CustomAppBar(title: "Thông tin người dùng"),
    
      body: LoadingManager(
        isLoading: _isLoading,
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 10),
            child: Column(
          children: <Widget>[
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                  "assets/images/photo-1633332755192-727a05c4013d.png"),
              radius: 65,
              
            ),
            const SizedBox(height: 5),
            TextWidget(
              text: "InventorPlus",
              textSize: 35,
              color: Colors.amber.shade700,
              textWeight: FontWeight.bold,
              
              textStyle: FontStyle.italic,
            ),
            Text(
              "Thông tin",
              style: TextStyle(
                  fontSize: 26,
                  color: _isDark ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),const SizedBox(
              height: 20,
              width: 300,
              child: Divider(
               thickness: 2,
              ),
            ),
            const SizedBox(height: 5),
            InfoCardWidget(text:"${_email == null ? 'Email' : _email!}", icon: Icons.near_me, fct: (){}),
            InfoCardWidget(text:"${_name == null ? 'User' : _name}", icon: Icons.email, fct: (){}),
            InfoCardWidget(text:"${_warehouseAddress == null ? 'Location' : _warehouseAddress}", icon: Icons.location_on, fct: (){}),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: AuthButton(fct: (){}, buttonText: "Thay đổi thông tin"),
            )
          ],
        )),
      ),
    );
  }
}
