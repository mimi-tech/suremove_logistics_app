import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/Views/VendorReg/capturing.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';

class CaptureDriver extends StatefulWidget {
  const CaptureDriver({Key? key}) : super(key: key);

  @override
  State<CaptureDriver> createState() => _CaptureDriverState();
}

class _CaptureDriverState extends State<CaptureDriver> {
  final TextEditingController _email = TextEditingController();
  String? email;
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;
    _email.text = user.email!;

    return Scaffold(
        appBar: AppBar(title: Text("Capturing".toUpperCase()),),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: kMargin),
          child: SingleChildScrollView(
          child: Column(
            children: [
             space(),
              Text("Are you creating a driver account for this email?",style: Theme.of(context).textTheme.subtitle1,),

              TextFormField(
                controller: _email,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyText1,
                validator: Validator.validateEmail,
                decoration: const InputDecoration(
                  hintText: kEmail,
                ),
                onSaved: (String? value) {
                  email = value!;
                },
              ),
            spacing(),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
               YesOrNo(title: kNo,tapStudiesButton: (){
                Navigator.pushNamed(context, driverEmailAddress);
               },color: kRadioColor,),
               YesOrNo(title: kYes,tapStudiesButton: (){
                 //check if email have been verified
                 if(user.isEmailVerified  == true){
                   //move to capturing
                  Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => CapturingScreen()),
                   );
                 }else{
                   BlocProvider.of<AuthBloc>(context).add(AuthSendEmailVerificationCode(user.email!,null,));

                   Navigator.pushNamed(context, verifyDriverEmailOTP);


                 }
               },)
             ],)
            ],
          ),
    ),
        ));
  }
}
