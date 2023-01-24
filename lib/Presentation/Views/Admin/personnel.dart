import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/usersConstructors.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class PersonnelLog extends StatelessWidget {
  const PersonnelLog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const UsersConstructors(
            companyName: "Sure move Logistics",
            fullName: "Amazing\ngrace",
            phoneNumber: "+24345443434",
            dateString: "",
            profileImage: "",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                YesOrNo(title: "Block",tapStudiesButton: (){},),
                YesOrNo(title: "Remove",tapStudiesButton: (){},color: kRedColor,),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
