import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Commons/constants.dart';
import 'package:sure_move/Presentation/Commons/dimens.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/earningConstructors.dart';
import 'package:sure_move/Presentation/Views/Dashboard/Widgets/headers.dart';
class AllEarnings extends StatefulWidget {
  const AllEarnings({Key? key}) : super(key: key);

  @override
  State<AllEarnings> createState() => _AllEarningsState();
}

class _AllEarningsState extends State<AllEarnings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const AnalysisHeaders(),),
      body: SingleChildScrollView(
        child: Container(
          //margin: EdgeInsets.symmetric(horizontal: kMargin2),
          child: Column(
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
        ),
      ),
    );
  }
}
