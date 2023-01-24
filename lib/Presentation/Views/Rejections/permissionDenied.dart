import 'package:flutter/material.dart';
class PermissionDeniedScreen extends StatefulWidget {
  const PermissionDeniedScreen({Key? key}) : super(key: key);

  @override
  State<PermissionDeniedScreen> createState() => _PermissionDeniedScreenState();
}

class _PermissionDeniedScreenState extends State<PermissionDeniedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Rejection".toUpperCase())),
        body: Container(
      child: Text("Permission rejection"),
    ));
  }
}
