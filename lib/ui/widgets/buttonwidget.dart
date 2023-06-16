import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CusButtonWidget extends StatelessWidget {
  const CusButtonWidget({
    Key? key,
    required this.fct,
    required this.height,
    required this.width,
    required this.buttonText,
    this.textsize
  }) : super(key: key);
  final Function fct;
  final String buttonText;
  final double height;
  final double width;
  final double? textsize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(width, height)),
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
            style:  TextStyle(fontWeight: FontWeight.w500, fontSize: textsize == null ? 20 : textsize),
          )),
    );
  }
}
