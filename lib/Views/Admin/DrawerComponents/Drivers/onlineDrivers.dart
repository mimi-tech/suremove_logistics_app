import 'package:flutter/material.dart';
import 'package:sure_move/Views/Admin/Widgets/usersConstructors.dart';
class OnlineDrivers extends StatelessWidget {
  const OnlineDrivers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(
        children: const [
          UsersConstructors(
            companyName: "Sure move Logistics",
            fullName: "Amazing grace",
            phoneNumber: "+24345443434",
            dateString: "",
            profileImage: "",
          ),
        ],
      ),
    );
  }
}
