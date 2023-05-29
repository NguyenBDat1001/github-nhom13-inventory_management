import 'package:InventorPlus/screens/intro_page.dart';
import 'package:InventorPlus/screens/user/login_screen.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimationBackground(),
          /* Image.asset(
            "assets/images/zyro-image_landing.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: FractionalOffset(_animation.value, 0),
          ), */
          Container(
            padding: EdgeInsets.only(top: 20),
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const IntroPage(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextWidget(
                        text: "Quay lại", textSize: 16, color: Colors.white),
                    SizedBox(
                      height: 10,
                    ),
                    Icon(
                      IconlyLight.arrowRight2,
                      color: Colors.white,
                    ),
                  ],
                )),
          ),
          Container(
            margin: EdgeInsets.only(top: 75),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    alignment: Alignment.topLeft,
                    "assets/images/Logo_app_inventorplus_landing.png",
                    cacheHeight: 77,
                    cacheWidth: 228,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Text(
                    "Chào mừng đến với InventorPlus - ứng dụng quản lý kho hiệu quả",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(27),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(365, 53)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber.shade700),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: const LoginScreen(),
                              type: PageTransitionType.fade));
                    },
                    child: Text(
                      "Đăng nhập",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
                    )),
                SizedBox(
                  height: 13,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Bạn chưa có tài khoản?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 21),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
