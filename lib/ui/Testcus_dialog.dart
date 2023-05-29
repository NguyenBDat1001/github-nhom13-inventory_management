import 'package:flutter/material.dart';

class HomeScrollbar extends StatelessWidget {
  const HomeScrollbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child:  Text("Scrollbar")),
        ),
        body: Scrollbar(
          thickness: 100,
          radius: const Radius.circular(100),
          child: GridView.count(
            crossAxisCount: 1,
            scrollDirection: Axis.vertical,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              Container(
                alignment: Alignment.center,
                color: Colors.blue[100],
                child: const Text("Entry A"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[300],
                child: const Text("Entry B"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[500],
                child: const Text("Entry C"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[700],
                child: const Text("Entry D"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[200],
                child: const Text("Entry E"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[400],
                child: const Text("Entry F"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[600],
                child: const Text("Entry H"),
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.blue[800],
                child: const Text("Entry G"),
              ),
            ],
          ),
        ));
  }
}
