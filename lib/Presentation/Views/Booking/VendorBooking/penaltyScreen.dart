import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sure_move/Logic/Authentication/authBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/UsersLogic/userEvent.dart';
import 'package:sure_move/Logic/UsersLogic/userState.dart';
import 'package:sure_move/Models/driversModel.dart';
import 'package:sure_move/Models/userModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/scaffoldMsg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/utils/enums.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
import 'package:sure_move/Providers/driverProvider.dart';
import 'package:sure_move/Providers/userProvider.dart';
class PenaltyScreen extends StatefulWidget {
  const PenaltyScreen({Key? key}) : super(key: key);

  @override
  State<PenaltyScreen> createState() => _PenaltyScreenState();
}

class _PenaltyScreenState extends State<PenaltyScreen> {
  @override
  Widget build(BuildContext context) {
    DriverModel driver = Provider.of<DriverProvider>(context).driver;
    NewUser user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        appBar: AppBar(title: const Text("Rejections"),),
        body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) async {

      if(state is UserDataSuccess){
        Provider.of<UserProvider>(context,listen: false).setUser(state.data[0]);
        Navigator.pushNamedAndRemoveUntil(context, homePage, (route) => false);
       ScaffoldMsg().successMsg(context, state.message[0]);
      }
      if(state is UserDenied){
        ScaffoldMsg().errorMsg(context, state.errors[0]);
      }

    },
    builder: (context, state) {

    return ModalProgressHUD(
      inAsyncCall: (state is UserLoading)?true:false,
      child: SingleChildScrollView(
        child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(

                children: [
                  space(),
                  Center(child: ProfilePicture(image: user.accountType == AccountType.driver.name?driver.profileImageUrl:user.profileImageUrl,)),

               Text("${user.firstName} ${user.lastName} ".toUpperCase(),style: Theme.of(context).textTheme.subtitle1,),

                  user.accountType == AccountType.driver.name?
                  Text("${driver.companyName} driver")
                :Text(""),
                 space(),
                  Text(kPenalty,textAlign: TextAlign.center,),


                  space(),

                  user.isActive == false?
                  GeneralButton(title: "Activate", tapStudiesButton: (){
                    BlocProvider.of<UserBloc>(context).add(AccountStatusRequested("deactivate"));

                  })
                      :GeneralButton(title: kSupport, tapStudiesButton: (){
                    Navigator.pushReplacementNamed(context, supportScreen);
                  })
        ]),
            ),
      ),
    );
    }));
  }
}
