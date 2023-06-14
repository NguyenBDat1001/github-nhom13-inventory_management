
import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final User? user = authInstance.currentUser;

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const BottomBar(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
const AnimationBackground(),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
           Center(
            child: SpinKitFadingFour(
              color: Colors.amber.shade700,
            ),
          )
        ],
      ),
    );
  }
}
