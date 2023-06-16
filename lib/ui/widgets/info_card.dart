import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  InfoCardWidget(
      {super.key, required this.text, required this.icon, required this.fct});
  final String text;
  final IconData icon;
  final Function fct;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        fct();
      },
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.amber.shade700,
          ),
          title: TextWidget(
              text: text, textSize: 20, color: Colors.amber.shade700,textWeight: FontWeight.w500,letterSpacing: 1),
        ),
      ),
    );
  }
}
