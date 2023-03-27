import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/Authentication/authEvent.dart';
import 'package:sure_move/Logic/Authentication/authState.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Providers/userProvider.dart';

class RegistrationScreen3 extends StatefulWidget {
  const RegistrationScreen3({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen3> createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  Color btnColor = kTextFieldBorderColor;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _cPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: kWhiteColor,iconTheme: const IconThemeData(color: kBlackColor),),
        body: BlocConsumer<AuthBloc, AuthState>(
    listener: (context, state) async {
    if (state is AuthDenied) {
    ScaffoldMsg().errorMsg(context, state.errors[0]);
    }
    if(state is AuthSuccess){
      Provider.of<UserProvider>(context,listen: false).setUser(state.success![0]);

      Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
   ScaffoldMsg().successMsg(context,"Registration successful");

    }
    if(state is ImageUploadedSuccess){
      BlocProvider.of<AuthBloc>(context).add(AuthRegisterRequested(
        email.toString(),
        password.toString(),
        phoneNumber.toString(),
        username.toString(),
          state.data[1],
        firstname.toString(),
        lastname.toString(),
        gender!.name,
        referralId.toString(),
        txnPin.toString(),

      ));
    }
    },
    builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: (state is AuthLoading)? true:false,
      child: SingleChildScrollView(
        child: Container(
              margin: EdgeInsets.symmetric(horizontal: kMargin),
              child: Column(
                children: [
                  SvgPicture.asset('assets/unlock.svg'),
                  spacing(),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [

                        spacing(),
                        const Text(kUsername),
                        TextFormField(
                          controller: _username,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateUsername,
                          decoration: const InputDecoration(
                            hintText: kUsername2,

                          ),
                          onSaved: (String? value) {
                            username = value!;
                          },
                        ),

                        spacing(),
                        const Text(kPassword),
                        TextFormField(
                          controller: _password,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          obscuringCharacter: ".",
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateLastName,
                          decoration: const InputDecoration(
                            hintText: "Password",

                          ),
                          onSaved: (String? value) {
                            password = value!;
                          },
                        ),

                        spacing(),
                        const Text(kRePassword),
                        TextFormField(
                          controller: _cPassword,
                          autocorrect: true,
                          autofocus: true,
                          cursorColor: (kOrangeColor),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          obscuringCharacter: ".",
                          style: Theme.of(context).textTheme.bodyText1,
                          validator: Validator.validateLastName,
                          decoration: const InputDecoration(
                            hintText: "Confirm Password",

                          ),
                          onSaved: (String? value) {
                            cPassword = value!;
                          },
                        ),

                      ],
                    ),
                  ),
                  spacing(),

                  spacing(),
                   GeneralButton(tapStudiesButton:(){
                    final form = _formKey.currentState;

                    if (form!.validate()) {
                      form.save();
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      if(pickedImage == null){
                        BlocProvider.of<AuthBloc>(context).add(AuthRegisterRequested(
                          email!,
                          password!,
                          phoneNumber!,
                          username!,
                          "",
                          firstname!,
                          lastname!,
                          gender!.name,
                          referralId!,
                          txnPin!,

                        ));
                      }else{
                        BlocProvider.of<AuthBloc>(context).add(UserUploadFilesRequested(pickedImage!.path));

                      }


                    }},title:kRegister,)

                ],
              ),
            ),
      ),
    );
        }));
  }
}
