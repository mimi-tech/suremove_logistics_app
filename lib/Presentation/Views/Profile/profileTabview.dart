import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Views/Profile/updatePhoneNumber.dart';
import 'package:sure_move/Presentation/Views/Profile/userData.dart';

class ProfileTabs extends StatefulWidget {
  const ProfileTabs({Key? key}) : super(key: key);

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();

}

class _ProfileTabsState extends State<ProfileTabs> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile".toUpperCase()),
        elevation: 0,
      ),
      body: const ProfileTabView()

    );
  }
}

class ProfileTabView extends StatelessWidget {
  const ProfileTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              TabBar(
                tabs: [
                  Tab(child: Text("Edit Profile"),),
                  Tab(child: Text("Edit Phone Number"),),
                  Tab(child: Text("Edit email address"),),
                ],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UsersData(),
            UpdatePhoneNumber(),
            UsersData(),
          ],
        ),
      ),
    );
  }
}
