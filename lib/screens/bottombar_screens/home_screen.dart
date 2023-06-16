import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final _formkey = GlobalKey<FormState>();
  final _codeOrdersController = TextEditingController();
  final _nameOrdersController = TextEditingController();
  final _addressOrdersController = TextEditingController();
  final _phoneNumbOrdersController = TextEditingController();
  final _massOrdersController = TextEditingController();
  final _lengthOrdersController = TextEditingController();
  final _widthOrdersController = TextEditingController();
  final _heightOrdersController = TextEditingController();

  final _codeOrdersFocusNode = FocusNode();
  final _nameOrdersFocusNode = FocusNode();
  final _addressOrderssFocusNode = FocusNode();
  final _phoneNumbOrdersFocusNode = FocusNode();
  final _massOrdersFocusNode = FocusNode();
  final _lengthOrdersFocusNode = FocusNode();
  final _widthOrdersFocusNode = FocusNode();
  final _heightOrdersFocusNode = FocusNode();
class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 12,
                    top: 12,
                    left: 8
                  ),
                  
                  child: Row(
                    children: [
                      Icon(
                        IconlyBroken.paperPlus,
                        size: 32,
                        color: Colors.amber.shade700,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextWidget(
                        text: "Tạo đơn hàng nhập kho",
                        textSize: 23,
                        color: Colors.amber.shade700,
                        textWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
          
                Scrollbar(
                  
                  radius: const Radius.circular(20),
                  child: Container(
                     padding: const EdgeInsets.only(top: 5,left: 5,right: 8,bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.amber.shade700,
                          width: 1.5,
                        ), 
                        bottom: BorderSide(
                          color: Colors.amber.shade700,
                          width: 1.5,
                        ),
                      ),
                    ),
                    width: double.maxFinite,
                    height: 625,
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                                text: "Mã đơn hàng", textSize: 17, color: null),
                            const SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              controller: _codeOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập mã đơn hàng(vd: 001)"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "Tên đơn hàng", textSize: 17, color: null),
                            const SizedBox(
                              height: 6,
                            ),
                            TextField(
                              controller: _nameOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập tên đơn hàng(vd: Loa)"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "Địa chỉ", textSize: 17, color: null),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _addressOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập Địa chỉ(vd: Tp.HCM)"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "Số điện thoại", textSize: 17, color: null),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _phoneNumbOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập số điện thoại"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "Khối lượng(Gram)",
                                textSize: 17,
                                color: null),
                            const SizedBox(
                              height: 5,
                            ),
                            TextField(
                              controller: _massOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập khối lượng(vd: 300)"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "chiều dài(Cm)", textSize: 17, color: null),
                            const SizedBox(
                              height: 6,
                            ),
                            TextField(
                              controller: _lengthOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập chiều dài(vd: 10)"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "Chiều rộng(Cm)",
                                textSize: 17,
                                color: null),
                            const SizedBox(
                              height: 6,
                            ),
                            TextField(
                              controller: _widthOrdersController,
                              style: const TextStyle(fontSize: 18),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Nhập Chiều rộng(vd: 30)"),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            TextWidget(
                                text: "Chiều cao(Cm)", textSize: 17, color: null),
                            const SizedBox(
                              height: 6,
                            ),
                            TextField(
                              controller: _heightOrdersController,
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
                ), 
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(90, 38)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.amber.shade700),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: TextWidget(
                                text: "Hủy", textSize: 17, color: null),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(90, 38)),
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.amber.shade700),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: TextWidget(
                                text: "Lưu", textSize: 17, color: null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        )
      );
  }
}
