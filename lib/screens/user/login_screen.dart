import 'package:InventorPlus/consts/firebase_consts.dart';
import 'package:InventorPlus/loading_screen.dart';
import 'package:InventorPlus/screens/user/forget_pass.dart';
import 'package:InventorPlus/screens/user/register_screen.dart';
import 'package:InventorPlus/services/global_metthods.dart';
import 'package:InventorPlus/ui/bottom_bar.dart';
import 'package:InventorPlus/ui/loading_manager.dart';
import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
import 'package:InventorPlus/ui/widgets/auth_button.dart';
import 'package:InventorPlus/ui/widgets/back_widget.dart';
import 'package:InventorPlus/ui/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';
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
    void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoadingScreen(),
          ),
        );
        print('Đăng nhập thành công');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
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
    return Scaffold(
        body: LoadingManager(
      isLoading: _isLoading,
      child: Stack(
        children: [
         // const AnimationBackground(),
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
                    const SizedBox(height: 45),
                    const BackWidget(),
                    const SizedBox(
                      height: 35,
                    ),
                    TextWidget(
                      text: "Thật tuyệt khi bạn trở lại!",
                      textSize: 31,
                      color: Colors.white,
                      isBold: true,
                    ),
                    const SizedBox(height: 15),
                    TextWidget(
                      text: "Đăng nhập để tiếp tục",
                      color: Colors.amber.shade700,
                      textSize: 21,
                    ),
                    const SizedBox(
                      height: 70.0,
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
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Nhập Email (ex: abc@gmail.com)",
                                  hintStyle: const TextStyle(color: Colors.white),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.amber.shade700),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700))),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {},
                              controller: _passTextController,
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
                              style: const TextStyle(color: Colors.white),
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
                                    borderSide: BorderSide(
                                        color: Colors.amber.shade700),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.amber.shade700))),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context,
                            routeName: ForgetPasswordScreen.routeName);
                      },
                      child:  Text(
                        'Quên mật khẩu?',
                        style: TextStyle(
                              color: Colors.amber.shade700,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ),
                
                    const SizedBox(height: 28),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          AuthButton(fct: _submitFormOnLogin, buttonText: "Đăng nhập"),
                          const SizedBox(
                            height: 185,
                          ),
                          RichText(
                              text: TextSpan(
                                  text: 'Bạn chưa có tài khoản?',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                  children: [
                                TextSpan(
                                    text: ' Đăng ký',
                                    style: TextStyle(
                                        color: Colors.amber.shade700,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        GlobalMethods.navigateTo(
                                            ctx: context,
                                            routeName:
                                                RegisterScreen.routeName);
                                      }),
                              ]))
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
