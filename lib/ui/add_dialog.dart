import 'package:InventorPlus/ui/widgets/animated_dialog_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedDialog(
      dialog: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(154, 91, 91, 91),
                      width: 1.7, // Độ dày của đường viền
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      IconlyBroken.paperPlus,
                      size: 32,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    TextWidget(
                      text: "Tạo đơn hàng nhập kho",
                      textSize: 22,
                      color: null,
                      isBold: true,
                    ),
                  ],
                ),
              ),
              TextWidget(text: "Mã đơn hàng", textSize: 18, color: null),
              SizedBox(
                height: 6,
              ),
              TextFormField(
                controller: _textEditingController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nhập mã đơn hàng(vd: 001)"),
              ),
              SizedBox(
                height: 23,
              ),
              TextWidget(text: "Tên đơn hàng", textSize: 18, color: null),
              SizedBox(
                height: 6,
              ),
              TextField(
                controller: _textEditingController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nhập tên đơn hàng(vd: Loa)"),
              ),
              SizedBox(
                height: 23,
              ),
              TextWidget(
                  text: "đơn vị tính(Gram)", textSize: 18, color: null),
              SizedBox(
                height: 6,
              ),
              TextField(
                controller: _textEditingController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nhập đơn vị tính(vd: 300)"),
              ),
              
              TextField(
                controller: _textEditingController,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Nhập đơn vị tính(vd: 300)"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Lưu"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
