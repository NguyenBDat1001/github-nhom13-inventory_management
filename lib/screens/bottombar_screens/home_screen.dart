import 'package:InventorPlus/ui/widgets/animation_background_widget.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
         children: [
         const  AnimationBackground(),
           Container(
            color: Colors.black.withOpacity(0.2),
          ),
          Center(
            child: TextWidget(text: "Ứng dụng đang trong giai đoạn phát triển", textSize: 20, color: Colors.amber.shade700,textWeight: FontWeight.w600),
          )
         ],
        ));
  }
}
