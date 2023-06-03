import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              const Icon(IconlyBroken.logout),
              const SizedBox(
                width: 8,
              ),
              Text(title),
            ]),
            content: Text(subtitle),
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(132, 121, 121, 121),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    color: Colors.cyan,
                    text: 'Không',
                    textSize: 18,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(132, 121, 121, 121),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: () {
                    fct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    color: Colors.red,
                    text: 'Có',
                    textSize: 18,
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: const [
              Icon(IconlyBroken.logout),
              SizedBox(
                width: 8,
              ),
              Text('Đã xảy ra lỗi'),
            ]),
            content: Text(subtitle),
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(132, 121, 121, 121),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: TextWidget(
                    color: Colors.cyan,
                    text: 'Ok',
                    textSize: 18,
                  ),
                ),
              ),
            ],
          );
        });
  }

  static Future<void> addToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Mục đã được thêm vào giỏ hàng của bạn",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }

  static Future<void> addToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userWish': FieldValue.arrayUnion([
          {
            'wishlistId': wishlistId,
            'productId': productId,
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Mục đã được thêm vào danh sách mong muốn của bạn",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}
