import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class BlockAccount extends StatefulWidget {
  const BlockAccount({Key? key}) : super(key: key);

  @override
  State<BlockAccount> createState() => _BlockAccountState();
}

class _BlockAccountState extends State<BlockAccount> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin),
      child: Column(
        children: [
          spacing(),
          Text(kBlockUser.toUpperCase(),style: Theme.of(context).textTheme.caption,),
          spacing(),
          const Text(kBlockUserText,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500),),
          spacing(),
         loading?Center(child: CircularProgressIndicator(),): Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              YesOrNo(title: kNo,tapStudiesButton: (){},color: kRadioColor,),
              YesOrNo(title: kYes,tapStudiesButton: () async {
                setState(() {
                  loading =!loading;
                });
               var result = await UserBloc().onAccountStatus("deactivate",context);
                setState(() {
                  loading =!loading;
                });
                 Navigator.pop(context);
                 Navigator.pop(context);
                ScaffoldMsg().successMsg(context, result);
              },),
            ],
          ),
          spacing(),
        ],
      ),
    ));
  }
}
