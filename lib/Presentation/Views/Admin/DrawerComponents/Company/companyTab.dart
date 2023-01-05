import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Routes/strings.dart';
import 'package:sure_move/Presentation/Views/Admin/DrawerComponents/Company/allCompany.dart';

class CompanyTab extends StatefulWidget {
  const CompanyTab({Key? key}) : super(key: key);

  @override
  State<CompanyTab> createState() => _CompanyTabState();
}

class _CompanyTabState extends State<CompanyTab>with TickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    //_tabController.animateTo(1);
  }
  static const List<Tab> _tabs = [
    Tab(child:Text("All Companies")),
    Tab(child:Text("Blocked Companies")),
    Tab(child:Text("Company Drivers")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs:_tabs
        ),
        title: Row(
          children: [
            Flexible(child:  Text("$kAppTitle Companies")),
            GestureDetector(
                onTap: (){Navigator.pushNamed(context, addNewCompany);},
                child: SvgPicture.asset('assets/add_circle.svg',))
          ],
        ),

      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AllCompanies(),
          AllCompanies(),
          AllCompanies(),
        ],
      ),


    );
  }
}
