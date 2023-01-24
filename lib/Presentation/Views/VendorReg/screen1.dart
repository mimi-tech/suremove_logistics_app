import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class PickCompany extends StatelessWidget {
  const PickCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text(kVendorReg.toUpperCase()),),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kMargin),
          child: Column(
            children: [
              spacing(),
              Center(child: Text("Please select a company you want to work under".toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,)),
              spacing(),
    ListView.builder(
    shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: Text("${index + 1}"),
        title: Text(kAppTitle),
        trailing: IconButton(onPressed: (){}, icon: Icon(Icons.radio_button_off)),
      );
    }),

              GeneralButton(title: kNextBtn, tapStudiesButton: (){
                Navigator.pushNamed(context, licenceScreen);
              })
            ],
          ),
        ),
      ),
    );
  }
}
