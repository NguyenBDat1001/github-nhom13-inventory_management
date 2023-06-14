import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.fct,
    required this.buttonText,
    this.primary = Colors.white38,
  }) : super(key: key);
  final Function fct;
  final String buttonText;
  final Color primary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(280, 50)),
              backgroundColor: MaterialStatePropertyAll(Colors.amber.shade700),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)))),
          onPressed: () {
            fct();
            // _submitFormOnLogin();
          },
          child: Text(
            buttonText,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 21),
          )),
    );
  }
}
