import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class AddNewCompany extends StatefulWidget {
   AddNewCompany({Key? key}) : super(key: key);

  @override
  State<AddNewCompany> createState() => _AddNewCompanyState();
}

class _AddNewCompanyState extends State<AddNewCompany> {
  Color btnColor = kTextFieldBorderColor;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _companyName = TextEditingController();

  final TextEditingController _bykeCount = TextEditingController();

  final TextEditingController _driversCount = TextEditingController();

  final TextEditingController _address = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;

  String? bykeCount;

  String? driversCount;

  String? address;

  String? companyName;

   CompanyOwner _owner = CompanyOwner.yes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("Create Company".toUpperCase()),),
       body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: kMargin),
            child: Column(
              children: [

                spacing(),


                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      spacing(),
                       Text("Enter the email address of the company owner",style: Theme.of(context).textTheme.subtitle2,),
                      TextFormField(
                        controller: _email,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.emailAddress,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateEmail,
                        decoration: const InputDecoration(
                          hintText: kEmail2,

                        ),
                        onSaved: (String? value) {
                          email = value!;
                        },
                      ),

                      spacing(),
                       Text("Company name",style: Theme.of(context).textTheme.subtitle2,),
                      TextFormField(
                        controller: _companyName,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateField,
                        decoration: const InputDecoration(
                          hintText: "Company name",

                        ),
                        onSaved: (String? value) {
                          companyName = value!;
                        },
                      ),

                      spacing(),
                       Text("How many drivers do you have",style: Theme.of(context).textTheme.subtitle2,),
                      TextFormField(
                        controller: _driversCount,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateField,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: "Driver's count",

                        ),
                        onSaved: (String? value) {
                          driversCount = value!;
                        },
                      ),

                      spacing(),
                       Text("Please enter the number of bike you have",style: Theme.of(context).textTheme.subtitle2,),
                      TextFormField(
                        controller: _bykeCount,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText1,
                        validator: Validator.validateField,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],

                        decoration: const InputDecoration(
                          hintText: "Bike number",

                        ),
                        onSaved: (String? value) {
                          bykeCount = value!;
                        },
                      ),

                      spacing(),
                       Text("Enter company address",style: Theme.of(context).textTheme.subtitle2,),
                      TextFormField(
                        controller: _address,
                        autocorrect: true,
                        autofocus: true,
                        cursorColor: (kOrangeColor),
                        keyboardType: TextInputType.text,
                        style: Theme.of(context).textTheme.bodyText1,

                        validator: Validator.validateField,
                        decoration: const InputDecoration(
                          hintText: "Company address",

                        ),
                        onSaved: (String? value) {
                          address = value!;
                        },
                      ),

                    ],
                  ),
                ),
                spacing(),
                Column(

                  children: <Widget>[
                    Text("Are you the owner of this company?",style: Theme.of(context).textTheme.subtitle2,),
                    ListTile(
                      title: const Text('Yes'),
                      leading: Radio<CompanyOwner>(
                        value: CompanyOwner.yes,
                        groupValue: _owner,
                        onChanged: (CompanyOwner? value) {
                          setState(() {
                            _owner = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('No'),
                      leading: Radio<CompanyOwner>(
                        value: CompanyOwner.no,
                        groupValue: _owner,
                        onChanged: (CompanyOwner? value) {
                          setState(() {
                            _owner = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                spacing(),
                spacing(),

                spacing(),
                GeneralButton(tapStudiesButton: (){
                  Navigator.pushNamed(context, registrationScreen2);
                },title: "Register",)

              ],
            ),
          ),
        ));

  }
}
