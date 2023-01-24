import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/AllPayments/allPayments.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/allEarnings.dart';
class AllPaymentTab extends StatefulWidget {
  const AllPaymentTab({Key? key}) : super(key: key);

  @override
  State<AllPaymentTab> createState() => _AllPaymentTabState();
}

class _AllPaymentTabState extends State<AllPaymentTab>with TickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
   // _tabController.animateTo(2);
  }
  static const List<Tab> _tabs = [
    Tab(child:Text("All")),
    Tab(child:Text("Successful transaction")),
    Tab(child:Text("Failed transactions")),

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
        title:  Text("All transaction".toUpperCase()),

      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AllPayments(),
          AllPayments(),
          AllPayments(),

        ],
      ),


    );
  }
}
