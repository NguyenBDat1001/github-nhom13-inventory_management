import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/screens/landing_page.dart';
import 'package:InventorPlus/services/global_metthods.dart';
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
          decoration:  BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.amber.shade700,
                width: 1.7,
              ),
            ),
          ),
          child: Row(
            children: const [
              Icon(
                IconlyBroken.danger,
                size: 30,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Đăng xuất",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
            ],
          ),
        ),
        content: const Text("Bạn có chắc muốn đăng xuất không?"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10, bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(85, 40)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber.shade700),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)))),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: TextWidget(text: "Không", textSize: 18, color: null,textWeight: FontWeight.w600,)),
              
                const SizedBox(width: 20),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(85, 40)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber.shade700),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)))),
                    onPressed: () async {
                      await authInstance.signOut();
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: LandingPage.routeName);
                    },
                    child: TextWidget(text: "Có", textSize: 18, color: null,textWeight: FontWeight.w600,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
