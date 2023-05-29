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
          padding: const EdgeInsets.all(8),
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
                IconlyBroken.danger,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Đăng xuất",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        content: const Text("Bạn có chắc muốn đăng xuất không?"),
        actions: [
          TextButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: Container(
              padding:
                  const EdgeInsets.only(bottom: 9, top: 9, left: 16, right: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(132, 121, 121, 121),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextWidget(
                text: "Không",
                textSize: 17,
                isBold: true,
                color: null,
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const LandingPage(),
                                        type: PageTransitionType.fade));
            },
            child: Container(
              padding:
                  const EdgeInsets.only(bottom: 9, top: 9, left: 29, right: 29),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(132, 121, 121, 121),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(3),
              ),
              child: TextWidget(
                text: "Có",
                color: Colors.red,
                textSize: 17,
                isBold: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
