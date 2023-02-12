import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/ProviderViewModel/userNotifier.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class CapturingScreen extends StatefulWidget {
  const CapturingScreen({Key? key}) : super(key: key);

  @override
  State<CapturingScreen> createState() => _CapturingScreenState();
}

class _CapturingScreenState extends State<CapturingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserNotifier().openCamera();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(kCreateDriverAccount.toUpperCase()),),

        body:  Consumer<UserNotifier>(
        builder: (context, modal, child) {
      return Container(
        child: modal.imagePath == null? Container(
          width: 300,
          height: 300,
          color: Colors.grey[300]!,
        )
            :CircleAvatar(
            radius: 60,
            backgroundColor: Colors.transparent,
            child: ClipOval(
                child: Image.file(File(modal.imagePath!),
                  height: 200.h,
                  width: 200.w,

                  fit: BoxFit.cover,
                ))),
      );
      }));
    }
}
