
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Providers/userProvider.dart';
import 'package:sure_move/Services/userServices.dart';

class UsersData extends StatefulWidget {
  const UsersData({Key? key}) : super(key: key);

  @override
  State<UsersData> createState() => _UsersDataState();
}

class _UsersDataState extends State<UsersData> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();

  Gender _gender = Gender.female;
@override
  void initState() {
    // TODO: implement initState
  NewUser user = Provider.of<UserProvider>(context,listen: false).user;
  _fName.text = user.firstName!;
  _lName.text = user.lastName!;
  _email.text = user.email!;
  _username.text = user.username!;
  if(Gender.female.name == user.gender ){
    _gender = Gender.female;
  }else{
    _gender = Gender.male;
  }
    super.initState();
  }
  File? pickedFile;
  @override
  Widget build(BuildContext context) {
    NewUser user = Provider.of<UserProvider>(context).user;

    return Scaffold(

        body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {

      if(state is UserDataSuccess){
        ScaffoldMsg().successMsg(context, state.message[0]);
        Provider.of<UserProvider>(context,listen: false).setUser(state.data[0]);
        Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
      }
      if(state is UserDenied){
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }
      if(state is FileUploadedSuccess){
        BlocProvider.of<UserBloc>(context).add(UserUpdateProfileRequested(
            user.email!,
            _username.text.trim(),
            user.profileImageUrl!,
            _fName.text,
            _lName.text,
            _gender.name
        ));
      }
    if(state is UserSuccess){
      BlocProvider.of<UserBloc>(context).add(UserUploadFileRequested(pickedFile!));
    }
    if(state is UserImageDeletedDenied){
      BlocProvider.of<UserBloc>(context).add(UserUploadFileRequested(pickedFile!));
      ScaffoldMsg().errorMsg(context, state.errors[0]);
    }
    },
    builder: (context, state) {

    return ModalProgressHUD(
      inAsyncCall: (state is UserLoading)?true:false,
      child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                children: [
                  spacing(),
                  pickedFile == null? ProfilePicture(image: user.profileImageUrl,):Image.file(pickedFile!),


                  //user.accountType == AccountType.driver.name?Text("")
                      GestureDetector(
                      onTap: () async {
                     var result = await  UserBloc().pickFile();
                      if(result != null){
                        setState(() {
                          pickedFile = result;
                        });
                      }else{
                        setState(() {
                          pickedFile = null;
                        });
                      }
                      },
                      child: pickedFile == null?Text("Edit Photo [Optional]",style: Theme.of(context).textTheme.headline6,)
                          :GestureDetector(
                          onTap: (){setState(() {
                            pickedFile = null;
                          });},
                          child: Text("Cancel",style: Theme.of(context).textTheme.bodyText2,))),
                  spacing(),

                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        spacing(),
                       const Text(kFName),
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
                            RegConstants().firstname = value!;
                          },
                        ),

                        spacing(),
                        const Text(kLName),

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
                            RegConstants().lastname = value!;
                          },
                        ),


                        spacing(),
                        const Text(kUsername2),
                        TextFormField(
                          controller: _username,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.sentences,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateUsername,
                          decoration: const InputDecoration(
                            hintText: kUsername2,

                          ),
                          onSaved: (String? value) {
                            RegConstants().username = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                  spacing(),

                  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const  Text("Gender"),
                      ListTile(
                        title: const Text('Male'),
                        leading: Radio<Gender>(
                          value: Gender.male,
                          groupValue: _gender,
                          onChanged: (Gender? value) {
                            setState(() {
                              _gender = value!;
                              RegConstants().gender = _gender;
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
                              RegConstants().gender = _gender;
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
                      if(pickedFile == null){
                        BlocProvider.of<UserBloc>(context).add(UserUpdateProfileRequested(
                          user.email!,
                          _username.text.trim(),
                          user.profileImageUrl!,
                          _fName.text,
                          _lName.text,
                          _gender.name.toLowerCase()
                        ));
                      }else{
                       //UserServices.uploadImage(file: pickedFile!.path);
                        BlocProvider.of<UserBloc>(context).add(UserDeleteFileRequested(user.profileImageUrl));

                      }


                  },title: kUpdate,)

                ],
              ),
            ),
          ),
    );
          }));
  }
}
