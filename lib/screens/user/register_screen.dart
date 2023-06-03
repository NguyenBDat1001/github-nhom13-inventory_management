import 'package:InventorPlus/screens/user/login_screen.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/services/utils.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
import 'package:InventorPlus/ui/widgets/auth_button.dart';
import 'package:InventorPlus/ui/widgets/back_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
/*   void submitFormOnRegister() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }
  }
 */
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
          isLoading: _isLoading,
          child: Stack(
            children: <Widget>[
               const AnimationBackground(),
              Container(
                color: Colors.black.withOpacity(0.2),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(height: 45),
                    const BackWidget(),
                    const SizedBox(
                      height: 35,
                    ),
                    TextWidget(
                      text: "Xin chào",
                      textSize: 37,
                      color: Colors.white,
                      isBold: true,
                    ),
                    const SizedBox(height: 8),
                    TextWidget(
                      text: "đăng kí tài khoản để tiếp tục",
                      color: Colors.amber.shade700,
                      textSize: 21,
                    ),
                    const SizedBox(height: 30),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            // tên người dùng
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_emailFocusNode),
                              keyboardType: TextInputType.name,
                              controller: _fullNameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Không được bỏ trống";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Nhập Tên người dùng',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            // email
                            TextFormField(
                              focusNode: _emailFocusNode,
                              textInputAction: TextInputAction.next,
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_passwordFocusNode),
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailTextController,
                              validator: (value) {
                                if (value!.isEmpty || !value.contains("@")) {
                                  return "Vui lòng nhập email hợp lệ";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Nhập Email (ex: abc@gmail.com)',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 22,
                            ),
                            // mật khẩu
                            TextFormField(
                              focusNode: _passwordFocusNode,
                              obscureText: _obscureText,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordTextController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 7) {
                                  return "Vui lòng nhập mật khẩu hợp lệ";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              onEditingComplete: () => FocusScope.of(context)
                                  .requestFocus(_addressFocusNode),
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
                                hintText: 'Nhập mật khẩu (tối thiểu 6 ký tự)',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // địa chỉ kho
                            TextFormField(
                              focusNode: _addressFocusNode,
                              textInputAction: TextInputAction.done,
                              // onEditingComplete: _submitFormOnRegister,
                              controller: _addressTextController,
                              validator: (value) {
                                if (value!.isEmpty || value.length < 10) {
                                  return "Vui lòng nhập một địa chỉ hợp lệ";
                                } else {
                                  return null;
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                              textAlign: TextAlign.start,
                              decoration: InputDecoration(
                                hintText: 'Địa chỉ kho hàng',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.amber.shade700),
                                ),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Bằng cách nhấp vào đăng ký bên dưới, tài khoản của bạn sẽ được tạo thành công",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            AuthButton(
                              buttonText: 'Đăng ký',
                              fct: () {},
                            ),
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
    );
  }
}
