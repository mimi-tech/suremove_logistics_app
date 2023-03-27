import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/allEarnings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/dailyEarning.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/monthlyEarnings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/weeklyEarnings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/yearlyEarnings.dart';
class TotalEarningsTab extends StatefulWidget {
  const TotalEarningsTab({Key? key}) : super(key: key);

  @override
  State<TotalEarningsTab> createState() => _TotalEarningsTabState();
}

class _TotalEarningsTabState extends State<TotalEarningsTab>with TickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.animateTo(0);
  }
  static const List<Tab> _tabs = [
    Tab(child:Text("All")),
    Tab(child:Text(kToday)),
    Tab(child:Text(kWeekly)),
    Tab(child:Text(kMonthly)),
    Tab(child:Text(kYearly)),
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
        title: const Text(kMyEarnings),

      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AllEarnings(),
          AllDailyEarnings(),
          AllWeeklyEarnings(),
          AllMonthlyEarnings(),
          AllYearlyEarnings(),
        ],
      ),


    );
  }
}
