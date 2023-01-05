import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/earningConstructors.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/headers.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order history".toUpperCase())),
      body: CustomScrollView(
          slivers: <Widget>[
        const SliverAppBar(
          backgroundColor: kWhiteColor,
        snap: false,
        pinned: true,
        floating: false,
          flexibleSpace: Center(child: AnalysisHeaders()),
       ),
    SliverList(
    delegate: SliverChildListDelegate([
      Column(
        children: [
          spacing(),
          Card(
            child: Column(children:  [
              EarningConstructor(
                dateString: "2022-10-24 11:48:43.399356",
                itemSize: "23",
                itemQuantity: "4",
                itemName: "Rice",
                company: "Sure move logistics",
                paymentMethod: "Card",
                deliveryFee: "4094",
                total: "43434",

              )
            ],),
          )
        ],
      ),

      ]))

      ]),
    );
  }
}
