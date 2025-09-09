import 'package:flutter/material.dart';

class MycartPage extends StatefulWidget {
  const MycartPage({super.key});

  @override
  State<MycartPage> createState() => _MycartPageState();
}

class _MycartPageState extends State<MycartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Cart Page"),),
    );
  }
}
