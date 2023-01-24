import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Admin/Analysis/today.dart';
import 'package:sure_move/Presentation/Views/Admin/Users/allUsers.dart';
import 'package:sure_move/Presentation/Views/Admin/Widgets/adminDrawer.dart';
import 'package:sure_move/Presentation/Views/Admin/home.dart';
import 'package:sure_move/Presentation/Views/Admin/personnel.dart';
import 'package:sure_move/Presentation/Views/Admin/search.dart';

class AdminTab extends StatefulWidget {
  const AdminTab({Key? key}) : super(key: key);

  @override
  State<AdminTab> createState() => _AdminTabState();

}

class _AdminTabState extends State<AdminTab> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    CallsPage(),
     SearchUsers(),
    AllUsers()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        title: const Text(kAppTitle),
        elevation: 0,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Users',
          ),

        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CallsPage extends StatelessWidget {
  const CallsPage({Key? key}) : super(key: key);

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
                  Tab(child: Text("A-Z"),),
                  Tab(child: Text("Activity"),),
                  Tab(child: Text("Admin log"),),
                ],
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
             AdminHome(),
            TodayAnalysis(),
            PersonnelLog(),
          ],
        ),
      ),
    );
  }
}
