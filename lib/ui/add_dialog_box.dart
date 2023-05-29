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
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          //height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10, top: 10,),
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
                        textSize: 23,
                        color: null,
                        isBold: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                Container(
                  width: double.maxFinite,
                  height: 500,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                              text: "Mã đơn hàng", textSize: 17, color: null),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: _textEditingController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nhập mã đơn hàng(vd: 001)"),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextWidget(
                              text: "Tên đơn hàng", textSize: 17, color: null),
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
                            height: 18,
                          ),
                          TextWidget(
                              text: "Địa chỉ", textSize: 17, color: null),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _textEditingController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nhập Địa chỉ(vd: Tp.HCM)"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextWidget(
                              text: "Khối lượng(Gram)",
                              textSize: 17,
                              color: null),
                          SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: _textEditingController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nhập khối lượng(vd: 300)"),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextWidget(
                              text: "chiều dài(Cm)", textSize: 17, color: null),
                          SizedBox(
                            height: 6,
                          ),
                          TextField(
                            controller: _textEditingController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nhập chiều dài(vd: 10)"),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextWidget(
                              text: "Chiều rộng(Cm)",
                              textSize: 17,
                              color: null),
                          SizedBox(
                            height: 6,
                          ),
                          TextField(
                            controller: _textEditingController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nhập Chiều rộng(vd: 30)"),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextWidget(
                              text: "Chiều cao(Cm)", textSize: 17, color: null),
                          SizedBox(
                            height: 6,
                          ),
                          TextField(
                            controller: _textEditingController,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Nhập Chiều cao(vd: 20)"),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                     style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(90, 38)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber.shade700),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: TextWidget(text: "Lưu", textSize: 17, color: null),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
