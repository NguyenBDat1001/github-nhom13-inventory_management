import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _obscureText = true;
  @override
  void dispose() {
    _emailTextController.dispose();
    _passTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }
 bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingManager(isLoading: _isLoading,
          child: Stack(
              children: [
          AnimationBackground(),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 100),
                    TextWidget(
                      text: "Thật tuyệt khi bạn trở lại!",
                      textSize: 31,
                      color: Colors.white,
                      isBold: true,
                    ),
                    SizedBox(height: 12),
                    TextWidget(
                      text: "Đăng nhập để tiếp tục",
                      color: Colors.amber.shade700,
                      textSize: 21,
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passFocusNode),
                              controller: _emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "Vui lòng nhập email hợp lệ";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Nhập Email (ex: abc@gmail.com)",
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber.shade700),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700))),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {},
                              controller: _emailTextController,
                              focusNode: _passFocusNode,
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return "Vui lòng nhập mật khẩu hợp lệ";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(
                                      _obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.amber.shade700,
                                    ),
                                  ),
                                  hintText: "Nhập mật khẩu (tối thiểu 6 ký tự)",
                                  hintStyle: TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber.shade700),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700))),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Quên mật khẩu?",
                            style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 18,
                            ),
                          )),
                    ),
                    SizedBox(height: 15),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStateProperty.all(Size(280, 50)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.amber.shade700),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)))),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: const BottomBar(),
                                        type: PageTransitionType.fade));
                              },
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 21),
                              )),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              TextWidget(
                                text: 'hoặc đăng nhập bằng',
                                color: Colors.white,
                                textSize: 16,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              const Expanded(
                                child: Divider(
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 200,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Bạn chưa có tài khoản?",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.amber.shade700,
                                  fontSize: 19,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
          )
              ],
            ),
        ));
  }
}
