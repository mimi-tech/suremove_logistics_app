import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';

class RegistrationScreen1 extends StatefulWidget {
  const RegistrationScreen1({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen1> createState() => _RegistrationScreen1State();
}

class _RegistrationScreen1State extends State<RegistrationScreen1> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Gender _gender = Gender.male;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),
        body: SingleChildScrollView(
          child: Container(
    margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
          children: [
            pickedImage == null? SvgPicture.asset('assets/user.svg'):
            CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                    child: Image.file(pickedImage!,
                      height: 200.h,
                      width: 200.w,

                      fit: BoxFit.cover,
                    ))),

            GestureDetector(
                onTap: () async {
                  var result = await  UserBloc().pickFile();
                  if(result != null){

                    setState(() {
                      pickedImage = result;
                    });
                  }else{
                    setState(() {
                      pickedImage = null;
                    });
                  }
                },
                child: pickedImage == null?Text("Add Photo [Optional]",style: Theme.of(context).textTheme.headline6,)
                :GestureDetector(
                    onTap: (){setState(() {
                      pickedImage = null;
                    });},
                    child: Text("Cancel",style: Theme.of(context).textTheme.bodyText2,))),
            spacing(),
            const Text(kName),
            spacing(),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  spacing(),

                  TextFormField(
                    controller: _fName,
                    autocorrect: true,
                    autofocus: true,
                    cursorColor: (kOrangeColor),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: Validator.validateFirstName,
                    decoration: const InputDecoration(
                      hintText: kFName,

                    ),
                    onSaved: (String? value) {
                      firstname = value!;
                    },
                  ),

                  spacing(),

                  TextFormField(
                    controller: _lName,
                    autocorrect: true,
                    autofocus: true,
                    cursorColor: (kOrangeColor),
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    style: Theme.of(context).textTheme.bodyText1,
                    validator: Validator.validateLastName,
                    decoration: const InputDecoration(
                      hintText: kLName,

                    ),
                    onSaved: (String? value) {
                      lastname = value!;
                    },
                  ),

                ],
              ),
            ),
            spacing(),
              Column(

                children: <Widget>[
                  ListTile(
                    title: const Text('Male'),
                    leading: Radio<Gender>(
                      value: Gender.male,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value!;
                          gender = _gender;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Female'),
                    leading: Radio<Gender>(
                      value: Gender.female,
                      groupValue: _gender,
                      onChanged: (Gender? value) {
                        setState(() {
                          _gender = value!;
                          gender = _gender;
                        });
                      },
                    ),
                  ),
                ],
              ),
            spacing(),
            GeneralButton(tapStudiesButton: (){
              final form = _formKey.currentState;

              if (form!.validate()) {
                form.save();
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }}
              Navigator.pushNamed(context, registrationScreen2);
            },title: kNextBtn,)

          ],
      ),
    ),
        ));
  }
}
