import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/loading_screen.dart';
import 'package:InventorPlus/provider/dark_theme_provider.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/animated_dialog_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:InventorPlus/ui/widgets/textfield_form_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  final _formkey = GlobalKey<FormState>();
  final _codeInvoiceController = TextEditingController();
  final _nameInvoicesController = TextEditingController();
  final _addressInvoicesController = TextEditingController();
  final _phoneNumbInvoicesController = TextEditingController();
  final _massInvoicesController = TextEditingController();
  final _lengthInvoicesController = TextEditingController();
  final _widthInvoicesController = TextEditingController();
  final _heightInvoicesController = TextEditingController();
  final _noteInvoicesController = TextEditingController();

  final _codeInvoiceFocusNode = FocusNode();
  final _nameInvoicesFocusNode = FocusNode();
  final _addressInvoicesFocusNode = FocusNode();
  final _phoneNumbInvoicesFocusNode = FocusNode();
  final _massInvoicesFocusNode = FocusNode();
  final _lengthInvoicesFocusNode = FocusNode();
  final _widthInvoicesFocusNode = FocusNode();
  final _heightInvoicesFocusNode = FocusNode();
  final _noteInvoicesFocusNode = FocusNode();
  bool _isLoading = false;
  var uuid = Uuid();
  @override
  void dispose() {
    _codeInvoiceController.dispose();
    _nameInvoicesController.dispose();
    _addressInvoicesController.dispose();
    _phoneNumbInvoicesController.dispose();
    _massInvoicesController.dispose();
    _lengthInvoicesController.dispose();
    _widthInvoicesController.dispose();
    _heightInvoicesController.dispose();
    _noteInvoicesController..dispose();

    _codeInvoiceFocusNode.dispose();
    _nameInvoicesFocusNode.dispose();
    _addressInvoicesFocusNode.dispose();
    _phoneNumbInvoicesFocusNode.dispose();
    _massInvoicesFocusNode.dispose();
    _lengthInvoicesFocusNode.dispose();
    _widthInvoicesFocusNode.dispose();
    _heightInvoicesFocusNode.dispose();
    _noteInvoicesFocusNode.dispose();
    super.dispose();
  }

  void _submitforminvoice() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        final invoiceId = uuid.v4();
        var date = DateTime.now().toString();
        var dataDate = DateTime.parse(date);
        var formDate = "${dataDate.day} - ${dataDate.month} - ${dataDate.year}";
        await FirebaseFirestore.instance
            .collection('invoices')
            .doc(invoiceId)
            .set({
          "id_invoice": invoiceId,
          "code_invoice": _codeInvoiceController.text,
          "name_invoice": _nameInvoicesController.text,
          "address_invoice": _addressInvoicesController.text,
          "phone_invoice": _phoneNumbInvoicesController.text,
          "mass_invoice": _massInvoicesController.text,
          "length_invoice": _lengthInvoicesController.text,
          "width_invoice": _widthInvoicesController.text,
          "height_invoice": _heightInvoicesController.text,
          "note_invoice": _noteInvoicesController.text,
          "userId": _uid,
          'joinedAt':formDate,
          'createdAt': Timestamp.now(),
        });
        Navigator.canPop(context) ? Navigator.pop(context) : null;
        Fluttertoast.showToast(
          msg: "Tạo hóa đơn thành công",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print("Tạo hóa đơn thành công");
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: "$error", context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return AnimatedDialog(
      dialog: Scaffold(
          body: LoadingManager(
        isLoading: _isLoading,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 15, top: 15, left: 10),
                child: Row(
                  children: [
                    Icon(
                      IconlyBroken.paperPlus,
                      size: 34,
                      color: Colors.amber.shade700,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextWidget(
                      text: "Tạo đơn hàng nhập kho",
                      textSize: 25,
                      color: Colors.amber.shade700,
                      textWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Scrollbar(
                radius: const Radius.circular(20),
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 8),
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
                  height: 620,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFieldWidget(
                                      textLabel: "Mã đơn hàng",
                                      textHint: "Nhập Mã đơn hàng (vd: H001)",
                                      focusNode: _codeInvoiceFocusNode,
                                      textType: TextInputType.text,
                                      controller: _codeInvoiceController,
                                      icon: Icons.web_outlined),
                                  const SizedBox(
                                    height: 26,
                                  ),
                                  TextFieldWidget(
                                      textLabel: "Tên đơn hàng",
                                      textHint: "Nhập Tên đơn hàng (vd: Loa)",
                                      focusNode: _nameInvoicesFocusNode,
                                      textType: TextInputType.text,
                                      controller: _nameInvoicesController,
                                      icon: Icons.abc_outlined),
                                  const SizedBox(
                                    height: 26,
                                  ),
                                  TextFieldWidget(
                                      textLabel: "Địa chỉ",
                                      textHint:
                                          "Nhập Địa chỉ (vd: abc/123/HCM)",
                                      focusNode: _addressInvoicesFocusNode,
                                      textType: TextInputType.text,
                                      controller: _addressInvoicesController,
                                      icon: Icons.share_location_outlined),
                                  const SizedBox(
                                    height: 26,
                                  ),
                                  TextFieldWidget(
                                      textLabel: "Số điện thoại",
                                      textHint: "Nhập Số diện thoại",
                                      focusNode: _phoneNumbInvoicesFocusNode,
                                      textType: TextInputType.number,
                                      isNumb: true,
                                      controller: _phoneNumbInvoicesController,
                                      icon: Icons.dialpad_outlined),
                                  const SizedBox(
                                    height: 26,
                                  ),
                                  TextFieldWidget(
                                      textLabel: "Khối lượng (Gram)",
                                      textHint: "Nhập khối lượng (vd: 3000)",
                                      focusNode: _massInvoicesFocusNode,
                                      textType: TextInputType.number,
                                      isNumb: true,
                                      controller: _massInvoicesController,
                                      icon: Icons.scale_outlined),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  TextWidget(
                                      text: "Kích thước Đơn hàng (Cm)",
                                      textSize: 21,
                                      color: null),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                _lengthInvoicesFocusNode),
                                        controller: _lengthInvoicesController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty || value == " ") {
                                            return "Không được bỏ trống";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusColor: Colors.amber.shade700,
                                          labelText: "Chiều Dài",
                                          labelStyle: TextStyle(
                                            color: Colors.amber.shade700,
                                            fontSize: 16,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: _isDark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade700),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 23,
                                        child: Icon(Icons.close_outlined),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                _widthInvoicesFocusNode),
                                        controller: _widthInvoicesController,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty || value == " ") {
                                            return "Không được bỏ trống";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusColor: Colors.amber.shade700,
                                          labelText: "Chiều Rộng",
                                          labelStyle: TextStyle(
                                            color: Colors.amber.shade700,
                                            fontSize: 15,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: _isDark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade700),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
                                      )),
                                      const SizedBox(
                                        width: 23,
                                        child: Icon(Icons.close_outlined),
                                      ),
                                      Expanded(
                                          child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        onEditingComplete: () =>
                                            FocusScope.of(context).requestFocus(
                                                _heightInvoicesFocusNode),
                                        controller: _heightInvoicesController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty || value == " ") {
                                            return "Không được bỏ trống";
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusColor: Colors.amber.shade700,
                                          labelText: "Chiều Cao",
                                          labelStyle: TextStyle(
                                            color: Colors.amber.shade700,
                                            fontSize: 16,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: _isDark
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.amber.shade700),
                                          ),
                                          errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextWidget(
                                      text: "Ghi chú",
                                      textSize: 21,
                                      color: null),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  TextField(
                                    maxLines: 6,
                                    textInputAction: TextInputAction.done,
                                    onEditingComplete: () =>
                                        FocusScope.of(context).requestFocus(
                                            _noteInvoicesFocusNode),
                                    controller: _noteInvoicesController == null
                                        ? null
                                        : _noteInvoicesController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText:
                                          "Nhập Ghi chú (vd: hàng dễ vỡ,...)",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: _isDark
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.amber.shade700),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(95, 40)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.amber.shade700),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          onPressed: () {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          child: TextWidget(
                              text: "Hủy", textSize: 19, color: null),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              minimumSize:
                                  MaterialStateProperty.all(const Size(95, 40)),
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.amber.shade700),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                          onPressed: () {
                            _submitforminvoice();
                          },
                          child: TextWidget(
                              text: "Lưu", textSize: 19, color: null),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      )),
    );
  }
}
