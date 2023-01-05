import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Authentication/validation.dart';
class SearchUsers extends StatefulWidget {
   const SearchUsers({Key? key}) : super(key: key);

  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  final TextEditingController _searchText = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? searchText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          space(),
          Text("Search for any user",style: Theme.of(context).textTheme.bodyText1,),
          spacing(),
          Form(
              child:TextFormField(
                controller: _searchText,
                autocorrect: true,
                autofocus: true,
                cursorColor: (kOrangeColor),
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.bodyText1,
                validator: Validator.validateField,
                decoration: const InputDecoration(
                  hintText: "username",

                ),
                onSaved: (String? value) {
                  searchText = value!;
                },
              ),
          )
        ],
      ),
    ));
  }
}
