import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/strings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Earnings/allEarnings.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Transactions/history.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Transactions/myOrders.dart';
class TransactionTab extends StatefulWidget {
  const TransactionTab({Key? key}) : super(key: key);

  @override
  State<TransactionTab> createState() => _TransactionTabState();
}

class _TransactionTabState extends State<TransactionTab>with TickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(1);
  }
  static const List<Tab> _tabs = [
    Tab(child:Text("D/W")),
    Tab(child:Text(kpayment)),
    Tab(child:Text(kHistory)),

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
        title: const Text(kAllTrans),

      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          History(),
          MyOrdersTxn(),
          AllEarnings(),

        ],
      ),


    );
  }
}
