import 'package:InventorPlus/screens/intro_page.dart';
import 'package:InventorPlus/screens/user/forget_pass.dart';
import 'package:InventorPlus/screens/user/login_screen.dart';
import 'package:InventorPlus/screens/user/register_screen.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/LandingPage';
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
          const AnimationBackground(),
          Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(top: 40, right: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.of(context).pushReplacement(PageTransition(
                    child: const IntroPage(),
                    type: PageTransitionType.rightToLeftWithFade));
              },
              child: TextWidget(
                  text: "Quay lại", textSize: 20, color: Colors.amber.shade700),
            ),
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
                const SizedBox(
                  height: 15,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text.rich(
                      TextSpan(
                          text: "InventorPlus\n",
                          style: TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade700),
                          children: const [
                            TextSpan(
                                text: "Ứng dụng quản lý kho hiệu quả",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white))
                          ]),
                    ))
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(27),
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
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: LoginScreen.routeName);
                    },
                    child: const Text(
                      "Đăng nhập",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
                    )),
                const SizedBox(
                  height: 13,
                ),
                InkWell(
                    onTap: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: RegisterScreen.routeName);
                    },
                    child: const Text(
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
