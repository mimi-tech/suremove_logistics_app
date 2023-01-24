import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sure_move/Presentation/utils/enums.dart';

Widget space()=>SizedBox(height: 60.0.h);
Widget spacing()=>SizedBox(height: 20.0.h);

class RegConstants{
  String? email;
  String? username;
  String? password;
  String? cPassword;
  String? referralId;
  String? txnPin;
  String? firstname;
  String? lastname;
  String? phoneNumber;
  String? profileImageUrl;
  Gender? gender;
}

class BookingConstants{
  String? customerSourceAddress;
}