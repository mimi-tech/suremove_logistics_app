import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sure_move/Logic/UsersLogic/userBloc.dart';
import 'package:sure_move/Logic/sharedPreference.dart';
import 'package:sure_move/Models/notificationModel.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<dynamic>? notificationList;
  List<int> showFullText = [];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    notificationList = UserBloc().onGettingNotification();
  }
  @override
      Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(title:  Text(kMessage.toUpperCase()),),
            body: FutureBuilder(
        future: notificationList,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    if (snapshot.hasData) {
        return Column(
            children: [
              ListView.builder(
                reverse: true,
                shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                child: Card(
                   color: snapshot.data![index].read == true?kWhiteColor:kRadioColor,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10),
                      child: Column(
                        children: [
                          Text("${snapshot.data![index].day}/${snapshot.data![index].month}/${snapshot.data![index].year}",style: const TextStyle(color: kDarkRedColor),),
                          showFullText.contains(index)?
                          SizedBox(
                              width:MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){setState(() {
                                      showFullText.remove(index);
                                    });},
                                    child: RichText(

                                      text: TextSpan(
                                          text: snapshot.data![index].message.toString(),style: Theme.of(context).textTheme.bodyText1,

                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "... See less",
                                              style: Theme.of(context).textTheme.headline4!.copyWith(color: kLightBlue),
                                            ),


                                          ]

                                      ),),
                                  ),

                                ],
                              )
                          )
                              :Row(
                            children: [
                              SizedBox(
                                width:MediaQuery.of(context).size.width * 0.9,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(snapshot.data![index].message.toString(),style: Theme.of(context).textTheme.bodyText1,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,

                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () async {

                                            await UserPreferences().updateNotification( "Notification",snapshot.data![index].message );
                                            setState(() {
                                              showFullText.add(index);
                                              snapshot.data![index].read = true;
                                            });
                                            },
                                        child: Text("See more",style: Theme.of(context).textTheme.headline4!.copyWith(color: kLightBlue),))
                                  ],
                                )
                              ),




                            ],
                          ),

                        ],
                      ),
                    )),
              );
              }),
            ],
        );

    }

    if(snapshot.hasError){
      return const Text("Sorry error occurred");
    }
    return const Center(child: CircularProgressIndicator());
        }

    ));
  }
}
