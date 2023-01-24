import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/Commons/colors.dart';
import 'package:sure_move/Presentation/Views/Admin/Analysis/analysisData.dart';
import 'package:sure_move/Presentation/Views/Admin/Analysis/analysisHeader.dart';
class TodayAnalysis extends StatefulWidget {
  const TodayAnalysis({Key? key}) : super(key: key);

  @override
  State<TodayAnalysis> createState() => _TodayAnalysisState();
}

class _TodayAnalysisState extends State<TodayAnalysis> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
   const  AnalysisHeader(todayColor: kOrangeColor,),
    SliverList(
    delegate: SliverChildListDelegate([
    ListView.builder(
      shrinkWrap: true,
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
   return  Card(
     child: AnalysisData(
      dateString: "2022-10-24 11:48:43.399356",
      companyFee: "89098",
      itemQuantity: "7",
      partnerFee: "76766",
      paymentMethod: "Card",
      deliveryFee: "8789",
      total: "987987",
      ownerFee: "8767"),
   );
    })
      ])
    )]);
  }
}
