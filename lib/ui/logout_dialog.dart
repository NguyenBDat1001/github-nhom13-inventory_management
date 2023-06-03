import 'package:InventorPlus/screens/landing_page.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/widgets/animated_dialog_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';

class LogoutDialog extends StatefulWidget {
  const LogoutDialog({super.key});

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return AnimatedDialog(
      dialog: AlertDialog(
        title: Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(201, 74, 74, 74),
                width: 1.7,
              ),
            ),
          ),
          child: Row(
            children: const [
              Icon(
                IconlyBroken.danger,size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Đăng xuất",
                style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 23
                ),
              ),
            ],
          ),
        ),
        content: const Text("Bạn có chắc muốn đăng xuất không?"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10,bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(132, 121, 121, 121),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: TextWidget(
                      text: "Không",
                      textSize: 18,
                      isBold: true,
                      color: null,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(132, 121, 121, 121),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const LandingPage(),
                              type: PageTransitionType.fade));
                    },
                    child: TextWidget(
                      text: "Có",
                      color: Colors.red,
                      textSize: 18,
                      isBold: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
