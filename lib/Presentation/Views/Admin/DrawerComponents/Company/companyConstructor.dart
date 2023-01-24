import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/phoneNumber.dart';
import 'package:sure_move/Presentation/utils/dateFormat.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
import 'package:sure_move/Presentation/utils/profilePicture.dart';
class CompanyConstructors extends StatelessWidget {
  const CompanyConstructors({Key? key,
    this.profileImage,
    this.fullName,
    this.companyName,
    this.phoneNumber,
    this.dateString,
    this.companyAddress
  }) : super(key: key);
  final String? profileImage;
  final String? fullName;
  final String? companyName;
  final String? phoneNumber;
  final String? dateString;
  final String? companyAddress;

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
              Column(
                children: [
                  Text(fullName!,style: Theme.of(context).textTheme.headline1,),
                  PhoneNumber(title: phoneNumber!,),
                ],
              ),
              Spacer(),
              YesOrNo(title: "Block",tapStudiesButton: (){},)
            ],
          ),
          Text(companyName!,style: Theme.of(context).textTheme.headline6,),
          Text(companyAddress!,style: Theme.of(context).textTheme.headline1,),

          DateFormatFunction()
        ],
      ),
    );
  }
}
