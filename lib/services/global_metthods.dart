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
    required Icon icon,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
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
              child: Row(children: [
                 icon,
                const SizedBox(width: 5),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22)),
              ]),
            ),
            content: Text(
              subtitle,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(100, 40)),
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
                    child: const Text(
                      "Không",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    )),
              ),
              const SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(100, 40)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.amber.shade700),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3)))),
                    onPressed: () {
                      fct();
                    },
                    child: const Text(
                      "Có",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    )),
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
              child: Row(children: const [
                Icon(
                  IconlyBroken.danger,
                  size: 30,
                ),
                SizedBox(
                  width: 5,
                ),
                Text('Lỗi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              ]),
            ),
            content: Text(subtitle),
            actions: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(100, 40)),
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
                    child: const Text(
                      "Đóng",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    )),
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
