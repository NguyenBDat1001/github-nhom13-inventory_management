import 'package:InventorPlus/ui/appbar.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Lịch sử"),
      body:  Center(
            child: TextWidget(text: "Ứng dụng đang trong giai đoạn phát triển", textSize: 20, color: Colors.amber.shade700,textWeight: FontWeight.w600),
          )
    );
  }
}