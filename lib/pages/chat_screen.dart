import 'package:flutter/material.dart';

class ShatScreen extends StatefulWidget {
  const ShatScreen({Key? key}) : super(key: key);
  static const id = "chat screen";

  @override
  State<ShatScreen> createState() => _ShatScreenState();
}

class _ShatScreenState extends State<ShatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
