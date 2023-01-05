import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Views/Admin/Users/addOrMinusFunds.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/usersConstructors.dart';
import 'package:sure_move/Presentation/utils/generalButton.dart';
class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    const UsersConstructors(
                      companyName: "",
                      fullName: "Amazing\ngrace",
                      phoneNumber: "+24345443434",
                      dateString: "",
                      profileImage: "",
                    ),
                    Spacer(),
                    YesOrNo(title: "Block",tapStudiesButton: (){},)
                  ],
                ),

                Row(
                  children: [
                    IconButton(onPressed: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => const AddOrMinusFunds()
                      );
                    }, icon: Icon(Icons.remove)),
                    Text("344",style: Theme.of(context).textTheme.headline5,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.add)),

                  ],
                )
              ],
            ),
          ),
        ));
  }
}
