import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/phoneNumber.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class UsersConstructors extends StatelessWidget {
  const UsersConstructors({Key? key,
    this.profileImage,
    this.fullName,
    this.companyName,
    this.phoneNumber,
    this.dateString
  }) : super(key: key);
  final String? profileImage;
  final String? fullName;
  final String? companyName;
  final String? phoneNumber;
  final String? dateString;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kMargin2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               ProfilePicture(image: profileImage!),
              const  SizedBox(width: 5.0,),
              Text(fullName!,style: Theme.of(context).textTheme.headline1,)
            ],
          ),
          Text(companyName!,style: Theme.of(context).textTheme.headline6,),
           PhoneNumber(title: phoneNumber!,),
           DateFormatFunction()
        ],
      ),
    );
  }
}
